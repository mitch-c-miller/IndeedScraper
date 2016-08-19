special = Array.new
exclude = Array.new
Dir.chdir("./ParseLibrary") do
  File.readlines('special.txt').each do |line|
    special << line
  end
  File.readlines('exclude.txt').each do |line|
    exclude << line
  end
end

puts Dir.pwd

puts special
puts exclude