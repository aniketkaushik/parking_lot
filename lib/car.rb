# frozen_string_literal: true
class Car

  attr_accessor :registration_number, :color
  def initialize(registration_number, color)
    @registration_number = registration_number
    @color = color
  end

end