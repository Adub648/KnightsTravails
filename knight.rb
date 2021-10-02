# frozen_string_literal: true
require_relative 'node'

class Knight
  attr_accessor :initial_pos

  # initial values
  def initialize
    @found = false
  end

  # get start value and start traversal
  def knight_moves(initial, end_val)
    if initial[0] <= 7 && initial[1] <= 7
      initial = Node.new(initial)
    else
      initial = Node.new([0, 0])
    end
    @initial = initial
    @end_val = end_val
    traverse_tree
  end

  # add the possible moves as children to the set node
  def add_possible_moves(initial)
    if initial == nil
      return
    end
    arr = initial.data
    child_arr = initial.children
    arr1 = arr[0]
    arr2 = arr[1]
    if arr1 - 1 >= 0 && arr2 + 2 <= 7
      child_arr.append(Node.new([arr1 - 1, arr2 + 2], initial))
    end 
    if arr1 + 1 <= 7 && arr2 + 2 <= 7
      child_arr.append(Node.new([arr1 + 1, arr2 + 2], initial))
    end
    if arr1 + 2 <= 7 && arr2 + 1 <= 7
      child_arr.append(Node.new([arr1 + 2, arr2 + 1], initial))
    end
    if arr1 + 2 <= 7 && arr2 - 1 >= 0
      child_arr.append(Node.new([arr1 + 2, arr2 - 1], initial))
    end
    if arr1 + 1 <= 7 && arr2 - 2 >= 0
      child_arr.append(Node.new([arr1 + 1, arr2 - 2], initial))
    end
    if arr1 - 1 >= 0 && arr2 - 2 >= 0
      child_arr.append(Node.new([arr1 - 1, arr2 - 2], initial))
    end
    if arr1 - 2 >= 0 && arr2 - 1 >= 0
      child_arr.append(Node.new([arr1 - 2, arr2 - 1], initial))
    end
    if arr1 - 2 >= 0 && arr2 + 1 <= 7
      child_arr.append(Node.new([arr1 - 2, arr2 + 1], initial))
    end
    return child_arr
  end

  # check if given position is the end position
  def check_moves(pos)
    if pos.data == @end_val
      @found = true
      find_parents(pos)
    end
  end

  # traverse tree using breadth first search
  def traverse_tree
    return if @initial.nil?

    queue = []
    queue.push(@initial)

    while !queue.empty?

      size = queue.length
      i = 0

      # search the queue
      while i < size
        pos = queue.shift

        # check first value in queue
        if !pos.nil?
          check_moves(pos)
        end

        if @found == true
          return
        end

        # add children to queue
        new_items = add_possible_moves(pos)
        queue.concat(new_items)
        i += 1
      end

    end
  end

  # find the parents of given element and display in array
  def find_parents(pos)
    arr = []
    until pos.parent == nil
      pos = pos.parent
      arr.append(pos.data)
    end
    arr = arr.reverse
    arr.append(@end_val)
    display_result(arr)
  end

  # display number of moves and exact moves required to get there
  def display_result(arr)
    puts "You made it in #{arr.length} moves! Here's your path:"
    arr.each do |i|
      p i
    end
    p @end_val
  end
end

# create knight and ask for input from user
def game
  knight = Knight.new()

  puts "Please enter the x coordinate of the start point of the knight"
  start_point_x = gets.chomp[0,1].to_i
  if start_point_x > 7 || start_point_x < 0
    start_point_x = 0
  end

  puts "Please enter the y coordinate of the start point of the knight"
  start_point_y = gets.chomp[0,1].to_i
  if start_point_y > 7 || start_point_y < 0
    start_point_y = 0
  end

  start_point = [start_point_x, start_point_y]

  puts "Please enter the x coordinate of the end point of the knight"
  end_point_x = gets.chomp[0,1].to_i
  if end_point_x > 7 || end_point_x < 0
    end_point_x = 0
  end

  puts "Please enter the y coordinate of the end point of the knight"
  end_point_y = gets.chomp[0,1].to_i
  if end_point_y > 7 || end_point_y < 0
    end_point_y = 0
  end

  end_point = [end_point_x, end_point_y]

  knight.knight_moves(start_point, end_point)
  if play_again?
    game
  else
    exit
  end
end

# ask user to play again
def play_again?
  puts "Would you like to play again? Enter \"Y\" for yes and \"N\" for no."
  input = gets.chomp

  if input.downcase == "y"
    return true
  else
    return false
  end
end

game

# pseudocode, NOT WHAT THE FINAL SOLUTION IS

# not sure if this is going to work, somehow need to make the graph dynamic while getting rid of things
# create tree with all first moves possible
# add all second moves possible to each tree, checking to make sure that they are on the board
# scan tree each time, if found the last position stop
# trace from last position to tree root and output, binary search?

# when creating each element, search the tree and if it is already present then don't make it
# when traversing the tree, add and remove elements from a temporary array so that you can determine the length of it and what it contains

# or what if we keep on creating sub trees until all elements for all children are nil, but could be too much