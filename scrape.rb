require './job_posting_page'
require './file_manager'

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
# TODO: read flags from file; allows for easy editing
# when moved to webpage, will be traditional HTML form
ARGV.each do |arg|
  if ARGV[0]. == "i"
    job_board = "indeed"
  # elsif ARGV[0] == ""
  #   job_title_search = ""
  # elsif ARGV[0].to_s == ''
    # abort "Incorrect flag 0"
  else
    abort "Incorrect flag 0"
  end

  if ARGV[1]. == "sd"
    job_title_search = "software+developer"
  elsif ARGV[1] == "jd"
    job_title_search = "junior+developer"
  else
    abort "Incorrect flag 1"
  end

  if ARGV[2] == "ot"
    job_location = "Ottawa"
  elsif ARGV[2] == "to"
    job_location = "Toronto"
  else
    abort "Incorrect flag 2"
  end
end

out = FileManager.new
f = out.file_output(ARGV[0].dup, ARGV[1].dup, ARGV[2].dup)
# good = out.load_lists(true)
# bad = out.load_lists(false)

# iterates through multiple pages
while counter <= 2
  url = "http://www.indeed.ca/jobs?q=" << job_title_search << "&l=" << job_location << ",+ON&start=" << (counter * 20).to_s
  doc = Nokogiri::HTML(open(url))

  # prep mechanize for each new page of results
  page = agent.get(url)
  current_page = agent.page.uri

  # scraping segment; gets job title and company
  # TODO: replace with pure HTML and httparty
  doc.css(".result").each do |item|
    job_title = item.at_css(".jobtitle").text[/[^\s][a-zA-Z0-9 -.\/\–\\]*/]
    job_company = item.at_css(".company").text[/[^\s][a-zA-Z0-9 -.\/ \–\\]*/]
    full_job = job_title + " - " + job_company

    # avoids redundant searches
    if cache.include?(full_job) == false
      cache << full_job
      f.puts "#{job_title} - #{job_company}"

      job_link = JobPostingPage.new
      job_link.get_url(url, job_title, agent, f)
      job_link.parse(filter_in, filter_out)
    end
  end
  counter += 1
end