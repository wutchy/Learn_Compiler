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
      mE()
      checktoken("mF",:rpar)
    when :num
      checktoken("mF",:num)
    else
      puts "syntax error (mF): num or lpar is expected"
      exit(1)
    end
  end

  def mT()
    mF()
    while @token == :mult do
      checktoken("mT", :mult)
      mF()
    end
  end

  def mE()
    mT()
    while @token == :plus do
      checktoken("mE",:plus)
      mT()
    end
  end
end

lexer = Lexer.new($stdin)
parser = Parser.new(lexer)
parser.parse
