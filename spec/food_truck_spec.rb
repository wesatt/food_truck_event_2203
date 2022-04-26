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
end
