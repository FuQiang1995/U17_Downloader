#!/usr/bin/ruby
#encoding: utf-8

require 'selenium-webdriver'
require 'open-uri'

def download(filename, uri)
	puts uri + ' ==> ' + filename

	data = open(uri, 'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0'){|f| f.read} 
	
	file = File.new filename, 'w+'
	file.binmode 
	file << data 
	file.flush 
	file.close
end

browser = Selenium::WebDriver.for :firefox
url = 'http://www.u17.com/chapter/9963.html#image_id=83276'

browser.get(url)

sleep 1

pic_last = ' '
pic = ' '
#normal_loop = true

begin
	browser.find_element(:id=>'readarea').find_element(:id=>'mask').click
rescue
end	
loop {
	begin
		#if normal_loop == false
		#	browser.find_element(:class=>'next').click
		#	normal_loop = true
		#end
		pic_last = pic
		pic = browser.find_element(:class=>'cur_img')['src'].to_s
		if pic == pic_last
			puts '無効なクリーク：写真のアドレスが変わらない、2秒後で再試験しています'
			sleep 2
			browser.find_element(:class=>'next').click
			pic = browser.find_element(:class=>'cur_img')['src'].to_s
		end
		filename = browser.title.to_s
		20.times{filename.chop!}
		download(filename + '.jpg', pic)
		browser.find_element(:class=>'next').click
		sleep 1
	rescue
		#normal_loop = false
		begin
			browser.find_element(:class=>'dialogBox').find_element(:class=>'close').click
		rescue
			puts 'クリーク不能：2秒後で再試験しています'
			sleep 2
		end		
	end
}
