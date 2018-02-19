require 'rubygems'
require 'selenium-webdriver'

caps = Selenium::WebDriver::Remote::Capabilities.new
#caps[:browserName] = 'Safari'
#caps['device'] = 'iPhone 7'
#caps['realMobile'] = 'true'
#caps['os_version'] = '10.3'

#caps[:browserName] = 'Safari'
#caps['device'] = 'iPhone SE '
#caps['realMobile'] = 'true'
#caps['os_version'] = '11.2'

# generate capabilities: https://www.browserstack.com/automate/capabilities
caps['os'] = 'OS X'
caps['os_version'] = 'High Sierra'
caps[:browserName] = 'Chrome'
caps['browser_version'] = '64.0'


driver = Selenium::WebDriver.for(:remote,
                                 :url => "http://justyna28:h6L6bRU7WAkFRzCsmYzd@hub-cloud.browserstack.com/wd/hub",
                                 :desired_capabilities => caps)
driver.navigate.to("http://www.seleniumhq.org/")
driver.find_element(:link, "Download").click
puts driver.title
driver.quit