# coding: utf-8
dfatable = [
  [1,2],
  [1,3],
  [1,3],
  [1,4],
  [1,2]
]

state = 0 #初期値
print "input string: "
buf = gets.chomp #改行文字の除去
buf.each_char do |c|
  state = dfatable[state][c.ord - "a".ord] #アスキーコードの比較
end

if state == 4 then
  puts "accepted!!"
else
  puts "not accepted!"
end
