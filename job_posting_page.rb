# require './indeed_post_parse'
require 'mechanize'
require 'rubygems'
require 'open-uri'

# order of operations
# 1. instantiate class
# 2. class opens assigned link based on search for link title
  # css is not reliable
# 3. scrape page
class JobPostingPage
  def get_url(url, link, agent, output)
    # initial page setup
    page = agent.get(url)
    @current_page = agent.page.uri

    # clicks page
    begin
      agent.current_page.link_with(:text => link).click      
      @posting_page = agent.page.uri
      output.puts @posting_page
    rescue
      # caused by regex error; usually due to french accents
      output.puts "Clicking Error"
    end
    output.puts ""
  end

  # fitler_in - if #X detected, mark posting as high priority
  # filter_out - if #Y detected, remove posting
  def parse(filter_in, filter_out)
    
  end

end