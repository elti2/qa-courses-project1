require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome
driver.navigate.to('https://google.pl')
driver.quit