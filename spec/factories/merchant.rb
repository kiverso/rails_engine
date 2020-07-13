FactoryBot.define do
  factory :merchant do
    name { Faker::Coffee.blend_name }
    description { Faker::Coffee.notes }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end