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

  def mTd()
    case @token
    when :mult
      checktoken("mTd",:mult)
      mF()
      mTd()
    else
    end
  end

  def mT()
    mF()
    mTd()
  end

  def mEd()
    case @token
    when :plus
      checktoken("mEd", :plus)
      mT()
      mEd()
    else
    end
  end

  def mE()
    mT()
    mEd()
  end
end

lexer = Lexer.new($stdin)
parser = Parser.new(lexer)
parser.parse
