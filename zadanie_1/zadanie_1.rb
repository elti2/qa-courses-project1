require 'selenium-webdriver'
class Zadanie1
  driver = Selenium::WebDriver.for :chrome
  driver.navigate.to('https://google.pl')
  driver.quit
end