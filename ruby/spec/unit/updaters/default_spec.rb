# frozen_string_literal: true

require_relative "../../spec_helper"

describe Updaters::Default do

  it "The Default update should update quality" do
    item = Item.new("foo", 2, 1)

    expect {
      Updaters::Default.new(item).update_quality
    }.to change(item, :sell_in).by(-1)
      .and change(item, :quality).by(-1)
  end

  context "#increase_quality" do
    it "should update quality of the item" do
      item = Item.new("foo", 2, 1)

      expect {
        Updaters::Default.new(item).increase_quality
      }.to change(item, :quality).by(1)
    end

    it "should increase quality by 2 if sell_in date has passed" do
      item = Item.new("foo", -1, 1)

      expect {
        Updaters::Default.new(item).increase_quality
      }.to change(item, :quality).by(2)
    end

    it "quality should not exceed the 50 limit" do
      item = Item.new("foo", 5, 50)

      expect {
        Updaters::Default.new(item).increase_quality
      }.not_to change(item, :quality)
    end
  end

  context "#decrease_quality" do
    it "should decrease quality" do
      item = Item.new("foo", 5, 50)

      expect {
        Updaters::Default.new(item).decrease_quality
      }.to change(item, :quality).by(-1)
    end

    it "should decrease quality as fast as twice when sell_in has passed" do
      item = Item.new("foo", -1, 5)

      expect {
        Updaters::Default.new(item).decrease_quality
      }.to change(item, :quality).by(-2)
    end


    it "should not decrease quality below zero" do
      item = Item.new("foo", -1, 0)

      expect {
        Updaters::Default.new(item).decrease_quality
      }.not_to change(item, :quality)
    end
  end
end
