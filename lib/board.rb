# frozen_string_literal: true

# Essential elements of a chess board
class Board
  attr_reader :spaces

  def initialize
    @spaces = initialize_spaces
  end

  def initialize_spaces
    spaces_array = []
    (0..7).each do |x|
      (0..7).each do |y|
        spaces_array << [x, y]
      end
    end
    spaces_array
  end
end
