# frozen_string_literal: true

require_relative "gilded_rose/item"
require_relative "gilded_rose/updaters"

class GildedRose
  class UnknownItem < StandardError; end

  UPDATER_FOR_ITEM = {
    "+5 Dexterity Vest" => Updaters::Default,
    "Elixir of the Mongoose" => Updaters::Default,
    "Aged Brie" => Updaters::AgedBrie,
    "Sulfuras, Hand of Ragnaros" => Updaters::Sulfuras,
    "Backstage passes to a TAFKAL80ETC concert" => Updaters::Backstage,
    "Conjured Mana Cake" => Updaters::Conjured,
  }.freeze

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      UPDATER_FOR_ITEM[item.name].new(item).update_quality
    rescue NoMethodError
      raise UnknownItem, "An unknown item found => #{item.name}. The system doesn't know how to handle it."
    end
  end
end
