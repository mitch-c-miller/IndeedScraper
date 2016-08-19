special = Array.new
exclude = Array.new
Dir.chdir("./ParseLibrary")
File.readlines('special.txt').each do |line|
    special << line
end
File.readlines('exclude.txt').each do |line|
    exclude << line
end

puts special
puts exclude