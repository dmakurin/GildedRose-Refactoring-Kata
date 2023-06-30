# frozen_string_literal: true

require_relative "../../spec_helper"

RSpec::Matchers.define_negated_matcher :not_change, :change

describe Updaters::Backstage do

  context "#update_quality" do
    let(:item) { Item.new("foo", 11, 3) }

    it "should increase quality" do
      expect {
        Updaters::Backstage.new(item).update_quality
      }.to change(item, :sell_in).by(-1)
        .and change(item, :quality).by(1)
    end

    it "should increase quality by 2 when 10 or less days left" do
      item.sell_in = 9
      expect {
        Updaters::Backstage.new(item).update_quality
      }.to change(item, :sell_in).by(-1)
        .and change(item, :quality).by(2)
    end

    it "should increase quality by 3 when 5 or less days left" do
      item.sell_in = 4
      expect {
        Updaters::Backstage.new(item).update_quality
      }.to change(item, :sell_in).by(-1)
                                 .and change(item, :quality).by(3)
    end

    it "should never exceed the 50 limit" do
      item.sell_in = 4
      item.quality = 50
      expect {
        Updaters::Backstage.new(item).update_quality
      }.to change(item, :sell_in).by(-1)
                                 .and not_change(item, :quality)
    end

    it "quality should drop to 0 when sell_in date has passed" do
      item.sell_in = -1
      item.quality = 50
      expect {
        Updaters::Backstage.new(item).update_quality
      }.to change(item, :sell_in).by(-1)
        .and change(item, :quality).by(-50)
    end
  end
end
