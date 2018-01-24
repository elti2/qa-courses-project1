require 'selenium-webdriver'
class FirstClass
  puts 'hi'
  driver = Selenium::WebDriver.for :chrome
  driver.navigate.to('https://google.pl')
  driver.quit
end