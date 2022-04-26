require "date"
require "./lib/item"
require "./lib/food_truck"
require "./lib/event"

RSpec.describe FoodTruck do
  describe "iteration 1" do
    let(:item1) { Item.new({name: "Peach Pie (Slice)", price: "$3.75"}) }
    let(:item2) { Item.new({name: "Apple Pie (Slice)", price: "$2.50"}) }
    let(:food_truck) { FoodTruck.new("Rocky Mountain Pies") }

    it "exists and has attributes" do
      expect(food_truck.name).to eq("Rocky Mountain Pies")
      expect(food_truck.inventory).to eq({})
    end

    it "can check stock of and add qty to food items" do
      expect(food_truck.check_stock(item1)).to eq(0)

      food_truck.stock(item1, 30)

      expect(food_truck.inventory).to eq({item1 => 30})
      expect(food_truck.check_stock(item1)).to eq(30)

      food_truck.stock(item1, 25)

      expect(food_truck.check_stock(item1)).to eq(55)

      food_truck.stock(item2, 12)

      expect(food_truck.inventory).to eq({item1 => 55, item2 => 12})
    end
  end

  describe "iteration 2" do
    let(:event) { Event.new("South Pearl Street Farmers Market") }
    let(:food_truck1) { FoodTruck.new("Rocky Mountain Pies") }
    let(:item1) { Item.new({name: "Peach Pie (Slice)", price: "$3.75"}) }
    let(:item2) { Item.new({name: "Apple Pie (Slice)", price: "$2.50"}) }
    let(:item3) { Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"}) }
    let(:item4) { Item.new({name: "Banana Nice Cream", price: "$4.25"}) }
    let(:food_truck2) { FoodTruck.new("Ba-Nom-a-Nom") }
    let(:food_truck3) { FoodTruck.new("Palisade Peach Shack") }
    before :each do
      food_truck1.stock(item1, 35)
      food_truck1.stock(item2, 7)
      food_truck2.stock(item4, 50)
      food_truck2.stock(item3, 25)
      food_truck3.stock(item1, 65)
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)
    end

    it "can display potential revenue" do
      expect(food_truck1.potential_revenue).to eq 148.75
      expect(food_truck2.potential_revenue).to eq 345.00
      expect(food_truck3.potential_revenue).to eq 243.75
    end
  end
end
