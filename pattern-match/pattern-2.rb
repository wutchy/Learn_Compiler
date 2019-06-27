# coding: utf-8
dfatable = [
  [1,2],
  [1,3],
  [1,3],
  [1,4],
  [1,2]
]

chart = {"a"=>0, "z"=>1}

state = 0 #初期値
print "string is input!!\n"
buf = ARGV[0].to_s.chomp #改行文字の除去
buf.each_char do |c|
  state = dfatable[state][chart[c]] #アスキーコードの比較
end

if state == 4 then
  puts "accepted!!"
else
  puts "not accepted!"
end
