require 'rubygems'
require 'mechanize'
require 'open-uri'
require 'time'

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
      # caused by regex error; usually due to french accents
      puts "Clicking Error"
    end
    puts ""
  end
end

# var init; url segments, saved cache, and loop counter setup
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
  # elsif ARGV[0].to_s == ''
    # abort "Incorrect flag 0"
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

while counter <= 2
  url = "http://www.indeed.ca/jobs?q=" << job_title_search << "&l=" << job_location << ",+ON&start=" << (counter * 20).to_s
  doc = Nokogiri::HTML(open(url))

  # init mechanize for each new page of results
  page = agent.get(url)
  current_page = agent.page.uri

  # scraping segment; gets job title and company; outputs to console
  doc.css(".result").each do |item|
    job_title = item.at_css(".jobtitle").text[/[^\s][a-zA-Z0-9 -.\/\–\\]*/]
    job_company = item.at_css(".company").text[/[^\s][a-zA-Z0-9 -.\/ \–\\]*/]
    full_job = job_title + " - " + job_company

    # avoids redundant searches
    if cache.include?(full_job) == false
      cache << full_job
      puts "#{job_title} - #{job_company}"

      job_link = JobPostingPage.new
      job_link.get_url(url, job_title, agent)
    end
  end
  counter += 1
end