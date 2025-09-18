while true
    # Show the prompt
    $stdout.write("$ ")
    # Wait for user input
    command, *args = gets.chomp.split(" ")

    case command
    when "exit"
        puts "#{exit} #{args[0]}"
    when echo
        puts args.join(" ")
    else
        puts "#{command}: command not found"        
    end
end