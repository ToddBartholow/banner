#!/usr/bin/env python

from __future__ import print_function
import os, subprocess
import re
import sys

from urllib2 import HTTPError
import mechanize
from bs4 import BeautifulSoup
import polyglot

br = mechanize.Browser()

# Browser options
br.set_handle_robots(False)
br.set_handle_redirect(True)
br.set_handle_equiv(True)
br.set_handle_referer(True)
br.set_handle_gzip(True)


# Debugging
br.set_debug_http(True)
br.set_debug_redirects(True)
br.set_debug_responses(True)

try:
  br.open('https://myssb.barstow.edu:4443/PROD/twbkwbis.P_WWWLogin')
except HTTPError as e:
  sys.exit("%d: %s" % (e.code, e.msg))

br.select_form(nr = 0)
br['sid'] = 'B00262558'
br['PIN'] = '007500'

#br.form['sid'] = 'B00262558' 
#br.form['PIN'] = '007500'

try:
  data = br.submit()
except HTTPError as e:
  sys.exit("%d: %s" % (e.code, e.msg))
#response = br.response()
#print(response.read())

#br.find_link(url='https://myssb.barstow.edu:4443/PROD/twbkwbis.P_GenMenu?name=bmenu.P_FacMainMnu')
#req = br.click_link(url='https://myssb.barstow.edu:4443/PROD/twbkwbis.P_GenMenu?name=bmenu.P_FacMainMnu')

for link in br.links():
  print(link)
  print(link.url)
  #if link.url == target_url:
  #   print('match found')
    # match found            
  #  break

#br.select_form(nr=0)
br.find_link(text='Faculty & Counselor')
req = br.click_link(text='Faculty & Counselor')

#response = br.response()
#print(response.read())

try:
  br.open(req)
except HTTPError as e:
  sys.exit("%d: %s" % (e.code, e.msg))

#response = br.response()
#print(response.read())

#print urlopen(br.form.click()).read () 
# parse and output
#soup = BeautifulSoup(data.read())
#print(soup)
