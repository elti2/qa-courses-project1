require 'selenium-webdriver'
require 'test/unit'
require 'rubygems'
require 'color'
include Test::Unit::Assertions

def open_page
  @driver.navigate.to('http://localhost/litecart/en/')
end

def wait
  @driver.manage.timeouts.implicit_wait = 2 # seconds
  @driver.find_element(:css => 'div#box-campaigns >h3')
end

@driver = Selenium::WebDriver.for :chrome
open_page
wait
@driver.find_element(:css, 'div#box-campaigns a').click

puts @driver.find_element(:css, 'div.content h1').attribute('textContent') == 'Yellow Duck' ? 'Valid product name' : 'Invalid product name'

regular_price = @driver.find_element(:css, 's.regular-price')
campaign_price = @driver.find_element(:css, 'div.price-wrapper strong')
puts regular_price.attribute('textContent') == '$20' ? 'Valid regular price' : 'Invalid regular price'
puts campaign_price.attribute('textContent') == '$18' ? 'Valid campaign price' : 'Invalid campaign price'

c = Color::RGB.from_html('666')
puts "rgba(#{c.red.to_i}, #{c.green.to_i}, #{c.blue.to_i}, 1)" == regular_price.css_value('color') ? 'Regular price color valid' : 'Regular price color invalid'
puts  regular_price.css_value('text-decoration').include?('line-through') ? 'Regular price has strike-through' : 'Regular price does not have strike-through'
c = Color::RGB.from_html('c00')
puts "rgba(#{c.red.to_i}, #{c.green.to_i}, #{c.blue.to_i}, 1)" == campaign_price.css_value('color') ? 'Campaign price color valid' : 'Campaign price color invalid'
puts regular_price.css_value('font-weight').to_i == 400 ? 'Campaign price bold' : 'Campaign price not bold'

@driver.quit