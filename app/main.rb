BUILTINS = [
    "echo",
    "exit",
    "type"
]

def command?(name)
  `which #{name}`
  $?.success?
end

while true
    # Show the prompt
    $stdout.write("$ ")
    # Wait for user input
    command, *args = gets.chomp.split(" ")

    case command
    when "type"
        if(BUILTINS.include? args[0])
            puts "#{args[0]} is a shell builtin"            
        else
            if command?(args[0])
                "#{args[0]} is " + `which #{args[0]}`.chomp
            else
                puts "#{args[0]}: not found"
            end
        end
    when "exit"
        puts "#{exit} #{args[0]}"
    when "echo"
        puts args.join(" ")
    else
        puts "#{command}: command not found"        
    end
end