class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  def assign_trip
    assigned_driver = Driver.find { |driver| driver.available == true }
    self.driver_id = assigned_driver.id
    self.date = Date.today.to_s
    self.rating = nil
    self.cost = rand(12.0..30.00)
  end


  def self.format_money(price)
    return price/100.to_f
  end
end
