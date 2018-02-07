require 'selenium-webdriver'
require 'test/unit'
require 'rubygems'
require 'color'
include Test::Unit::Assertions

def open_page
  @driver.navigate.to('http://localhost/litecart/en/')
end

def wait
  @driver.manage.timeouts.implicit_wait = 3 # seconds
  @driver.find_element(:link_text => 'Logout')
end

@random = Random.rand(999)
@email = "email#{@random}@wp.pl"
@password = Random.rand(999999)


def register
  @driver.find_element(:link_text, 'New customers click here').click
  @driver.find_element(:name, 'firstname').send_keys("First name #{@random}")
  @driver.find_element(:name, 'lastname').send_keys("Last name #{@random}")
  @driver.find_element(:name, 'address1').send_keys("Address 1 #{@random}")
  @driver.find_element(:name, 'address2').send_keys("Address 2 #{@random}")
  @driver.find_element(:name, 'postcode').send_keys("#{Random.rand(99)}-#{@random}")
  @driver.find_element(:name, 'city').send_keys("City #{@random}")
  @driver.find_element(:name, 'email').send_keys(@email)
  @driver.find_element(:name, 'phone').send_keys("#{@random} #{@random} #{@random}")
  @driver.find_element(:name, 'password').send_keys("#{@password}")
  @driver.find_element(:name, 'confirmed_password').send_keys("#{@password}")
  @driver.find_element(:name, 'create_account').click
end

def login
  @driver.find_element(:name, 'email').send_keys(@email)
  @driver.find_element(:name, 'password').send_keys(@password)
  @driver.find_element(:name, 'login').click
end

@driver = Selenium::WebDriver.for :chrome
open_page
register
wait
@driver.find_element(:link_text => 'Logout').click
login
@driver.find_element(:link_text => 'Logout').click
@driver.quit