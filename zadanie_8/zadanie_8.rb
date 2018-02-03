require 'selenium-webdriver'
require 'test/unit'
include Test::Unit::Assertions

def open_page
  @driver.navigate.to('http://localhost/litecart/en/')
end

def wait
  @driver.manage.timeouts.implicit_wait = 2 # seconds
  @driver.find_element(:id => 'box-most-popular')
end

def find_stickers
  stickers = []
  wait
  @driver.find_elements(:css, 'div.sticker').each do |sticker|
    stickers << sticker
  end
  return stickers.count
end

def find_product
  products = []
  wait
  @driver.find_elements(:css, 'li.product.column.shadow.hover-light').each do |prod|
    products << prod
  end
  return products.count
end

@driver = Selenium::WebDriver.for :chrome
open_page
puts find_stickers == find_product ? 'Same value of stickers and products - OK' : 'Different value of stickers and products - NOK'
assert_equal(find_stickers, find_product)
@driver.quit