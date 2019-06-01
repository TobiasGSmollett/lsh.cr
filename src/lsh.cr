# TODO: Write documentation for `Lsh.cr`
module Lsh
  VERSION = "0.1.0"

  BUILTIN = [
    "cd",
    "help",
    "exit"
  ]

  def self.cd(command : String, args : Array(String))
    LibC.chdir(args.first)
    return 1
  end

  def self.help(command : String, args : Array(String))
    puts "Type program names and arguments, and hit enter."
    puts "The following are built in:"
    BUILTIN.each { |builtin_name| puts "  #{builtin_name}" }
    puts "Use the man command for information on other programs."
    return 1
  end

  def self.lsh_exit
    return 0
  end

  def self.execute(command : String, args : Array(String))
    case command
    when "cd"
      cd(command, args)
    when "help"
      help(command, args)
    when "exit"
      lsh_exit
    else
      system command, args
    end
  end

  def self.loop
    loop do
      print "> "
      line = gets
      next if line.nil?
      args = line.split
      next if args.empty?
      command = args.shift
      status = execute(command, args)
      return if status == 0
    end
  end

  def self.main
    loop
  end
end

Lsh.main
