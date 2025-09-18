# Uncomment this block to pass the first stage
$stdout.write("$ ")

# Wait for user input
command, *args = gets.chomp.split(" ")

if command 
    puts "#{command}: command not found"
end