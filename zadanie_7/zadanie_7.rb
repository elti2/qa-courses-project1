require 'selenium-webdriver'
NAME = 'username'
PASSWORD = 'password'
LOGIN = 'login'
MENU_ELEMENT = 'ul#box-apps-menu > li > a'
CHILD_MENU_ELEMENT = 'li.selected > ul > li > a'
TITLE = 'td#content > h1'

def login(driver)
  driver.navigate.to('http://localhost/litecart/admin')
  driver.find_element(:name, NAME).send_keys('admin')
  driver.find_element(:name, PASSWORD).send_keys('admin')
  driver.find_element(:name, LOGIN).click
end

def element_present?(type, element, driver)
  begin
    driver.find_element(type, element)
    return true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    return false
  end
end

def find_links(driver)
  links = []
  driver.find_elements(:css, MENU_ELEMENT).each do |link|
    links << link['href']
  end

  links.each do |href|
    driver.navigate.to(href)  #puts driver.find_element(:css, TITLE).text
    element_present?(:css, TITLE, driver)

    children = []
    driver.find_elements(:css, CHILD_MENU_ELEMENT).each do |link|
      children << link['href']
    end

    children.each do |childrenHref|
      driver.navigate.to(childrenHref) #puts '--> ' + driver.find_element(:css, TITLE).text
      element_present?(:css, TITLE, driver)
    end
  end
end

driver ||= Selenium::WebDriver.for :chrome
login(driver)
find_links(driver)
driver.quit