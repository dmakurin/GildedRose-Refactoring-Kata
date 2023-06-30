# frozen_string_literal: true

require_relative "../../spec_helper"

RSpec::Matchers.define_negated_matcher :not_change, :change

describe Updaters::Sulfuras do

  context "#update_quality" do
    let(:item) { Item.new("foo", 2, 80) }

    it "should change nothing" do
      expect {
        Updaters::Sulfuras.new(item).update_quality
      }.to not_change(item, :sell_in)
        .and not_change(item, :quality)
    end
  end
end
