require 'rubygems'
require 'mechanize'
require 'open-uri'

# order of operations
# 1. instantiate class
# 2. class opens assigned link based on search for link title
  # css is not reliable
# 3. scrape page
class JobPostingPage
  def get_url(setup_url, link_title, mech_agent, out)
    # initial page setup
    page = mech_agent.get(setup_url)
    @current_page = mech_agent.page.uri

    # clicks page
    begin
      mech_agent.current_page.link_with(:text => link_title).click      
      @posting_page = mech_agent.page.uri
      out.puts @posting_page
    rescue
      # caused by regex error; usually due to french accents
      out.puts "Clicking Error"
    end
    out.puts ""
  end
end