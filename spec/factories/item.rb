FactoryBot.define do
  factory :item do
    name { Faker::Coffee.blend_name }
  end
end