import os, subprocess
import re
import mechanize
from bs4 import BeautifulSoup

#prepare mechanize
br = mechanize.Browser()
br.set_handle_robots(False)
br.set_handle_equiv(False)
br.addheaders = [('User-agent', 'Mozilla/5.0')] 
#br.open('https://www.google.com/')
#br.open('https://selfservice.brown.edu/ss/bwckschd.p_disp_dyn_sched')
# do the query
br.open('https://myssb.barstow.edu:4443/PROD/twbkwbis.P_WWWLogin')
#br.open('https://login.barstow.edu')
br.select_form(nr=0)   # Note: select the form named 'f' here
#br.form['q'] = 'here goes your query' # query
#forms = list(br.forms())
for form in br.forms():
    print form.name
#br.form = pick_a_form(forms, br.global_form())
br.form['UserID'] = 'B00262558'
br.form['PIN'] = '007500'
br.submit()
#data = br.submit()

# parse and output
soup = BeautifulSoup(data.read())
print soup
