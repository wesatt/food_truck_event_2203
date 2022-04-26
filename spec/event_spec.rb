require "date"
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
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)

      expect(event.food_truck_names).to eq(["Rocky Mountain Pies",
        "Ba-Nom-a-Nom",
        "Palisade Peach Shack"])
    end

    it "can list food trucks that sell a given item" do
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)

      expect(event.food_trucks_that_sell(item1)).to eq([food_truck1, food_truck3])
      expect(event.food_trucks_that_sell(item4)).to eq([food_truck2])
    end
  end

  describe "iteration 3" do
    let(:event) { Event.new("South Pearl Street Farmers Market") }
    let(:item1) { Item.new({name: "Peach Pie (Slice)", price: "$3.75"}) }
    # <Item:0x007f9c56740d48...>
    let(:item2) { Item.new({name: "Apple Pie (Slice)", price: "$2.50"}) }
    # <Item:0x007f9c565c0ce8...>
    let(:item3) { Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"}) }
    # <Item:0x007f9c562a5f18...>
    let(:item4) { Item.new({name: "Banana Nice Cream", price: "$4.25"}) }
    # <Item:0x007f9c56343038...>
    let(:food_truck1) { FoodTruck.new("Rocky Mountain Pies") }
    let(:food_truck2) { FoodTruck.new("Ba-Nom-a-Nom") }
    let(:food_truck3) { FoodTruck.new("Palisade Peach Shack") }
    before :each do
      food_truck1.stock(item1, 35)
      food_truck1.stock(item2, 7)
      food_truck2.stock(item4, 50)
      food_truck2.stock(item3, 25)
      food_truck3.stock(item1, 65)
      food_truck3.stock(item3, 10)
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)
    end

    it "can return all available items in a sorted list" do
      expect(event.sorted_item_list).to eq([item2, item4, item1, item3])
    end

    it "can display a list of overstocked items" do
      expect(event.overstocked_items).to eq([item1])
    end

    it "can display total inventory" do
      expect = {
        item1 => {
          quantity: 100,
          food_trucks: [food_truck1, food_truck3]
        },
        item2 => {
          quantity: 7,
          food_trucks: [food_truck1]
        },
        item4 => {
          quantity: 50,
          food_trucks: [food_truck2]
        },
        item3 => {
          quantity: 35,
          food_trucks: [food_truck2, food_truck3]
        }
      }
      expect(event.total_inventory).to eq(expect)
    end
  end

  describe "iteration 4" do
    let(:item1) { Item.new({name: "Peach Pie (Slice)", price: "$3.75"}) }
    #=> #<Item:0x007f9c56740d48...>
    let(:item2) { Item.new({name: "Apple Pie (Slice)", price: "$2.50"}) }
    #=> #<Item:0x007f9c565c0ce8...>
    let(:item3) { Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"}) }
    #=> #<Item:0x007f9c562a5f18...>
    let(:item4) { Item.new({name: "Banana Nice Cream", price: "$4.25"}) }
    #=> #<Item:0x007f9c56343038...>
    let(:item5) { Item.new({name: "Onion Pie", price: "$25.00"}) }
    #=> #<Item:0x007f9c561636c8...>
    let(:event) { Event.new("South Pearl Street Farmers Market") }
    #=> #<Event:0x00007fe134933e20...>
    let(:food_truck1) { FoodTruck.new("Rocky Mountain Pies") }
    #=> #<FoodTruck:0x00007fe1348a1160...>
    let(:food_truck2) { FoodTruck.new("Ba-Nom-a-Nom") }
    #=> #<FoodTruck:0x00007fe1349bed40...>
    let(:food_truck3) { FoodTruck.new("Palisade Peach Shack") }
    #=> #<FoodTruck:0x00007fe134910650...>
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

    it "is created with a date" do
      allow(Date).to receive(:today).and_return(Date.parse("24-02-2020"))

      expect(event.date).to eq("24/02/2020")
    end

    it "can sell items and reduce stock" do
      expect(event.sell(item1, 200)).to eq false
      expect(event.sell(item5, 1)).to eq false
      expect(event.sell(item4, 5)).to eq true
      expect(food_truck2.check_stock(item4)).to eq(45)
      expect(event.sell(item1, 40)).to eq true
      expect(food_truck1.check_stock(item1)).to eq(0)
      expect(food_truck3.check_stock(item1)).to eq(60)
    end
  end
end
