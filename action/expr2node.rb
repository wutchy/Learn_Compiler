require './lexer'
require './nodeeval'

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
      n = mE()
      checktoken("mF",:rpar)
    when :num
      n = NUM.new(@lexime)
      checktoken("mF",:num)
    else
      puts "syntax error (mF): num or lpar is expected"
      exit(1)
    end
    n
  end

  def mT()
    tmp = mF()
    while @token == :mult do
      checktoken("mT", :mult)
      tmp = MULT(tmp, mF())
    end
    tmp
  end

  def mE()
    tmp = mT()
    while @token == :plus do
      checktoken("mE",:plus)
      tmp = PLUS(tmp, mT())
    end
    tmp
  end
end

lexer = Lexer.new($stdin)
parser = Parser.new(lexer)
#puts parser.parse.eval
t = parser.parse

puts "eval"
puts t.eval

puts ""
puts "prefix"
puts t.prefix

puts ""
puts "postfix"
puts t.postfix
