print "input a line: "
line=gets
until line.empty? do
  case line
  when /\S\s+/
    puts "space (skip)"
  when /A(\S+)/
    puts "word (#{$1})"
  end
  line = $'
end
