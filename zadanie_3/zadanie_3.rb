require 'selenium-webdriver'
NAME = 'username'
PASSWORD = 'password'
LOGIN = 'login'

class Zadanie_3
  driver = Selenium::WebDriver.for :chrome
  driver.navigate.to('http://localhost/litecart/admin/')
  driver.find_element(:name, NAME).send_keys('admin')
  driver.find_element(:name, PASSWORD).send_keys('admin')
  driver.find_element(:name, LOGIN).click
  driver.quit
end


