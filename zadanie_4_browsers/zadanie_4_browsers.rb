require 'selenium-webdriver'
NAME = 'username'
PASSWORD = 'password'
LOGIN = 'login'

[:chrome, :firefox, :ie].each do |browser|
  driver = Selenium::WebDriver.for(browser)
  driver.navigate.to('http://localhost/litecart/admin/')
  driver.find_element(:name, NAME).send_keys('admin')
  driver.find_element(:name, PASSWORD).send_keys('admin')
  driver.find_element(:name, LOGIN).click
  driver.quit
end


