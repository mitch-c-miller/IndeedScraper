require 'rubygems'
require 'nokogiri'
require 'open-uri'

# add CLI args to allow for more specific 

# search_title == ""
# ARGV.each do |arg|
#   if ARGV[0] == "sd"
#     search_title == "software+developer"
#   elsif ARGV[1] == "jd"
#     search_title == "junior+developer"
#   else
#     abort "Incorrect input"
#   end
# end

counter = 0
cache = Array.new

while counter <= 100
  url = "http://www.indeed.ca/jobs?q=software+development&l=Ottawa,+ON&start="+counter.to_s
  counter += 20
  doc = Nokogiri::HTML(open(url))
  doc.css(".result").each do |item|
    job_title = item.at_css(".jobtitle").text[/[^\s][a-zA-Z -]*/]
    job_company = item.at_css(".company").text[/[^\s][a-zA-Z -]*/]
    # job_link = item.at_css(".jobtitle .turnstileLink")['href']
    # doc.xpath('//div[@id="block"]/a/@href').first.value

    job_link = doc.xpath('//div[@class="jobtitle"]/a/@href').value

    puts "#{job_link}"
    full_job = job_title + " - " + job_company
      
    if cache.include?(full_job) == false
      cache << full_job
      # puts "#{job_title} - #{job_company}"
    end

  end

  puts ""
end