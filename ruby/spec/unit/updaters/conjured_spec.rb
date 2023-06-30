# frozen_string_literal: true

require_relative "../../spec_helper"

describe Updaters::Conjured do

  context "#update_quality" do
    let(:item) { Item.new("foo", 2, 3) }

    it "should decreases in quality twice as faster then default" do
      expect {
        Updaters::Conjured.new(item).update_quality
      }.to change(item, :sell_in).by(-1)
        .and change(item, :quality).by(-2)
    end
  end
end
