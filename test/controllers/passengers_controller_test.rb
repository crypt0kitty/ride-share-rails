require "test_helper"

describe PassengersController do

  describe "index" do
    it "can get the index path" do
      # Act
      get passengers_path
      # Assert
      must_respond_with :success
    end
  end

  describe "new" do
    it "responds with success" do
      # Act
      get new_passenger_path
      # Asset
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing a valid passenger" do
      valid_passenger = Passenger.create(name: 'Jean Donnelly', phone_num:'120-307-6251')
      # Act
      get passengers_path(valid_passenger)
      # Assert
      must_respond_with :success
    end

    it "should render 404 (page not found) if given an invalid id" do
      # Act
      get passenger_path(-1)
      # Assert
      must_respond_with 404
    end
  end

    describe "create" do
      it "can create a new passenger and redirect to passenger path" do
        passenger_hash = {
            passenger: {
                name: 'Churro Churro',
                phone_num: '123.123.123'
            },
        }

        expect { post passengers_path, params: passenger_hash }.must_differ "Passenger.count", 1
        valid_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
        expect(valid_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

        must_respond_with :redirect
        must_redirect_to passenger_path(valid_passenger)
      end
  end

  describe "edit" do
    it "can edit a page for an existing passenger" do
      valid_passenger = Passenger.create(name: 'Jean Donnelly', phone_num:'120-307-6251')
      # Act
      get edit_passengers_path(valid_passenger)
      # Assert
      must_respond_with :success
    end

    it "responds with 404 (page not found) when editing page for a non-existing passenger" do
      bad_passenger = 'turtle'
      # Act
      get edit_passenger_path(bad_passenger)
      # Assert
      must_respond_with 404
    end
  end

  describe "update" do
    it "can redirect when updating an existing passenger" do
      original_passenger = Passenger.create(name: 'Jean Donnelly', phone_num:'120-307-6251')
      original_id =  original_passenger.id

      updated_hash = {
          passenger: {
              name: 'Churro',
              phone_num: '123-123-123'
          }
      }

      expect {
        patch passenger_path(original_passenger), params: updated_hash
      }.wont_change "Passenger.count"

      updated_passenger = Passenger.find_by(id: original_id)

      expect(updated_passenger.name).must_equal updated_hash[:passenger][:name]
      expect(updated_passenger.phone_num).must_equal updated_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(updated_passenger)
    end
  end

  describe "destroy" do
    it "should delete a passenger" do
      delete_valid_passenger = Passenger.create(name: 'Jean Donnelly', phone_num:'120-307-6251')

      expect {
        delete passenger_path(delete_valid_passenger)
      }.must_differ "Passenger.count", -1
    end

    it "should not delete if passenger is nil" do
      # Act
      delete passenger_path(-1)
      # Assert
      must_respond_with 404
    end
  end
end
