# frozen_string_literal: true


module Updaters
  class Conjured < Default
    # "Conjured" items degrade in Quality twice as fast as normal items
    def update_quality
      @item.sell_in -= 1
      2.times { decrease_quality }
    end
  end
end
