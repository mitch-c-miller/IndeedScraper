=begin

************************************
************IMPORTANT***************
************************************

INDEED API IS CURRENTLY BROKEN
ALL ID ARE REJECTED
TRUE FOR NEW (<24HR) AND OLD (>164HR)
REPRODUCABLE
NON-FUNCTIONAL IN RUBY OR MASHAPE

************************************
************************************

Indeed API
https://ads.indeed.com/jobroll/xmlfeed

http://api.indeed.com/ads/apisearch?
publisher=2639611490710188
      or  1873694958565343
&q=           job query
&l=           city << %2C << province
&sort=        'relevance' or 'date'
&radius=      number; default = 25
&st=          'jobsite' or 'employer'
&jt=          'fulltime', 'parttime', 'contract', 'internship', 'temporary'
&limit=       number; default 10 (set higher?)
&fromage=     number; days back to search
&filter=0     remove duplicates; leave as 0
&latlong=1    returns lat/long if 1
&co=          only support ca/us to start
&chnl=        group channel; leave blank for now
&userip=      get from user
&useragent=   get from user
&v=2
&format=      'json' or 'xml'
=end

require 'open-uri'

generated_url = 'http://api.indeed.com/ads/apisearch?
                publisher=2639611490710188
                &q=developer
                &l=toronto%2C+ontario
                &sort=date
                &radius=25
                &st=jobsite
                &jt=fulltime
                &limit=10
                &fromage=5
                &filter=0
                &latlong=1
                &co=ca
                &userip=24.137.195.226
                &useragent=Mozilla/%2F4.0%28Firefox%29
                &v=2
                &format=json'
indeed = open(generated_url)
body = indeed.read
puts body