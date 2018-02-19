require 'selenium-webdriver'
require 'test/unit'
require 'rubygems'
include Test::Unit::Assertions

def open_page
  @driver.navigate.to('http://localhost/litecart/admin/')
end

def wait
  @driver.manage.timeouts.implicit_wait = 10 # seconds
  @driver.find_element(:css, 'ul#box-apps-menu').find_element(:xpath, './/*[contains(., "Catalog")]')
end

def login
  @driver.find_element(:name, 'username').send_keys('admin')
  @driver.find_element(:name, 'password').send_keys('admin')
  @driver.find_element(:name, 'login').click
end

@random = Random.rand(999)

def add_product
  @driver.find_element(:css, 'ul#box-apps-menu').find_element(:xpath, './/*[contains(., "Catalog")]').click
  link = @driver.find_elements(:css, 'a.button').select {|el| el.text == 'Add New Product'}[0].attribute('href')
  @driver.navigate.to(link)
  @driver.find_element(:name, 'name[en]').send_keys("Name-#{@random}")
  @driver.find_element(:name, 'code').send_keys("Code-#{@random}")
  @driver.find_element(:name, 'quantity').clear
  @driver.find_element(:name, 'quantity').send_keys("#{@random}")
  @driver.find_elements(:name, 'categories[]')[1].click
  @driver.find_elements(:name, 'product_groups[]')[2].click
  @driver.find_element(:name, 'sold_out_status_id').find_element(:css, 'option[value="2"]').click
  @driver.find_element(:name, 'date_valid_from').send_keys('01-01-2018')
  @driver.find_element(:name, 'date_valid_to').send_keys('30-12-2018')

  @driver.find_element(:link_text, 'Information').click
  @driver.find_element(:name, 'manufacturer_id').find_element(:css, 'option[value="1"]').click
  @driver.find_element(:name, 'keywords').send_keys("#{@random}")
  @driver.find_element(:name, 'short_description[en]').send_keys("short description-#{@random}")
  @driver.find_element(:class, 'trumbowyg-editor').send_keys("description-#{@random}")
  @driver.find_element(:name, 'head_title[en]').send_keys("head title-#{@random}")
  @driver.find_element(:name, 'meta_description[en]').send_keys("meta description-#{@random}")

  @driver.find_element(:link_text, 'Prices').click
  @driver.find_element(:name, 'purchase_price').send_keys("#{@random}")
  @driver.find_element(:name, 'purchase_price_currency_code').find_element(:css, 'option[value="EUR"]').click
  @driver.find_element(:name, 'prices[EUR]').send_keys("#{@random}")
  @driver.find_element(:name, 'gross_prices[EUR]').send_keys("#{@random}")

  @driver.find_element(:name, 'save').click
end

def check_product(name)
  assert_true(@driver.find_element(:link_text, "#{name}").displayed?)
end

@driver = Selenium::WebDriver.for :chrome
open_page
login
add_product
wait
check_product("Name-#{@random}")
@driver.quit