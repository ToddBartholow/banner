# Banner.py
This is a Python scraper for [Banner](http://boca.brown.edu), which is Barstow Commuinity College's course catalog and registration system. It parses data from both the catalog and the schedule into Python objects, which can then be serialized to XML or JSON with the provided convenience functions. The repo has been forked from [banner](https://github.com/evanw/banner). 

## Quick start
Create a file name config.py with the following variables:

login = "LOGIN"
password = "PASSWORD"

Where LOGIN and PASSWORD are you B# and password. 


## Dependencies
* Beautiful Soup: [http://www.crummy.com/software/BeautifulSoup/](http://www.crummy.com/software/BeautifulSoup/) (included)
* Mechanize: [http://wwwsearch.sourceforge.net/mechanize/](http://www.crummy.com/software/BeautifulSoup/) (not included)
url2lib has been modified to prevent converting URLs to lowercase. 



See `gen_quick_downloads.py` for a more complex example involving multiple semesters.
