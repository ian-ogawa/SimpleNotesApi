require 'factory_bot'

FactoryBot.define do
  factory :label do
    name { Faker::Lorem.word }
  end
end