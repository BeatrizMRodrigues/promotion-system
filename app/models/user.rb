class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :promotions
  has_many :promotion_approvals
  has_many :approved_promotions, through: :promotion_approvals, source: :promotion

  validate :password_complexity
  def password_complexity
  # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/
      
    errors.add :password, 'A senha deve conter no mínimo 8 caracteres, com pelo menos 1 letra maiúscula, 1 letra minúscula e 1 caractere especial'
  end
end
