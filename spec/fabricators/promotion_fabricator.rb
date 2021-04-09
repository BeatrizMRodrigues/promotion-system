Fabricator(:promotion) do 
  name { sequence(:name)  { |i| "Natal#{i}" } }
  description 'Promoção de Natal'
  code { sequence(:code) { |i| "Natal#{i}" } }
  discount_rate 15
  coupon_quantity 10
  expiration_date '25/12/2023'
  user
end