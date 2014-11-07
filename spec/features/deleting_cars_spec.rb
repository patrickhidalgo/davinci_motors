require 'rails_helper'

feature 'Deleting Cars' do
  scenario 'can delete a car' do
    Car.create(
      make: 'Ford',
      model: 'Mustang',
      year: '1967',
      price: '2300'
    )
    visit '/'
    click_link 'Destroy'

    expect(page).to have_content('1967 Ford Mustang destroyed')

    within('table') do
      expect(page).to_not have_content('1967')
      expect(page).to_not have_content('Ford')
      expect(page).to_not have_content('Mustang')
      expect(page).to_not have_content('2300')

    end
  end
end



