class Event
  attr_reader :name,
    :food_trucks,
    :date

  def initialize(name)
    @name = name
    @food_trucks = []
    @date = Date.today.strftime("%d/%m/%Y")
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

  def item_array_helper
    # returns full list of all items, including duplicates
    @food_trucks.map { |food_truck| food_truck.inventory.keys }.flatten
  end

  def sorted_item_list
    item_array_helper.uniq.sort_by { |item| item.name }
  end

  def overstocked_items
    dupes = item_array_helper.find_all do |item|
      item if item_array_helper.count(item) > 1
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

  def total_inventory
    total = Hash.new(0)
    item_array_helper.uniq.each do |item|
      total[item] = {quantity: 0, food_trucks: []}
    end
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, qty|
        total[item][:quantity] += qty
        total[item][:food_trucks] << food_truck
      end
    end
    total
  end
end
