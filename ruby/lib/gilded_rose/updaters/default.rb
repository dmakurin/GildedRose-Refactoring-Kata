# frozen_string_literal: true


module Updaters
  # A default class for +updater+ of GildedRose's item
  # Decreases the sell_in date at every update
  # Decreases the quality at every update
  class Default
    # Basic methods for the +updaters+
    include Helper

    def initialize(item)
      @item = item
    end
  end
end
