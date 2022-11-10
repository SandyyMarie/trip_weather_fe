require 'rails_helper'

RSpec.describe "Dashboard page", :vcr do
  describe 'As a User' do

    it 'I see my username and my image' do
      stub_omniauth

      # road_trips = File.read('spec/fixtures/trips.json')
      # stub_request(:get, "http://localhost:3000/api/v1/1000/trips")
      #  .to_return(status: 200, body: road_trips, headers: {})

      # trips = TripFacade.all_trips("1000")

      @user = create(:omniauth_mock_user)
      
      visit '/'
      click_link "Log In"

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content(@user.email)
      expect(page).to have_xpath("//img[contains(@src,'#{@user.image}')]")
    end

    it 'should show next 3 trips' do
      stub_omniauth

      # road_trips = File.read('spec/fixtures/trips.json')
      # stub_request(:get, "http://localhost:3000/api/v1/1000/trips")
      #  .to_return(status: 200, body: road_trips, headers: {})

      # trips = TripFacade.all_trips("1000")

      @user = create(:omniauth_mock_user)
      
      visit '/'
      click_link "Log In"
      expect(current_path).to eq(dashboard_path)

      within("#trips") do
        expect("Test_Trip").to appear_before("Test_Trip_2")
        expect("Test_Trip_2").to appear_before("Test_Trip_3")
        expect("Test_Trip_3").to_not appear_before("Test_Trip")
        expect(page).to_not have_content("Test_Trip_4")
      end
    end

  end
end
