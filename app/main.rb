BUILTINS = [
    'echo',
    'exit',
    'type',
    'pwd',
    'cd'
]

# This function allows the shell to handle quotation marks correctly
# https://www.gnu.org/software/bash/manual/bash.html#Single-Quotes
def split_args(input)
  args = []
  buf = ""
  in_single = false

  input.each_char do |ch|
    if ch == "'" && !in_single
      in_single = true
    elsif ch == "'" && in_single
      in_single = false
    elsif ch == " " && !in_single
      args << buf unless buf.empty?
      buf = ""
    else
      buf << ch
    end
  end
  args << buf unless buf.empty?
  args
end

def check_path(executable)
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
      file = File.join(path, executable)
      return file if File.executable?(file) && !File.directory?(file)
    end
    nil
end

while true
    $stdout.write('$ ')
    input = gets.chomp
    command, *args = split_args(input)

    case command
    when 'type'
        if(BUILTINS.include? args[0])
            puts "#{args[0]} is a shell builtin"       
        else
            result = check_path(args[0])
            if result
                puts "#{args[0]} is #{result}"
            else 
                puts "#{args[0]}: not found"
            end
        end
    when 'exit'
        puts "#{exit} #{args[0]}"
    when 'echo'
        puts args.join(' ')
    when 'pwd'
        puts Dir.getwd
    when 'cd'
        begin
            if args[0] == '~'
                Dir.chdir(Dir.home)
            else
                Dir.chdir(args[0])
            end
        rescue SystemCallError
            puts "cd: #{args[0]}: No such file or directory"
        end
    else
        if(check_path(command))
            system(command, *args)
        else
            puts "#{command}: command not found"     
        end
    end
end