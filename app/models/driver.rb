# frozen_string_literal: true
class Driver < ApplicationRecord
  # after_initialize :set_availability
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true

  def average_rating
    ratings = trips.map {|trip| trip.rating}
    if ratings = 0
      return "NIL"
    end
    total_ratings = 0
    ratings.each do |rating|
      total_ratings += rating
    end
    average = total_ratings.to_f / ratings.length
    return average.round(1)
  end
  
  def total_money
    costs = trips.map {|trip| trip.cost}
    total = 0
    costs.each do |cost|
      total += cost
      total = total.to_f
    end
    return total.round(2)/100
  end

  def after_fee
    total = total_money
    fee = 1.65
    total = (total - fee) * 0.8
    if total < 0
      return 0
    end
    return total = total.round(2)
  end
end
