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

def table_rows
  rows = []
  wait
  @driver.find_elements(:xpath, '//table/tbody/tr/td[5]').each do |row|
    rows << row.attribute('textContent')
  end
  return rows
end

@driver = Selenium::WebDriver.for :chrome
open_page
login
countries_original = table_rows
countries_sorted = countries_original.sort
assert_equal(countries_original, countries_sorted)
@driver.quit