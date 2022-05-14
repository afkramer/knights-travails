# frozen_string_literal: true

# Basic functionality of the knight chess piece
class Knight
  attr_reader :moves_adjacency_list

  def initialize
    @board = Board.new
    @possible_moves = [[1, 2], [-1, 2], [1, -2], [-1, -2], [2, 1], [-2, 1], [2, -1], [-2, -1]]
    @moves_adjacency_list = initialize_adjacency_list
  end

  def initialize_adjacency_list
    adjacency_list = []
    @board.spaces.each do |board_coords|
      space = Space.new(board_coords)
      @possible_moves.each do |move_coords|
        space.adjacent_coords << move(board_coords, move_coords) if allowable_move?(board_coords, move_coords)
        # necessary for search later?
        space.adjacent_coords.sort!
      end
      adjacency_list << space
    end
    adjacency_list
  end

  def allowable_move?(start_coords, move_coords)
    # Check if the final position is on the board
    @board.spaces.include?(move(start_coords, move_coords))
  end

  def move(start_coords, move_coords)
    [start_coords[0] + move_coords[0], start_coords[1] + move_coords[1]]
  end

  def knight_moves(start_coords, end_coords, prev_coords = [], moves_required = [])
    return nil if moves_required.include?(start_coords)

    moves_required << start_coords
    space = @moves_adjacency_list[@board.spaces.index(start_coords)]
    if space.adjacent_coords.include?(end_coords)
      moves_required << end_coords
      return moves_required
    end

    good_paths = 0
    space.adjacent_coords.each do |coords|
      break if moves_required.include?(end_coords)

      if move_makes_sense?(coords, start_coords, prev_coords, end_coords)
        good_paths += 1
        moves_required = knight_moves(coords, end_coords, start_coords, moves_required)
      end
    end
    return moves_required[0..-2] if good_paths.zero?

    moves_required
  end

  def move_makes_sense?(coords_to_test, start_coords, prev_coords, end_coords)
    return false if coords_to_test == prev_coords

    return false if too_close?(coords_to_test, end_coords)

    return true if both_coords_between?(coords_to_test, start_coords, end_coords)

    return true if coord_between_and_coord_within_bounds?(coords_to_test, start_coords, end_coords)

    return true if next_move_end?(coords_to_test, end_coords)

    false
  end

  def too_close?(coords_to_test, end_coords)
    too_close_coords = [[-2, 2], [-2, -2], [2, -2], [2, 2], [0, 1], [-1, 0], [0, -1], [1, 0], [-1, 1], [-1, -1], [1, -1], [1, 1]]
    too_close_coords.each do |coords|
      return true if coords_to_test == [end_coords[0] + coords[0], end_coords[1] + coords[1]]
    end
    false
  end

  def both_coords_between?(coords_to_test, start_coords, end_coords)
    x_between = coord_between?(coords_to_test[0], start_coords[0], end_coords[0])
    y_between = coord_between?(coords_to_test[1], start_coords[1], end_coords[1])
    y_between && x_between
  end

  def coord_between_and_coord_within_bounds?(coords_to_test, start_coords, end_coords)
    x_between = coord_between?(coords_to_test[0], start_coords[0], end_coords[0])
    y_between = coord_between?(coords_to_test[1], start_coords[1], end_coords[1])
    x_within = coord_within_bounds?(coords_to_test[0], end_coords[0], 2)
    y_within = coord_within_bounds?(coords_to_test[1], end_coords[1], 2)
    (x_between && y_within) || (y_between && x_within)
  end

  def next_move_end?(coords_to_test, end_coords)
    x_1_away = coord_within_bounds?(coords_to_test[0], end_coords[0], 1)
    x_2_away = coord_within_bounds?(coords_to_test[0], end_coords[0], 2)
    y_1_away = coord_within_bounds?(coords_to_test[1], end_coords[1], 1)
    y_2_away = coord_within_bounds?(coords_to_test[1], end_coords[1], 2)
    (x_1_away && y_2_away) || (x_2_away && y_1_away)
  end

  def coord_between?(next_val, start_val, end_val)
    (start_val <= next_val && next_val <= end_val) || (start_val >= next_val && next_val >= end_val)
  end

  def coord_within_bounds?(coord_to_test, end_coord, distance)
    if coord_to_test < end_coord
      end_coord - distance <= coord_to_test && coord_to_test <= end_coord
    else
      end_coord <= coord_to_test && coord_to_test <= end_coord + distance
    end
  end
end
