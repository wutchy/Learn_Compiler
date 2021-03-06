reserved_words=%w[auto break case char const continue default double do else enum extern float for goto if int long register return short signed sizeof static struct switch typedef union unsigned void volatile while]

print "input a line: "
while line=gets do
  until line.empty? do
    case line
    when /\A\s+/
    when /\A([0-9]+)/
      puts "number (#{$1})"
    when /\A(#{reserved_words.map{|s| Regexp.escape(s)}.join('|')})/
      puts "reserved words(#{$1})"
    when /\A([_a-zA-Z]\w*)/
      puts "identifier (#{$1})"
    when /\A(\S)/
      puts "other (#{$1})"
    end
    line = $'.to_s
  end
end
