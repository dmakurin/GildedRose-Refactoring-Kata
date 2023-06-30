# frozen_string_literal: true


module Updaters
  class Backstage < Default
    def update_quality
      calculate_quality
      @item.sell_in -= 1
    end

    private

    # Calculates quality for the Backstage item.
    # Following next rules:
    #   * "Backstage passes" increases in Quality as its SellIn value approaches
    #       Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
    #   * Quality drops to 0 after the concert
    def calculate_quality
      increase_quality

      # Quality increases by 2 when there are 10 days or less
      if @item.sell_in < 11
        increase_quality
      end

      # Quality increases by 3 when there are 5 days or less
      if @item.sell_in < 6
        increase_quality
      end

      # After concert ends quality drops to 0
      if @item.sell_in <= 0
        @item.quality = 0
      end
    end
  end
end
