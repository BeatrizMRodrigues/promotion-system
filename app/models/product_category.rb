class ProductCategory < ApplicationRecord
  has_many :promotion_categories
  has_many :promotions, through: :promotion_categories

end
