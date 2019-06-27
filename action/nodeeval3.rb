class NUM
  def initialize(n)
    @n = n
  end

  def eval
    return @n.to_i
  end
end

class BinOp
  def initialize(l, r)
    @l = l
    @r = r
  end
end

class PLUS < BinOp
  def eval
    return @l.eval + @r.eval
  end
end

class MULT < BinOp
  def eval
    return @l.eval * @r.eval
  end
end

n1 = NUM.new("1")
n2 = NUM.new("2")
n3 = NUM.new("3")

nm = MULT.new(n2,n3)
np = PLUS.new(n1,nm)

puts np.eval
