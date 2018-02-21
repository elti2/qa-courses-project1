require 'rubygems'
require 'selenium-webdriver'
require 'logger'

class MyListener < Selenium::WebDriver::Support::AbstractEventListener
  def initialize(log)
    @log = log
  end

  def before_find(by, what, driver)
    @log.info "#{by} #{what}"
  end

  def after_find(by, what, driver)
    @log.info "#{by} #{what} found"
  end
end

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

@driver = Selenium::WebDriver.for(:chrome, :listener => MyListener.new(Logger.new(STDOUT)))
@hrefs = []

login
@driver.find_element(:css, 'ul#box-apps-menu').find_element(:xpath, './/*[contains(., "Catalog")]').click
products

@hrefs.each do |href|
  @driver.navigate.to(href)
  log =  @driver.manage.logs.get :browser
  puts log.to_s.empty? ? "empty" : log.to_s
=begin
  @driver.manage.logs.get('browser').each do |l|
    puts l.to_s.empty? ? "empty" : l.to_s
  end
=end
end

@driver.quit