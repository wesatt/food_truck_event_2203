class Event
  attr_reader :name,
    :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map { |food_truck| food_truck.name }
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all do |food_truck|
      food_truck.inventory.include?(item)
    end
  end

  def sorted_item_list
    item_arr = @food_trucks.map { |food_truck| food_truck.inventory.keys }.flatten.uniq
    item_arr.sort_by { |item| item.name }
  end

  def overstocked_items
    items = @food_trucks.map { |food_truck| food_truck.inventory.keys }.flatten
    dupes = items.find_all do |item|
      item if items.count(item) > 1
    end.uniq
    duplicate_quantities = Hash.new(0)
    dupes.each do |item|
      duplicate_quantities[item]
      @food_trucks.each do |food_truck|
        duplicate_quantities[item] += food_truck.inventory[item] if !food_truck.inventory[item].nil?
      end
    end
    overstocked = []
    duplicate_quantities.each do |item, total|
      overstocked << item if total > 50
    end
    overstocked
  end
end
