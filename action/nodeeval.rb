class Node

  attr_reader :label, :children

  def initialize(label, *children)
    @label = label
    @children = children
  end

  def eval
    if @label == "+" then
      l = @children[0].eval
      r = @children[1].eval
      return l+r
    elsif @label == "*" then
      l = @children[0].eval
      r = @children[1].eval
      return l*r
    else
      return @label.to_i
    end
  end
end

n1 = Node.new("1")
n2 = Node.new("2")
n3 = Node.new("3")

nm = Node.new("*",n2,n3)
np = Node.new("+",n1,nm)

puts np.eval
