require 'rubygems'
require 'selenium-webdriver'

def login
  @driver.navigate.to('http://localhost/litecart/admin')
  @driver.find_element(:name, 'username').send_keys('admin')
  @driver.find_element(:name, 'password').send_keys('admin')
  @driver.find_element(:name, 'login').click
end

def products
  table = @driver.find_element(:class, 'dataTable')
  rows = table.find_elements(:class, 'row')
  rows.each do |row|
    @hrefs << row.find_element(:tag_name, 'a').attribute('href')
  end
end

p = Selenium::WebDriver::Proxy.new(:http => "localhost:8888")
caps = Selenium::WebDriver::Remote::Capabilities.new(:proxy => p)
@driver = Selenium::WebDriver.for :chrome, desired_capabilities: caps

@hrefs = []

login
@driver.find_element(:css, 'ul#box-apps-menu').find_element(:xpath, './/*[contains(., "Catalog")]').click
products

@hrefs.each do |href|
  @driver.navigate.to(href)
end

@driver.quit