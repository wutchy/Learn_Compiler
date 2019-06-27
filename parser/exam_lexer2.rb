class Lexer

  def initialize(f)
    @srcf=f
    @line=""
    @keywords = { 
      "int"   => :int,
      "bool"  => :bool,
      "TRUE"  => :true,
      "FALSE" => :false
    }
  end

  def lex()
    if /\A\s+/ =~ @line
      @line = $'
    end
    while @line.empty? do
      @line = @srcf.gets
      if @line == nil
        return :eof
      end
      if /\A\s+/ =~ @line
        @line = $'
      end
    end
    case @line
    when /\A\(/
      yield $&
      token = :lpar
    when /\A\)/
      yield $&
      token = :rpar
    when /\A\,/
      yield $&
      token = :comma
    when /\A\{/
      yield $&
      token = :lbra
    when /\A\}/
      yield $&
      token = :rbra
    when /\A\:=/
      yield $&
      token = :coleq
    when /\A\;/
      yield $&
      token = :semi
    when /\A\+/
      yield $&
      token = :plus
    when /\A\-/
      yield $&
      token = :minus
    when /\A\|\|/
      yield $&
      token = :oror
    when /\A\!/
      yield $&
      token = :not
    when /\A\*/
      yield $&
      token = :mult
    when /\A\//
      yield $&
      token = :div
    when /\A\&\&/
      yield $&
      token = :andand
    when /\A==/
      yield $&
      token = :eqeq
    when /\A!=/
      yield $&
      token = :neq
    when /\A<=/
      yield $&
      token = :leq
    when /\A</
      yield $&
      token = :lt
    when /\A>=/
      yield $&
      token = :geq
    when /\A>/
      yield $&
      token = :gt
    when /\A\d+/
      yield $&
      token = :num
    when /\A[a-zA-Z][a-zA-Z0-9]*/
      token = @keywords[$&]
      if token == nil then
        token = :id
      end
      yield $&
    when /\A\S/
      # ignore
      token = :other
    end
    @line = $'
    return token
  end
end
