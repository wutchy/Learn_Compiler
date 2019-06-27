require './lexer'

class Parser
  def initialize(lexer)
    @lexer = lexer
    @token = @lexer.lex(){ |l|
      @lexime = l
    }
  end

  def parse()
    mprog()
  end
  
  private

  def checktoken(f,expected)
    if @token == expected
      @token = @lexer.lex(){|l|
        @lexime = l
      }
    else
      puts "syntax error (#{f}) : #{expected} is expected"
      exit(1)
    end
  end
  
  def mfactor()
    case @token
    when :true
      checktoken("mfactor",:true)
    when :false
      checktoken("mfactor",:false)
    when :num
      checktoken("mfactor",:num)
    when :id
      checktoken("mfactor",:id)
    when :lpar
      checktoken("mfactor",:lpar)
      mexpr()
      checktoken("mfactor",:rpar)
    when :not
      checktoken("mfactor",:not)
      mfactor()
    else
      puts "syntax error (mfactor) : :true, :false, :num, :id, :lpar, :rpar or :not  is expected"
      exit(1)
    end
  end
  
  def mmulop()
    case @token
    when :mult
      checktoken("mmulop",:mult)
    when :div
      checktoken("mmulop",:div)
    when :andand
      checktoken("mmulop",:andand)
    else
      puts "syntax error (mmulop) : :mult, :div or :andand  is expected"
      exit(1)
    end
  end

  def mpop()
    case @token
    when :plus
      checktoken("mpop",:plus)
    when :minus
      checktoken("mpop",:minus)
    when :oror
      checktoken("mpop",:oror)
    else
      puts "syntax error (mpop) : :plus, :minus or :oror  is expected"
      exit(1)
    end
  end

  def mterm()
    mfactor()
    while @token == :mult || @token == :div || @token == :andand
      mmulop()
      mfactor()
    end
  end

  def mcop()
    case @token
    when :eqeq
      checktoken("mcop",:eqeq)
    when :lt
      checktoken("mcop",:lt)
    when :gt
      checktoken("mcop",:gt)
    when :neq
      checktoken("mcop",:neq)
    when :leq
      checktoken("mcop",:leq)
    when :geo
      checktoken("mcop",:geo)
    else
      puts "syntax error (mcop) : :eqeq, :lt, :gt, :neq, :leq, or :geo is expected"
      exit(1)
    end
  end

  def mexpt()
    case @token
    when :eqeq,:lt,:gt,:neq,:leq,:geo
      mcop()
      msexp()
    else
    end
  end
  
  def msexp()
    mterm()
    while @token == :plus || @token == :minus || @token == :oror
      mpop()
      mterm()
    end
  end

  def mexpr()
    msexp()
    mexpt()
  end

  def massign()
    checktoken("massign",:id)
    checktoken("massign",:coleq)
    mexpr()
    checktoken("massign",:semi)
  end

  def mtype()
    case @token
    when :int
      checktoken("mtype",:int)
    when :bool
      checktoken("mtype",:bool)
    else
      puts "syntax error (#{mtype}): :int or :bool is expected"
      exit(1)
    end
  end

  def mstmt()
    massign()
  end
  
  def mdecl()
    mtype()
    checktoken("mdecl",:id)
    while @token == :comma
      checktoken("mdecl",:comma)
      checktoken("mdecl",:id)
    end
    checktoken("mdecl",:semi)
  end

  def mstmtp()
    mstmt()
    while @token == :id
      mstmt()
    end
  end
    
  def mdeclp()
    while @token == :int || @token == :bool
      mdecl()
    end
  end

  def mprog()
    mdeclp()
    mstmtp()
  end

end

lexer = Lexer.new($stdin)
parser = Parser.new(lexer)
parser.parse()

  
