
FactoryGirl.define do
  factory :car do
    make { Car::MAKES_AND_MODELS.keys.sample }
    model { Car::MAKES_AND_MODELS[make].sample}
    year { rand(1879..2014) }
    price { if [ "Aston Martin", "Bentley", "Ferrari",
      "Lamborghini", "Maserati", "Maybach", "Rolls-Royce"
    ].include?(make)
               rand(100_000...1_000_000)
            else
               rand(0...100_000)
            end}
  end
end

