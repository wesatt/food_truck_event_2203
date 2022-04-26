require "./lib/item"
require "./lib/food_truck"
require "./lib/event"

RSpec.describe Event do
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
    end

    it "exists and has attributes" do
      expect(event).to be_a Event
      expect(event.name).to eq("South Pearl Street Farmers Market")
      expect(event.food_trucks).to eq([])
    end

    it "can add food trucks" do
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)

      expect(event.food_trucks).to eq([food_truck1, food_truck2, food_truck3])
    end

    it "can display the names of food trucks" do
      expect(event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end
end
