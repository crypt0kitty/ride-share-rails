require "test_helper"

describe TripsController do
  describe "show" do
    it "responds with success when showing an existing valid trip" do
      valid_trip = Trip.new(driver_id: 1, passenger_id: 2, date: "Nov. 3, 2020", rating: 5, cost: 540)

      get trip_path(valid_trip)

      must_respond_with :success
    end

    it "responds with 404 if given an invalid trip" do

      bad_trip = "oh no oh god"

      get trip_path(bad_trip)

      must_respond_with 404

    end
  end

  describe "create" do
    it "can create a new trip with valid information, accurately and redirect" do
      # valid_trip = Trip.new(driver_id: 1, passenger_id: 2, date: "Nov. 3, 2020", rating: 5, cost: 540)
      trip_hash = {trip: {driver_id: 1,
                          passenger_id: 2,
                          date: "Nov. 3, 2020",
                          rating: 5,
                          cost: 540}
      }
      valid_passenger = Passenger.new(name: Sean Gomez, phone_num: 123-13-234)

      expect { post passenger_trips_path(valid_passenger), params: trip_hash}.must_differ Trip.count, 1
      valid_trip = Trip.find_by(date: trip_hash[:trip][:date])
      expect(valid_trip.rating).must_equal trip_hash[:driver][:rating]

      must_respond_wtih :redirect
      must_redirect_to trip_path(valid_trip)

    end
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
