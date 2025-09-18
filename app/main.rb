# Uncomment this block to pass the first stage
$stdout.write("$ ")

while true
  # Wait for user input
    command, *args = gets.chomp.split(" ")

    if command 
        puts "#{command}: command not found"
    end
end