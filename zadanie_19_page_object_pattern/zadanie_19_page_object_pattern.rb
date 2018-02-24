require 'selenium-webdriver'
require_relative 'application/application'

@app = Application.new
@app.add_product
@app.remove_product
@app.quit
