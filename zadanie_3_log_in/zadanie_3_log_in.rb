require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome
driver.navigate.to('http://localhost/litecart/admin/')
driver.find_element(:name, 'username').send_keys('admin')
driver.find_element(:name, 'password').send_keys('admin')
driver.find_element(:name, 'login').click
driver.quit


