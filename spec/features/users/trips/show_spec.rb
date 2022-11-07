require 'rails_helper'

describe 'TripsController' do
  describe 'Show Page' do
    it 'should show the information for one trip', :vcr do
      stub_omniauth

      road_trip = File.read('spec/fixtures/trip_by_id.json')

      stub_request(:get, 'http://localhost:3000/api/v1/1000/trips/1')
      .to_return(status: 200, body: road_trip, headers: {})

      trip = TripFacade.trip_by_id("1000", "1")
      #
      # top_trips = File.read('spec/fixtures/trips.json')
      #
      # stub_request(:get, 'http://localhost:3000/api/v1/1000/trips')
      # .to_return(status: 200, body: top_trips, headers: {})

      user = create(:omniauth_mock_user, google_id: '1000')

      visit '/'
      click_on "Log In"
      expect(current_path).to eq(dashboard_path)

      visit "/trips/#{trip.id}"

      expect(page).to have_content("test_trip")
      expect(page).to have_content("Arrival: Thursday, 10 Nov 2022 1:37 PM")
      expect(page).to have_content("Departure: Sunday, 06 Nov 2022 1:32 PM")
      expect(current_path).to eq("/trips/#{trip.id}")
    end

    it 'can delete a trip', :vcr do
      stub_omniauth

      road_trip = File.read('spec/fixtures/trip_by_id.json')

      stub_request(:get, 'http://localhost:3000/api/v1/1000/trips/1')
      .to_return(status: 200, body: road_trip, headers: {})

      trip = TripFacade.trip_by_id("1000", "1")
      user = create(:omniauth_mock_user, google_id: '1000')

      visit '/'
      click_on "Log In"
      expect(current_path).to eq(dashboard_path)

      visit "/trips/#{trip.id}"

      click_on "Delete Trip"
      
      expect(current_path).to eq('/trips')
      expect(page).to have_content("Trip has been Cancelled")
      expect(page).to_not have_content(trip.name)

    end
  end
end
