# frozen_string_literal: true

module Updaters
  class Sulfuras < Default
    # "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
    def update_quality; end
  end
end
