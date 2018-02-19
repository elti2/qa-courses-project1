require 'selenium-webdriver'
require 'test/unit'
require 'rubygems'
include Test::Unit::Assertions

def open_page
  @driver.navigate.to('http://localhost/litecart/en/')
end

wait = Selenium::WebDriver::Wait.new(:timeout => 5)
@driver = Selenium::WebDriver.for :chrome

open_page

3.times do |i|
  @driver.find_element(:css, 'a.link[title="Green Duck"]').click
  @driver.find_element(:name, 'add_cart_product').submit

  wait.until {@driver.find_element(:css, 'span.quantity').attribute('textContent') == "#{i + 1}"}
  assert_equal(@driver.find_element(:css, 'span.quantity').attribute('textContent'), "#{i + 1}")

  @driver.navigate.back
end

@driver.find_element(:link_text, 'Checkout »').click

3.times do
  quantity  = @driver.find_element(:name, 'quantity').attribute('value').to_i
  @driver.find_element(:name, 'quantity').clear
  @driver.find_element(:name, 'quantity').send_keys(quantity - 1)
  @driver.find_element(:name, 'update_cart_item').click

  @driver.find_element(:xpath, '//table[@class="dataTable rounded-corners"]/tbody/tr/td[1]').attribute('textContent')
  if quantity - 1 > 0
    wait.until{@driver.find_element(:xpath, '//table[@class="dataTable rounded-corners"]/tbody/tr/td[1]').attribute('textContent').to_i == quantity - 1}
  else
    wait.until{@driver.find_element(:css, 'div#checkout-cart-wrapper').css_value('opacity').to_i == 0}
  end
end

@driver.quit