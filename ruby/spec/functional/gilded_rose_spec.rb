# frozen_string_literal: true

require_relative "../spec_helper"

describe GildedRose do

  describe "#update_quality" do
    let(:items) do
      [
        Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20),
        Item.new(name="Aged Brie", sell_in=2, quality=0),
        Item.new(name="Elixir of the Mongoose", sell_in=5, quality=7),
        Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80),
        Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=-1, quality=80),
        Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20),
        Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=49),
        Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=49),
        Item.new(name="Conjured Mana Cake", sell_in=3, quality=6),
      ]
    end

    it "updates quality for a one day" do
      GildedRose.new(items).update_quality

      expect(items[0].name).to eq "+5 Dexterity Vest"
      expect(items[0].sell_in).to eq 9 # -1
      expect(items[0].quality).to eq 19 # -1

      expect(items[1].name).to eq "Aged Brie"
      expect(items[1].sell_in).to eq 1 # -1
      expect(items[1].quality).to eq 1 # +1

      expect(items[2].name).to eq "Elixir of the Mongoose"
      expect(items[2].sell_in).to eq 4 # -1
      expect(items[2].quality).to eq 6 # -1

      expect(items[3].name).to eq "Sulfuras, Hand of Ragnaros"
      expect(items[3].sell_in).to eq 0 # not changed
      expect(items[3].quality).to eq 80 # not changed

      expect(items[4].name).to eq "Sulfuras, Hand of Ragnaros"
      expect(items[4].sell_in).to eq -1 # not changed
      expect(items[4].quality).to eq 80 # not changed

      expect(items[5].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(items[5].sell_in).to eq 14 # -1
      expect(items[5].quality).to eq 21 # -1

      expect(items[6].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(items[6].sell_in).to eq 9 # -1
      expect(items[6].quality).to eq 50 # +1 (capped)

      expect(items[7].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(items[7].sell_in).to eq 4 # -1
      expect(items[7].quality).to eq 50 # +1 (capped)

      expect(items[8].name).to eq "Conjured Mana Cake"
      expect(items[8].sell_in).to eq 2 # -1
      expect(items[8].quality).to eq 4 # -2
    end

    it "updates quality for five days" do
      5.times { GildedRose.new(items).update_quality }

      expect(items[0].name).to eq "+5 Dexterity Vest"
      expect(items[0].sell_in).to eq 5 # -5
      expect(items[0].quality).to eq 15 # -5

      expect(items[1].name).to eq "Aged Brie"
      expect(items[1].sell_in).to eq -3 # -5
      expect(items[1].quality).to eq 8 # +8

      expect(items[2].name).to eq "Elixir of the Mongoose"
      expect(items[2].sell_in).to eq 0 # -5
      expect(items[2].quality).to eq 2 # -5

      expect(items[3].name).to eq "Sulfuras, Hand of Ragnaros"
      expect(items[3].sell_in).to eq 0 # not changed
      expect(items[3].quality).to eq 80 # not changed

      expect(items[4].name).to eq "Sulfuras, Hand of Ragnaros"
      expect(items[4].sell_in).to eq -1 # not changed
      expect(items[4].quality).to eq 80 # not changed

      expect(items[5].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(items[5].sell_in).to eq 10 # -5
      expect(items[5].quality).to eq 25 # +5

      expect(items[6].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(items[6].sell_in).to eq 5 # -5
      expect(items[6].quality).to eq 50 # capped at 50

      expect(items[7].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(items[7].sell_in).to eq 0 # -5
      expect(items[7].quality).to eq 50 # capped at 50

      expect(items[8].name).to eq "Conjured Mana Cake"
      expect(items[8].sell_in).to eq -2 # -5
      expect(items[8].quality).to eq 0 # -6
    end

    it "updates quality for 11 days" do
      11.times { GildedRose.new(items).update_quality }

      expect(items[0].name).to eq "+5 Dexterity Vest"
      expect(items[0].sell_in).to eq -1
      expect(items[0].quality).to eq 8

      expect(items[1].name).to eq "Aged Brie"
      expect(items[1].sell_in).to eq -9
      expect(items[1].quality).to eq 20

      expect(items[2].name).to eq "Elixir of the Mongoose"
      expect(items[2].sell_in).to eq -6
      expect(items[2].quality).to eq 0

      expect(items[3].name).to eq "Sulfuras, Hand of Ragnaros"
      expect(items[3].sell_in).to eq 0 # not changed
      expect(items[3].quality).to eq 80 # not changed

      expect(items[4].name).to eq "Sulfuras, Hand of Ragnaros"
      expect(items[4].sell_in).to eq -1 # not changed
      expect(items[4].quality).to eq 80 # not changed

      expect(items[5].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(items[5].sell_in).to eq 4
      expect(items[5].quality).to eq 38

      expect(items[6].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(items[6].sell_in).to eq -1
      expect(items[6].quality).to eq 0

      expect(items[7].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(items[7].sell_in).to eq -6
      expect(items[7].quality).to eq 0

      expect(items[8].name).to eq "Conjured Mana Cake"
      expect(items[8].sell_in).to eq -8
      expect(items[8].quality).to eq 0
    end
  end
end
