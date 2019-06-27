class Lexer
  def initialize(f)
    @file = f
    @line =""
  end

  def lex()
    if /\A\s+/ =~ @line
      @line =$'
    end
    while @line.empty? do
      @line = @file.gets
      if @line == nil
        return :eof
      end
      if /\A\s+/ =~ @line
        @line = $'
      end
    end

    case @line
    when /\A\d+/
      yield $&
        token = :num
    when /\A\+/
      yield $&
        token = :plus
    when /\A\*/
      yield $&
        token = :mult
    when /\A\(/
      yield $&
        token = :lpar
    when /\A\)/
      yield $&
        token = :rpar
    when /\A\S/
      token = :other
    end
    @line = $'
    return token
  end
end
