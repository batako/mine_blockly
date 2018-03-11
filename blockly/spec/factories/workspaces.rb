FactoryBot.define do
  factory :workspace do
    sequence(:name){|n| "NAME #{n}"}
    sequence(:xml){|n| "XML #{n}"}
  end
end
