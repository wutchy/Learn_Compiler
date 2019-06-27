# coding: utf-8
require 'benchmark'
reserved_words={"auto"=>:auto, "break"=>:break, "case"=>:case, "char"=>:char, "const"=>:const, "continue"=>:continue, "default"=>:default, "double"=>:double, "do"=>:do, "else"=>:else, "enum"=>:enum, "extern"=>:extern, "float"=>:float, "for"=>:for, "goto"=>:goto, "if"=>:if, "int"=>:int, "long"=>:long, "register"=>:register, "return"=>:return, "short"=>:short, "signed"=>:signed, "sizeof"=>:sizeof, "static"=>:static, "struct"=>:struct, "switch"=>:switch, "typedef"=>:typedef, "union"=>:union, "unsigned"=>:unsigned, "void"=>:void, "volatile"=>:volatile, "while"=>:while}

print "input a line=> "
while line=gets do
  until line.empty? do
    case line
    when /\A\s+/
    when /\A([0-9]+)/
      puts "number (#{$1})"
    when /\A([_a-zA-Z]\w*)/
      frag = nil
      result = Benchmark.realtime do
        frag = reserved_words[$1]
      end
      puts "所要時間 #{result}s"
      if frag 
        puts "reserved words (#{$1})"
      else
        puts "identifier (#{$1})"
      end
    when /\A(\S)/
      puts "other (#{$1})"
    end
    line = $'.to_s
  end
end
