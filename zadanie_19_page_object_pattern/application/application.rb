require 'selenium-webdriver'
require_relative '../pages/cart_page'
require_relative '../pages/main_page'
require_relative '../pages/product_page'
require 'test/unit'
include Test::Unit::Assertions

class Application
  def initialize
    @driver = Selenium::WebDriver.for :chrome
    @mainPage = MainPage.new(@driver)
    @productPage = ProductPage.new(@driver)
    @cartPage = CartPage.new(@driver)
  end

  def add_product
    3.times do |i|
      @mainPage.open
      @mainPage.move_to_product('Green Duck')
      @productPage.set_quantity(i + 1)
      assert_equal(@driver.find_element(:css, 'span.quantity').attribute('textContent'), "#{i + 1}")
    end
  end

  def remove_product
    @cartPage.open
    3.times do
      quantity  = @cartPage.get_quantity
      @cartPage.change_quantity(quantity - 1)
      @cartPage.check_quantity(@cartPage.get_quantity)
    end
  end

  def quit
    @driver.quit
  end

end