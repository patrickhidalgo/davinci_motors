require 'rails_helper'

feature 'Editing Cars' do
  scenario 'can edit a car' do
    Car.create(
      make: 'Ford',
      model: 'Mustang',
      year: '1967',
      price: '2300'
    )
    visit '/'
    click_link 'Edit'

    fill_in 'Make', with: 'Toyota'
    fill_in 'Model', with: 'Camary'
    fill_in 'Year', with: '1987'
    fill_in 'Price', with: '4500'

    click_button 'Pimp my ride'

    expect(page).to have_content('1987 Toyota Camary updated')

    # :count =>2 because it counts the header row as one record
    expect(page).to have_selector('table tr', :count => 2)

    within('table') do
      expect(page).to_not have_content('1967')
      expect(page).to_not have_content('Ford')
      expect(page).to_not have_content('Mustang')
      expect(page).to_not have_content('$2,300')

      expect(page).to have_content('1987')
      expect(page).to have_content('Toyota')
      expect(page).to have_content('Camary')
      expect(page).to have_content('$4,500')

    end

  end
end



