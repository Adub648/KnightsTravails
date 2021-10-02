# frozen_string_literal: true

class Node
  attr_accessor :data, :children, :parent

  # initial values for node
  def initialize(data, parent = nil)
    @data = data
    @children = []
    @parent = parent
  end
end
