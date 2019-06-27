class Node

  attr_reader :label, :children

  def initialize(label, *children)
    @label = label
    @children = children
  end
end

def eval(node)
  if node.label == "+" then
    l = eval(node.children[0])
    r = eval(node.children[1])
    return l+r
  elsif node.label == "-" then
    l = eval(node.children[0])
    r = eval(node.children[1])
    return l-r
  elsif node.label == "*" then
    l = eval(node.children[0])
    r = eval(node.children[1])
    return l*r
  elsif node.label == "/" then
    l = eval(node.children[0])
    r = eval(node.children[1])
    return l/r
  else
    return node.label.to_i
  end
end

n1 = Node.new("1")
n2 = Node.new("2")
n3 = Node.new("3")
n4 = Node.new("4")
n5 = Node.new("5")

nmult = Node.new("*",n5,n4)
nplus = Node.new("+",nmult,n1)
ndiv = Node.new("/",nplus,n3)
nminus = Node.new("-",ndiv,n2)

puts eval(nminus)
