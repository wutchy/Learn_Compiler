reserved_words=%w[auto break case char const continue default do double else enum extern float for goto if int long register return short signed sizeof static struct switch typedef union unsigned void volatile while]

print "input a line: "
while line=gets
  until line.empty? do
    case line
    when /\A\s+/
    when /\A([0-9])+/
      puts "number (#{$1})"
    when /\A(\S+)/
      if reserved_words.include?($1)
        puts "reserved words (#{$1})"
      else
        puts "other (#{$1})"
      end
    end
    line = $'
  end
end
