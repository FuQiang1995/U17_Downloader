#!/usr/bin/python
#coding:utf-8

import time
import requests
from selenium import webdriver

def download(filename, url):
	print (url + " ==> " + filename)
	data = requests.get(url, headers=headers)

	with open(filename, 'wb+') as file:
		file.write(data.content)

headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0', 'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'}
url = 'http://www.u17.com/chapter/9963.html#image_id=83276'
browser = webdriver.Firefox()

browser.get(url)

time.sleep(1)

pic_last = ' '
picture = ' '

try:
	browser.find_element_by_id("readarea").find_element_by_id("mask").click()
except:
	pass

while True:
	try:
		pic_last = picture
		picture = browser.find_element_by_class_name("cur_img").get_attribute('src')
		if picture == pic_last:
			print ("無効なクリーク：写真のアドレスが変わらない、2秒後で再試験しています")
			time.sleep(2)
			browser.find_element_by_class_name("next").click()
			picture = browser.find_element_by_class_name("cur_img").get_attribute('src')
		filename = browser.title[:-20]
		download(filename + '.jpg', picture)
		browser.find_element_by_class_name("next").click()
		time.sleep(1)
	except:
		try:
			browser.find_element_by_class_name("dialogBox").find_element_by_class_name("close").click()
		except:
			print ("クリーク不能：2秒後で再試験しています")
			time.sleep(2)

browser.close()