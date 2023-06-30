# frozen_string_literal: true

require_relative "../../spec_helper"

describe Updaters::AgedBrie do

  context "#update_quality" do
    let(:item) { Item.new("foo", 2, 3) }

    it "should increase quality" do
      expect {
        Updaters::AgedBrie.new(item).update_quality
      }.to change(item, :sell_in).by(-1)
        .and change(item, :quality).by(1)
    end
  end
end
