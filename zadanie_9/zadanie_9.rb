require 'selenium-webdriver'
require 'test/unit'
include Test::Unit::Assertions

def open_page
  @driver.navigate.to('http://localhost/litecart/admin/?app=countries&doc=countries')
end

def login
  @driver.find_element(:name, 'username').send_keys('admin')
  @driver.find_element(:name, 'password').send_keys('admin')
  @driver.find_element(:name, 'login').click
end

def wait
  @driver.manage.timeouts.implicit_wait = 2 # seconds
  @driver.find_element(:xpath => '//table/tbody/tr/td[5]')
end

@countries = []
@hrefs = []

def countries
  wait
  table = @driver.find_element(:class, 'dataTable')
  rows = table.find_elements(:class, 'row')
  rows.each do |row|
    cells = row.find_elements(:tag_name, 'td')
    @countries << cells[4].attribute('textContent') unless cells[5].attribute('textContent').nil?
    zone = cells[5].attribute('textContent')
    if zone.to_i != 0
      @hrefs << row.find_element(:tag_name, 'a').attribute('href')
    end
  end
  if @countries == @countries.sort
    puts "countries sorted"
  else
    puts "countries not sorted"
  end
end

def zones
  wait
  zones = []
  @hrefs.each do |href|
    @driver.navigate.to(href)
    @driver.find_elements(:xpath, '//table[@id="table-zones"]/tbody/tr/td[3]').each do |zone|
      zones << zone.attribute('textContent') unless zone.attribute('textContent').to_s.empty?
    end

    if zones == zones.sort
      puts "zone sorted"
    else
      puts "zone not sorted"
    end
    zones.clear
  end
end

@driver = Selenium::WebDriver.for :chrome
open_page
login
countries
zones
@driver.quit