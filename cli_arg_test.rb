job_location = String.new
job_title_search = String.new

ARGV.each do|a|
  puts "Argument: #{a}"
end

ARGV.each do |arg|
  if ARGV[0] == "sd"
    job_title_search = "software+developer"
  elsif ARGV[0] == "jd"
    job_title_search = "junior+developer"
  else
    abort "Incorrect flag 0"
  end

  if ARGV[1] == "ot"
    job_location = "Ottawa"
  elsif ARGV[1] == "to"
    job_location = "Toronto"
  else
    abort "Incorrect flag 1"
  end
end

puts "#{job_title_search} in #{job_location}"