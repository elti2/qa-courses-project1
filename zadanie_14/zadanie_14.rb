require 'selenium-webdriver'
require 'test/unit'
require 'rubygems'
include Test::Unit::Assertions

def open_page
  @driver.navigate.to('http://localhost/litecart/admin')
end

def login
  @driver.find_element(:name, 'username').send_keys('admin')
  @driver.find_element(:name, 'password').send_keys('admin')
  @driver.find_element(:name, 'login').click
end

@driver = Selenium::WebDriver.for :chrome
wait = Selenium::WebDriver::Wait.new(:timeout => 30)

open_page
login
@driver.find_element(:css, 'ul#box-apps-menu').find_element(:xpath, './/*[contains(., "Countries")]').click
@driver.find_element(:css, 'a.button').click

main_window = @driver.window_handle

@driver.find_elements(:css, 'i.fa.fa-external-link').each do |button|
  button.click
  window_handles = @driver.window_handles
  @driver.switch_to.window(window_handles[1])
  wait.until { @driver.execute_script('return document.readyState').eql?('complete') }
  @driver.close
  @driver.switch_to.window(main_window)
end

@driver.quit