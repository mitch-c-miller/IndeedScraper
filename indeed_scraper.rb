require 'rubygems'
require 'nokogiri'
require 'open-uri'

# string init for cli args
job_title_search = String.new
job_location = String.new

# page result counter
counter = 0
cache = Array.new

# cli args to allow for more in-depth searches
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

while counter <= 3
  url = "http://www.indeed.ca/jobs?q=" << job_title_search << "&l=" << job_location << ",+ON&start=" << (counter * 20).to_s
  counter += 1
  doc = Nokogiri::HTML(open(url))
  doc.css(".result").each do |item|
    job_title = item.at_css(".jobtitle").text[/[^\s][a-zA-Z -]*/]
    job_company = item.at_css(".company").text[/[^\s][a-zA-Z -]*/]
    # job_link = item.xpath('//*[contains(concat( " ", @class, " " ), concat( " ", "turnstileLink", " " ))]').first.values[4]
    # job_link = item.at_css(".jobtitle").text
    # puts "#{job_link}"
    
    full_job = job_title + " - " + job_company

    if cache.include?(full_job) == false
      cache << full_job
      puts "#{job_title} - #{job_company}"
    end
  end
  # puts url

  puts ""
end