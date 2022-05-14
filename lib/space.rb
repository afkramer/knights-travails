# frozen_string_literal: true

# A space contains its own coordinates and a list of adjacent coordinates
class Space
  attr_accessor :adjacent_coords

  def initialize(coords)
    @coords = coords
    @adjacent_coords = []
  end
end
