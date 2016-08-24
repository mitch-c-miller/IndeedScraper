#README

##Job Board Scraper

###Features
* Scrapes the Indeed.ca job board based on cli args
	* Current arg 0
		* `jd` - Junior Developer
		* `sd` - Software Developer
	* Current arg 1
		* `to` - Toronto
		* `ot` - Ottawa
* Outputs job title, organization, and the link to the posting to a plaintext file
	* Date is named based on date, using the ISO-8601 standard

###Future Plans
* Scrape more job boards
	* Monster
	* Workopolis
	* Canadian Federal job board
* Parse results from main body based on words in files
	* words in `exclude.txt` will result in pages including x of them to not be saved
	* words in `special.txt` will result in pages including x of them to be specially marked

Usable under BSD-3 License. 2016-08-24
