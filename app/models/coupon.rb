class Coupon < ApplicationRecord
  belongs_to :promotion

  enum status: {active: 0, disabled: 10}

  def self.search(query)
    @coupon = Coupon.find_by(code: query)
  end
end
