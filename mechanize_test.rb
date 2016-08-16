require 'rubygems'
require 'mechanize'

# mechanize setup
agent = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
}

# page setup
page = agent.get('https://www.wikipedia.org/')
search_form = page.form(:action => '//www.wikipedia.org/search-redirect.php')

# search form use
search_form.search = 'Steve Jobs'
results = agent.submit(search_form, search_form.button('go'))

# nokogiri scrape
html_results = Nokogiri::HTML(results.body)
puts html_results.at_css('#firstHeading').text