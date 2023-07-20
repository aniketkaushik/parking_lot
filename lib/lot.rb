# frozen_string_literal: true

require_relative './slot'
class NoLotError < StandardError; end
class Lot
  attr_accessor :slots

  def initialize(total_slots)
    @slots = []
    total_slots.to_i.times do |slot_index|
      slot_number = slot_index + 1
      slots[slot_index] = Slot.new(slot_number)
    end
    puts "Created a parking lot with #{ total_slots } slots"
  end

  def park(registration_number, color)
    if !find_car_with_reg_number(registration_number).nil?
      puts "Car already parked!"
    elsif (next_nearest_slot = slots.find { |slot| slot.is_free? })
      next_nearest_slot.park(registration_number, color)
      puts "Allocated slot number: #{next_nearest_slot.slot_number}"
    else
      puts "Sorry, parking lot is full"
    end
  end

  def leave(slot_number)
    slot_number = slot_number.to_i
    if slot_number > 0 && (slot_number <= slots.size)
      slot_index = slot_number - 1
      slots[slot_index].mark_free!
      puts "Slot number #{slot_number} is free"
    else
      puts "Invalid slot number"
    end
  end

  def status
    puts "Slot No.    Registration No    Color"
    slots.each do | slot |
      puts "#{ slot.slot_number }           #{ slot.registration_number
      }      #{ slot.color }" unless (slot.is_free?)
    end
  end

  def registration_numbers_for_cars_with_color(color)
    filtered_cars = filter_cars('registration_number', 'color', color)
    puts filtered_cars.compact.join(', ')
  end

  def slot_numbers_for_cars_with_color(color)
    filtered_cars = filter_cars('slot_number', 'color', color)
    puts filtered_cars.compact.join(', ')
  end

  def slot_number_for_registration_number(registration_number)
    slot = find_car_with_reg_number(registration_number)
    puts slot ? slot.slot_number : 'Not found'
  end

  private
  def filter_cars(filtered_value, filter_by, filter)
    slots.collect do |slot|
      slot.send(filtered_value) if slot.send(filter_by) == filter
    end
  end

  def find_car_with_reg_number(registration_number)
    slots.find { |slot| slot.registration_number == registration_number }
  end
end