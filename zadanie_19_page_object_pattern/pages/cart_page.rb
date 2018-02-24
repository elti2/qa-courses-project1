require 'selenium-webdriver'

class CartPage
  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  end

  def open
    @driver.find_element(:link_text, 'Checkout »').click
  end

  def get_quantity
    @driver.find_element(:name, 'quantity').attribute('value').to_i
  end

  def change_quantity(quantity)
    @driver.find_element(:name, 'quantity').clear
    @driver.find_element(:name, 'quantity').send_keys(quantity)
    @driver.find_element(:name, 'update_cart_item').click
  end

  def check_quantity(quantity)
    @driver.find_element(:xpath, '//table[@class="dataTable rounded-corners"]/tbody/tr/td[1]').attribute('textContent')
    if quantity > 0
      @wait.until{@driver.find_element(:xpath, '//table[@class="dataTable rounded-corners"]/tbody/tr/td[1]').attribute('textContent').to_i == quantity}
    else
      @wait.until{@driver.find_element(:css, 'div#checkout-cart-wrapper').css_value('opacity').to_i == 0}
    end
  end

end