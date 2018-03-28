FactoryBot.define do
  factory :transmission do
    name 'The Joy of Painting'
    description 'In this half-hour program, artist Bob Ross paints on canvas a beautiful oil painting.'
    status :confirmed
  end

  factory :invalid_transmission, class: Transmission do
    name nil
    description 'In this half-hour program, artist Bob Ross paints on canvas a beautiful oil painting.'
    status :confirmed
  end
end
