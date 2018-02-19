require 'selenium-webdriver'
NAME = 'username'
PASSWORD = 'password'
LOGIN = 'login'

class Zadanie6
  Selenium::WebDriver::Firefox::Binary.path = "C:\\Program Files\\Firefox Nightly\\firefox.exe"
  driver = Selenium::WebDriver.for(:firefox)
  driver.navigate.to('http://localhost/litecart/admin/')
  driver.find_element(:name, NAME).send_keys('admin')
  driver.find_element(:name, PASSWORD).send_keys('admin')
  driver.find_element(:name, LOGIN).click
  driver.quit
end


