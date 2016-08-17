require 'rubygems'
require 'mechanize'
require 'open-uri'

# order of operations
# 1. instantiate class
# 2. class opens assigned link based on search for link title
  # css is not reliable
# 3. scrape page
class JobPostingPage
  def get_url(setup_url, link_title, mech_agent)  
    # initial page setup
    page = mech_agent.get(setup_url)
    @current_page = mech_agent.page.uri

    # clicks page
    begin
      mech_agent.current_page.link_with(:text => link_title).click      
      @posting_page = mech_agent.page.uri
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

# mechanize setup
agent = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
}  

doc.css(".result").each do |item|
  job_title = item.at_css(".jobtitle").text[/[^\s][a-zA-Z0-9 -.\/ \–]*/]
  job_company = item.at_css(".company").text[/[^\s][a-zA-Z0-9 -.\/ \–]*/]
  full_job = job_title + " - " + job_company

  if cache.include?(full_job) == false
    cache << full_job
    puts "#{job_title} - #{job_company}"

    job_link = JobPostingPage.new
    job_link.get_url(url, job_title, agent)
  end
end