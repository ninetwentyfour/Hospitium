# Added profile support for capybara, so we can run our tests in headless mode
class Capybara::Driver::Selenium &lt; Capybara::Driver::Base
  def self.driver
    unless @driver
      profile = Selenium::WebDriver::Firefox::Profile.new
      profile.load_no_focus_lib = false
      @driver = Selenium::WebDriver.for :firefox, :profile =&gt; profile
      at_exit do
        @driver.quit
      end
    end
    @driver
  end
end