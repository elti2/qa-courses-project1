require 'selenium-webdriver'

class ProductPage
  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  end

  def set_quantity(quantity)
    @wait.until {@driver.find_element(:css, 'span.quantity').attribute('textContent') == "#{quantity}"}
  end
end