require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://www.indeed.ca/jobs?q=software+development&l=Ottawa%2C+ON"
doc = Nokogiri::HTML(open(url))
doc.css(".result").each do |item|
  job_title = item.css(".jobtitle").text[/[^\s][a-zA-Z -]*/]
  job_company = item.css(".company").text[/[^\s][a-zA-Z -]*/]
  puts "#{job_title} - #{job_company}"
end
