require 'rails_helper'

describe 'TripsController' do
  describe 'Show Page', :vcr do
    it 'should show the information for one trip' do
      stub_omniauth

      user = create(:omniauth_mock_user)

      visit '/'
      click_on "Log In"
      expect(current_path).to eq(dashboard_path)

      visit "/trips/1"

      expect(page).to have_content("The Great Trip")
      expect(page).to have_content("Departure: Tuesday, 29 Nov 2022 1:00 PM")
      expect(page).to have_content("1600 Pennsylvania Ave NW, Washington, DC")
      expect(page).to have_content("350 State St, Salt Lake City, UT 84103")
    end
  end
end
