# frozen_string_literal: true

require_relative './car'

class ParkError < StandardError; end

class Slot

  attr_accessor :slot_number, :car

  def initialize(slot_number)
    @slot_number = slot_number.to_i
  end

  def park(registration_number, colour)
    if self.car
      raise ParkError
    else
      self.car = ::Car.new(registration_number, colour)
    end
  end

  def mark_free!
    self.car = nil
  end

  def is_free?
    self.car == nil
  end

  def registration_number
    car.registration_number if car
  end

  def color
    car.color if car
  end
end
