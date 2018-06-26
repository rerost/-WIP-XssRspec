require_relative "visitor/path_manager"
require "selenium-webdriver"

module XssRspec
  module Checker
    module Visitor
      class << self
        def visit_all
          driver = Selenium::WebDriver.for :chrome
          visitable_urls.each { |url|
            driver.navigate.to url
          }
          driver.quit
        end

        def visitable_urls
          ["localhost:3000/users/1000"]
        end
      end
    end
  end
end