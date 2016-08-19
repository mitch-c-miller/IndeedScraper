

class IndeedPostParse
  def parse(url)
    doc = Nokogiri::HTML(open(url))
    
  end
end