# coding: utf-8
class Lexer
  def initialize(f)
    @reserved_words={"auto"=>:auto, "break"=>:break, "case"=>:case, "char"=>:char, "const"=>:const, "continue"=>:continue, "default"=>:default, "double"=>:double, "do"=>:do, "else"=>:else, "enum"=>:enum, "extern"=>:extern, "float"=>:float, "for"=>:for, "goto"=>:goto, "if"=>:if, "int"=>:int, "long"=>:long, "register"=>:register, "return"=>:return, "short"=>:short, "signed"=>:signed, "sizeof"=>:sizeof, "static"=>:static, "struct"=>:struct, "switch"=>:switch, "typedef"=>:typedef, "union"=>:union, "unsigned"=>:unsigned, "void"=>:void, "volatile"=>:volatile, "while"=>:while}
    @file = f
    @line=""
    @lineno = 0
  end

  attr_reader :lineno

  def lex()
    if @line = @file.gets
      @lineno += 1
      until @line.empty?
        case @line
        when /\A\s+/
        when /\A([0-9]+)/
          yield $1, :number
        when /\A([_a-zA-Z]\w*)/
          if @reserved_words[$1]
            yield $1, $1.to_sym
          else
            yield $1, :identifier
          end
        when /\A(\S)/
          yield $1, :other
        end
        @line = $'
      end
      true
    else
      false
    end
  end
end

lexer = Lexer.new($stdin)
cross_reference={}

while lexer.lex() { |l,t|
        if t == :identifier
          if cross_reference[l]
            cross_reference[l].push(lexer.lineno)
          else
            cross_reference[l] = [lexer.lineno]
          end
        end
      }
end

cross_reference.each do |key,value|
  value.each do |i|
    print "#{i} "
  end
  print ": #{key}\n"
end
