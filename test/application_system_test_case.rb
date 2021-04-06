require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1700, 1700]

  Capybara.server = :puma, { Silent: true }
end
