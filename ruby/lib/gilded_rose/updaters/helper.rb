# frozen_string_literal: true


module Updaters
  # This is a helper for all +updaters+
  # That used to update quality of the GildedRose +Items+
  #
  # Contains basic methods to adjust an +item+ properties
  module Helper
    # Increases the +quality+ by one until it reaches a limit (50)
    # If sell by date has passed, increases by two
    def increase_quality
      # @item.quality += 1 if quality < 50
      if @item.quality < 50
        @item.quality += 1
      end

      # Sell in date has passed
      if @item.sell_in < 0 && @item.quality < 50
        @item.quality += 1
      end
    end

    # Decreases the +quality+ by one
    # If sell by date has passed, decreases by two
    #
    # The Quality of an item is never negative
    def decrease_quality
      if @item.quality > 0
        @item.quality -= 1
      end

      # Sell in date has passed
      if @item.sell_in < 0 && @item.quality > 0
        @item.quality -= 1
      end
    end

    # Might be redefined in subclasses
    # Updates +quality+ and +sell_in+ fields for a given item
    def update_quality
      @item.sell_in -= 1
      decrease_quality
    end
  end
end
