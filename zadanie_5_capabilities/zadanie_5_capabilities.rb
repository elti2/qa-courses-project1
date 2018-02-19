require 'selenium-webdriver'
NAME = 'username'
PASSWORD = 'password'
LOGIN = 'login'

caps = Selenium::WebDriver::Remote::Capabilities.new()
driver = Selenium::WebDriver.for(:firefox, :desired_capabilities => caps)
driver.navigate.to('http://localhost/litecart/admin/')
driver.find_element(:name, NAME).send_keys('admin')
driver.find_element(:name, PASSWORD).send_keys('admin')
driver.find_element(:name, LOGIN).click
driver.quit



