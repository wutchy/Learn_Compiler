require './lexer'

class Parser
  def initialize(lexer)
    @lexer = lexer
    @token = @lexer.lex(){|l|
      @lexime = l
    }
  end

  def parse()
    mE()
  end

  private
  
  def checktoken(f, expected)
    if @token == expected
      @token = @lexer.lex(){|l|
        @lexime = l
      }
    else
      puts "syntax error (#{f}): #{expected} is expected"
      exit(1)
    end
  end

  def mF()
    case @token
    when :lpar
      checktoken("mF",:lpar)
      val = mE()
      checktoken("mF",:rpar)
    when :num
      val = @lexime.to_i
      checktoken("mF",:num)
    else
      puts "syntax error (mF): num or lpar is expected"
      exit(1)
    end
    val
  end

  def mT()
    val = mF()
    while @token == :mult do
      checktoken("mT", :mult)
      val *= mF()
    end
    val
  end

  def mE()
    val = mT()
    while @token == :plus do
      checktoken("mE",:plus)
      val += mT()
    end
    val
  end
end

lexer = Lexer.new($stdin)
parser = Parser.new(lexer)
puts parser.parse
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
