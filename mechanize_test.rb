require 'rubygems'
require 'mechanize'

search_terms =  ['steve jobs', 'henry ford', 'andrew carnegie']

# mechanize setup
agent = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
}

# page setup
page = agent.get('https://www.wikipedia.org/')
search_form = page.form(:action => '//www.wikipedia.org/search-redirect.php')

# search form use
# search_form.search = 'Steve Jobs'
# results = agent.submit(search_form, search_form.button('go'))

# nokogiri scrape
search_terms.each do |term|
  search_form.search = term
  results = agent.submit(search_form, search_form.button('go'))
  html_results = Nokogiri::HTML(results.body)
  
  current_page = agent.page.uri

  puts html_results.at_css('#firstHeading').text
  puts current_page

  # don't forget the agent when using this part
  agent.current_page.link_with(:class => 'mw-wiki-logo').click
  current_page = agent.page.uri

  puts current_page
end
