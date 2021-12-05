require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      @driver = Driver.new("rachael", "alsdkjf")

      # Act
      get drivers_path
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      @driver = Driver.new("rachael", "alsdkjf")

      # Act
      get drivers_path
      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      valid_driver = Driver.create(name: 'Sean Gomez', vin:'afdfdag')
      # Act
      get driver_path(valid_driver)
      # Assert
      must_respond_with :success

    end

    it "responds with 404 with an invalid driver id" do
      bad_driver = "liar boy"

      # Act
      get driver_path(bad_driver)

      # Assert
      must_respond_with 404

    end
  end

  describe "new" do
    it "responds with success" do
      get new_driver_path

      must_respond_wtih :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      driver_hash = {driver: {
          name: "Odin",
          vin: "slafkdj"
      },
      }

      # Act-Assert
      expect { post drivers_path, params: driver_hash }.must_differ "Driver.count", 1
      valid_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(valid_driver.vin).must_equal driver_hash[:driver][:vin]

      # Assert
      must_respond_with :redirect
      must_redirect_to driver_path(valid_driver)

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      bad_driver = "liar boy"

      # Act
      get
      driver_path(bad_driver)

      # Assert
      must_respond_with 404

    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      valid_driver = Driver.create(name: 'Jean Donnelly', vin:'120-307-6251')

      # Act
      get edit_drivers_path(valid_driver)
      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      bad_driver = "liar boy"

      # Act
      get edit_driver_path(bad_driver)

      # Assert
      must_respond_with 404

    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      original_driver = Driver.create(name: "Sean O'Neill", vin:'WJLF808')
      original_id =  original_driver.id

      updated_hash = {
          driver: {
              name: 'Peter',
              vin: '1783hfsl'
          }
      }

      expect {
        patch driver_path(original_driver), params: updated_hash
      }.wont_change "Driver.count"

      updated_driver = Driver.find_by(id: original_id)

      expect(updated_driver.name).must_equal updated_hash[:driver][:name]
      expect(updated_driver.vin).must_equal updated_hash[:driver][:vin]

      must_respond_with :redirect
      must_redirect_to driver_path(updated_driver)

    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data
      bad_driver = "liar boy"

      # Act-Assert
      expect{patch driver_path(bad_driver)}.must_respond_wtih 404
      # Assert
      # Check that the controller gave back a 404

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller redirects

    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      delete_valid_passenger = Passenger.create(name: "Sean O'Neill", vin: "ADFASDF")

      expect {
        delete driver_path(delete_valid_passenger)
      }.must_differ "Driver.count", -1
    end


    it "does not change the db when the driver does not exist, then responds with " do
      delete driver_path(-1)
      # Assert
      must_respond_with 404
    end

    end
  end
end
