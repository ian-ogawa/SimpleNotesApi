require 'factory_bot'

FactoryBot.define do
  factory :note do
    title { Faker::Lorem.word }
    content { Faker::Lorem.paragraph }
  end
end