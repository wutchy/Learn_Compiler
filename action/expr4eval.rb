require './expr4evall'

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
    while @token == :mult || @token == :div do
      if @token == :mult then
        checktoken("mT", :mult)
        val *= mF()
      else
        checktoken("mT", :div)
        val /= mF()
      end
    end
    val
  end

  def mE()
    val = mT()
    while @token == :plus || @token == :minus do
      if @token == :plus then
        checktoken("mE", :plus)
        val += mT()
      else
        checktoken("mE", :minus)
        val -= mT()
      end
    end
    val
  end  
end

lexer = Lexer.new($stdin)
parser = Parser.new(lexer)
puts parser.parse
