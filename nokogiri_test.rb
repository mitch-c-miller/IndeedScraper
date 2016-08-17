require 'rubygems'
require 'mechanize'
require 'open-uri'

# var init; url segments, saved cache, and loop counter
job_title_search = String.new
job_location = String.new
counter = 0
cache = Array.new

# mechanize setup
agent = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
}

# add CLI args to allow for more specific 
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
  
  doc = Nokogiri::HTML(open(url))
  
  # can't put in if loop to only perform once for some reason
  page = agent.get(url)
  current_page = agent.page.uri
  puts current_page

  doc.css(".result").each do |item|
    job_title = item.at_css(".jobtitle").text[/[^\s][a-zA-Z -]*/]
    job_company = item.at_css(".company").text[/[^\s][a-zA-Z -]*/]
    full_job = job_title + " - " + job_company

    agent.current_page.link_with(:class => 'jobtitle').click
    posting_page = agent.page.uri
    puts posting_page

    if cache.include?(full_job) == false
      cache << full_job
      puts "#{job_title} - #{job_company}"
    end
  end
  
  puts ""
  counter += 1
end