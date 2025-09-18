BUILTINS = [
    'echo',
    'exit',
    'type',
    'pwd'
]

def check_path(executable)
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
      file = File.join(path, executable)
      return file if File.executable?(file) && !File.directory?(file)
    end
    nil
end

while true
    # Show the prompt
    $stdout.write('$ ')
    # Wait for user input
    command, *args = gets.chomp.split(' ')

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
    else
        if(check_path(command))
            system(command, *args)
        else
            puts "#{command}: command not found"     
        end
    end
end