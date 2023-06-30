# frozen_string_literal: true


module Updaters
  class AgedBrie < Default
    # "Aged Brie" increases in Quality the older it gets
    def update_quality
      @item.sell_in -= 1
      increase_quality
    end
  end
end
