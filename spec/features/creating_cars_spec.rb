require 'rails_helper'

feature 'Creating Cars' do
  scenario 'can create a car' do
    car = FactoryGirl.create(:car)
    visit '/'

    click_link 'New Car'

    fill_in 'Make', with: car.make
    fill_in 'Model', with: car.model
    fill_in 'Year', with: car.year
    fill_in 'Price', with: car.price

    click_button 'Create Car'

    expect(page).to have_content("#{car.year} #{car.make} #{car.model} created")

    within('table') do
      expect(page).to have_content(car.make)
      expect(page).to have_content(car.model)
      expect(page).to have_content(car.year)
      expect(page).to have_content(car.price)
    end
  end

  scenario 'can create a second car' do
    car1 = FactoryGirl.create(:car)
    car2 = FactoryGirl.create(:car)
    visit '/'

    click_link 'New Car'

    fill_in 'Make', with: car1.make
    fill_in 'Model', with: car1.model
    fill_in 'Year', with: car1.year
    fill_in 'Price', with: car1.price

    click_button 'Create Car'

    within('table') do
      expect(page).to have_content(car1.make)
      expect(page).to have_content(car1.model)
      expect(page).to have_content(car1.year)
      expect(page).to have_content(car1.price)
    end

    click_link 'New Car'

    fill_in 'Make', with: car2.make
    fill_in 'Model', with: car2.model
    fill_in 'Year', with: car2.year
    fill_in 'Price', with: car2.price

    click_button 'Create Car'

    expect(page).to have_content("#{car2.year} #{car2.make} #{car2.model} created")

    expect(page).to have_selector('table tr', :count => 3)

    within('table') do
      expect(page).to have_content(car1.make)
      expect(page).to have_content(car1.model)
      expect(page).to have_content(car1.year)
      expect(page).to have_content(car1.price)

      expect(page).to have_content(car2.make)
      expect(page).to have_content(car2.model)
      expect(page).to have_content(car2.year)
      expect(page).to have_content(car2.price)

    end

  end


end
