require 'selenium-webdriver'
require 'test/unit'

browsers = [:chrome, :firefox, :ie]
browsers.each do |browser|
  @driver = Selenium::WebDriver.for :remote, :url => "http://192.168.1.51:4444/wd/hub", :desired_capabilities => browser
  @driver.navigate.to("http://www.seleniumhq.org/")
  @driver.find_element(:link, "Download").click
end


#@driver.quit