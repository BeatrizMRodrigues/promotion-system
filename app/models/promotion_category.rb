class PromotionCategory < ApplicationRecord
  belongs_to :promotion
  belongs_to :product_category

  def promotion_category
    PromotionCategory.new(promotion: @promotion, product_category: @product_category)
  end
end
