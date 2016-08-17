require 'rubygems'
require 'mechanize'
require 'open-uri'

# order of operations
# 1. instantiate class
# 2. class opens assigned link based on search for link title
  # css is not reliable
# 3. scrape page
class JobPostingPage
  
  # add resulting url
  def get_url(setup_url, link_title)
    # mechanize setup
    agent = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }  
      page = agent.get(setup_url)
      @current_page = agent.page.uri
    begin
      agent.current_page.link_with(:text => link_title).click      
      @posting_page = agent.page.uri
      puts @posting_page
    rescue
      puts "Clicking Error"
    end
    puts ""
  end
end

# var init; url segments, saved cache, and loop counter
cache = Array.new

url = "http://www.indeed.ca/jobs?q=junior+developer&l=Ottawa,+ON&start=0"

doc = Nokogiri::HTML(open(url))

# # can't put in if loop to only perform once for some reason
# page = agent.get(url)
# current_page = agent.page.uri
# puts current_page

doc.css(".result").each do |item|
  job_title = item.at_css(".jobtitle").text[/[^\s][a-zA-Z -.\/]*/]
  job_company = item.at_css(".company").text[/[^\s][a-zA-Z -.\/]*/]
  full_job = job_title + " - " + job_company

  if cache.include?(full_job) == false
    cache << full_job
    puts "#{job_title} - #{job_company}"

    job_link = JobPostingPage.new
    job_link.get_url(url, job_title)
  end
end