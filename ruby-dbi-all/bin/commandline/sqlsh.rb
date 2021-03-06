#!/usr/bin/env ruby
#
# Copyright (c) 2001, 2002 Michael Neumann <neumann@s-direktnet.de>
# 
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions 
# are met:
# 1. Redistributions of source code must retain the above copyright 
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright 
#    notice, this list of conditions and the following disclaimer in the 
#    documentation and/or other materials provided with the distribution.
# 3. The name of the author may not be used to endorse or promote products
#    derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
# THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# $Id: sqlsh.rb,v 1.3 2002/07/03 16:48:35 mneumann Exp $
#

require "dbi"
begin
  require "readline"
  $use_readline = true
rescue LoadError
  $use_readline = false
end

require "irb"
require "irb/completion"

$irb_completion = Readline.completion_proc

require "getoptlong"

class ReadlineControl
  
  attr_accessor :keywords

  def initialize
    @keywords = []
    set_prompt
    initCompletion
  end

  def initCompletion
    if $use_readline
      Readline.completion_proc = proc {|str| complete(str) }
    end
  end

  def complete(str)
    @keywords.grep(/^#{Regexp.escape(str)}/i)
  end

  def set_prompt(prompt="> ")
    @prompt = prompt
  end

  def readline
    if $use_readline 
      Readline.readline(@prompt, true)
    else
      print @prompt
      $stdin.readline
    end
  end

end

class Command
  include DBI::SQL::BasicBind

  def readCommand
    line = ""

    $rd.set_prompt(PROMPT)
    begin
      if $input.nil? 
        # no source file to read from
        l = $rd.readline
      else                   
        # source file has still data
        l = $input.gets
        if l.nil?
          $input = nil
          next
        end
      end

      next if l.strip.empty?
      l = l.chomp + "\n"
      line << l 

      puts $file + INPUT + l unless $input.nil?
      $rd.set_prompt(PROMPT_CONT)
    end until complete?(line)

    return line.strip
  end

  private

  def complete?(line)
    line =~ /^\s*\\/ or (tokens(line).last || "") =~ /;\s*$/
  end
end

class Actions
  ACTIONS = [
    [ /^\\q(uit)?\s*$/i,     :quit ],
    [ /^\\h(elp)?\s*$/i,     :help ],
    [ /^\\t(ables)?/i,       :tables ],
    [ /^\\dt/i,              :describeTable ],
    [ /^\\s(elect)?/i,       :select ],

    [ /^\\rb/i,              :ruby ],
    [ /^\\irb/i,             :irb ],

    [ /^\\c(ommit)?\s*$/i,   :commit ],
    [ /^\\r(ollback)?\s*$/i, :rollback ],
    [ /^\\a(utocommit)?(\s+(on|off)?)?\s*$/i, :autocommit ],
    [ /^\\i(nput)?/i,        :input ],
    [ /^\\o(utput)?/i,       :output ],
    [ /^\\pl/i,              :pageLength ],

    [ //,                    :unknownCommand ]
  ] 

  def dispatchCommand(line)
    ACTIONS.each do |regexp, action|
      if line =~ regexp then
        send(action, $~)
        return
      end
    end
  end

  def quit(match)
    puts
    puts "BYE"
    puts

    begin
      Conn.disconnect
    rescue DBI::Error => err
      puts
      puts err.message
      p err.backtrace if $DEBUG
      puts
    end

    exit
  end

  def help(match)
    head = %w(Function Description)
    rows = [
      ["\\h[elp]",     "Display this help screen"],
      ["", ""],

      ["\\t[ables]",   "Display all available tables"],
      ["\\dt table",   "Describe columns of 'table'"],
      ["\\s[elect] table", "short for SELECT * FROM 'table'"],

      ["", ""],
      ["\\c[ommit]",   "Commits the current transaction"],
      ["\\r[ollback]", "Rolls back the current transaction"],
      ["\\a[utocommit]", "Show current autocommit mode"],
      ["\\a[utocommit] on|off", "Switch autocommit mode on/off"],
      ["", ""],

      ["\\i[nput] filename", "Read and execute lines from 'filename'"],
      ["\\o[utput]", "Disable output"],
      ["\\o[utput] filename", "Store SQL statments the user inputs into 'filename'"],
      ["", ""],

      ["\\pl n",   "Set page length to 'n'"],
      ["", ""],
      ["\\rb ...", "Execute the rest of the line as Ruby sourcecode"],
      ["\\irb",    "Execute irb within this context"],

      ["", ""],

      ["\\q[uit]",     "Quit this program"]
    ]

    puts
    puts "Help: "
    output_table(head, rows)
    puts
  end

  def tables(match)
    head = ["Table name"]
    rows = Conn.tables.collect {|name| [name]}

    puts
    puts "Tables: "
    output_table(head, rows)
    puts
  end

  def describeTable(match)
    table = match.post_match.strip

    head = %w(name type_name precision scale default nullable indexed primary unique)

    rows = Conn.columns(table).collect {|col| head.collect{|a| col[a]} }

    puts
    puts "Table '#{table}': "
    output_table(head, rows)
    puts
  end

  def select(match)
    executeSQL("SELECT * FROM #{match.post_match};")
  end

  def commit(match)
    Conn.commit
    puts
    puts "COMMIT"
    puts
  end

  def rollback(match)
    Conn.rollback
    puts
    puts "ROLLBACK"
    puts
  end

  def autocommit(match)
    mode = match[3]
    if mode =~ /on/i
      Conn['AutoCommit'] = true
      puts
      puts "AUTOCOMMIT IS NOW ON"
      puts
    elsif mode =~ /off/i
      Conn['AutoCommit'] = false
      puts
      puts "AUTOCOMMIT IS NOW OFF"
      puts
    else
      puts
      if Conn['AutoCommit'] == true
        puts "AUTOCOMMIT is currently switched ON"
      elsif Conn['AutoCommit'] == false
        puts "AUTOCOMMIT is currently switched OFF"
      else
        puts "AUTOCOMMIT is in unknown state"
      end
      puts 
    end 
  end

  def input(match)
    puts
    $file = match.post_match.strip

    begin
      $input = File.open($file)
      puts "EXECUTE file #{$file}" 
      puts
    rescue
      puts "Couldn't read from file #{$file}"
      puts
    end
  end

  def output(match)
    puts
    file = match.post_match.strip

    if file.empty?
      $output.close if $output
      $output = nil
      puts "Disabled OUTPUT"
      puts
    else
      begin
        $output = File.new(file, "w+")
        puts "Set OUTPUT to file #{file}" 
        puts
      rescue
        puts "Couldn't set OUTPUT to file #{file}"
        puts
      end
    end
  end

  def pageLength(match)
    puts
    $page_len = match.post_match.strip.to_i
    $page_len = DEFAULT_PAGE_LENGTH if $page_len <= 0

    puts "New page length is #{$page_len}."
    puts
  end

  def irb(match)
    Readline.completion_proc = $irb_completion
    puts
    puts "================================== IRB ==============================="
    begin 
      IRB.start 
    rescue SystemExit 
    end
    puts "======================================================================"
    $rd.initCompletion
  end

  def ruby(match)
    puts
    eval match.post_match
    puts
  end

  def unknownCommand(match)
    puts
    puts "Unknown command!"
    puts
  end

end

def output_table(header, rows)
  DBI::Utils::TableFormatter.ascii(header, rows, nil, nil, nil, nil, $page_len) do   
    break if $stdin.readline.chomp == "a"
  end
end

def executeSQL(sql)
  sql = $` if sql =~ /;\s*$/

  start = ::Time.now
  stmt = Conn.execute(sql)

  head = stmt.column_names

  # DDL, DCL
  if head.empty? 
    puts
    nr = stmt.rows
    if nr == 0
      puts "  No rows affected"
    elsif nr == 1
      puts "  1 row affected"
    else 
      puts "  #{nr} rows affected"
    end
    puts
  else
    rows = stmt.fetch_all
    tm = ::Time.now - start

    puts
    output_table(head, rows || [])
    print "  "
    if rows.nil?
      print "No rows in set"
    elsif rows.size == 1
      print "1 row in set"
    else
      print "#{rows.size} rows in set"
    end

    puts " (#{(tm.to_f*1000).to_i / 1000.0} sec)"
          puts
        end

        $rd.keywords = SQL_KEYWORDS + Conn.tables
      end

DEFAULT_PAGE_LENGTH = 37 

$output     = nil
$input      = nil
$page_len   = DEFAULT_PAGE_LENGTH 
PROMPT      = "dbi => "
PROMPT_CONT = "dbi -> "
INPUT       = " >> "

SQL_KEYWORDS = %w(
  INSERT DELETE UPDATE SELECT FROM WHERE IN LIKE SET VALUES INTO
  CREATE TABLE DROP 
  COMMIT ROLLBACK
  CHAR VARCHAR VARCHAR2 INT INTEGER NUMBER FLOAT REAL LONG CLOB BLOB DECIMAL 
  DBCLOB DBBLOB
)

# ---------------------------------------------------------------------------

opts = GetoptLong.new(
  ["--file", "-f", GetoptLong::REQUIRED_ARGUMENT ]
)
opts.each do |opt, arg|
  case opt
  when "--file"
    $input_file_name = arg
  end
end

if ARGV.size < 1 or ARGV.size > 3
  puts
  puts "USAGE: #{$0} [--file file] driver_url [user [password] ]"
  puts

  puts "Available driver and datasources:"
  puts
  for driver in DBI.available_drivers do
    puts driver 
    begin
      ds = DBI.data_sources(driver)
      for datasource in ds
        puts "  " + datasource
      end
    rescue => err
    end
    puts
  end
  puts 

  exit 1
else
  DRIVER_URL = ARGV.shift
  USER       = ARGV.shift
  PASS       = ARGV.shift
end

puts
begin
  Conn = DBI.connect(DRIVER_URL, USER, PASS)
  print "CONNECT TO #{DRIVER_URL} "
  print "USER #{USER} " unless USER.nil?
  print "PASS #{PASS} " unless PASS.nil?
  print "\n"

rescue DBI::Error, DBI::Warning => err
    p err
    exit
end

puts

$rd = ReadlineControl.new
$rd.keywords = SQL_KEYWORDS + Conn.tables

cmd = Command.new
act = Actions.new

# --file option
if $input_file_name
  def $input_file_name.post_match
    $input_file_name
  end
  act.input($input_file_name) 
end

# Main-Loop -----------------------------------

loop do 
  line = cmd.readCommand

  $output.puts line unless $output.nil?

  begin
    if line =~ /^\\/ then
      # Internal Command
      act.dispatchCommand(line)
    else
      # SQL Command
      executeSQL(line)
    end
  rescue DBI::Error => err
    puts
    puts err.message
    p err.backtrace if $DEBUG
    puts
  end
end

