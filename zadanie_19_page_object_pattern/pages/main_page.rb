require 'selenium-webdriver'

class MainPage
  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  end

  def open
    @driver.navigate.to('http://localhost/litecart/en/')
  end

  def move_to_product(name)
    @driver.find_element(:css, "a.link[title='#{name}']").click
    @driver.find_element(:name, 'add_cart_product').submit
  end

end