require 'sinatra'
require 'pp'
require 'base64'

COUNTER = {}
FREQS = ["e", " ", "t", "a", "o", "i", "n", "s", "h", "r", "d", "l", "c", "u", "m", "w", "f", "g", "y", "p", "b", "v", "k", "j", "x", "q", "z"]

def decode64(str)
  Base64.decode64(str)
end

def decrypt(str)
  while not str.include?(' ')
    str = decode64(str)
  end
  str
end

def translate(s)
  stats = {"ᚳ" => "t", "ᚧ" => "h", "ᚤ" => "e", "ᙟ" => " ", "ᚮ" => "o", "ᚱ" => "r", "ᚨ" => "i", "ᚠ" => "a", "ᚡ" => "b", "ᚫ" => "l", "ᚯ" => "p", "ᚬ" => "m", "ᚴ" => "u", "ᚩ" => "j", "ᚵ" => "v", "ᚲ" => "s", "ᚢ" => "c", "ᚪ" => "k", "ᚭ" => "n", "ᚸ" => "y", "ᚷ" => "x", "ᚶ" => "w", "ᚣ" => "d", "ᚥ" => "f", "ᚦ" => "g"}
  stats[s]
end

TEXTS = []

get '*' do
  p params
  "The Rubots are here!"
end

post '/oMgogNpBPIYZZCelExnMvOsFXWBckXhhohKTDqYbweRkbmlLDw' do
  payload = JSON.parse(request.body.read)
  text = payload.fetch('text')
  t = decrypt(text)
  p t
  t
end

post '/YgFIxFBaFQYoWsqIviNPLBhvEtYWYBLsjKZTCmYDksCKunMJOZ' do
  payload = JSON.parse(request.body.read)
  # p payload
  # p request
  runes = payload.fetch('text')
  # p runes
  # p runes.bytes
  # runes.force_encoding('ISO-8859-1')
  # p runes
  # p runes.codepoints
  # p runes.bytes
  chars = runes.split(//)
  chars.each { |t| COUNTER[t] ||= 0; COUNTER[t] += 1 }
  out = chars.map do |letter|
    sorted = COUNTER.sort_by { |a| a[1] }.reverse
    index = sorted.index { |a| a[0] == letter }
    if index
      FREQS[index]
    else
      '.'
    end
  end

  out2 = chars.map { |t| translate(t) || '.' }
  puts out2.join('')
  out2.join('')
end

post '/yLWRwqXJWoMcYEezqngieemuTpOpLoUoPNQnIRKRJfmOhLHBcE' do
  payload = JSON.parse(request.body.read)
  data = decode64(payload.fetch('text'))
  s = []
  decoded = decode64(payload.fetch('text'))
  decoded.bytes.each_with_index { |b, i| s << (b.ord ^ 'focus'[i % 5].ord) }
  s = s.map(&:chr)
  s.join('')
end

post '/NvzMPcgeDHnjAtjSRLZKGKoapdADLMGpuRrkdmyUjhZxLcjRow' do
  payload = JSON.parse(request.body.read)
  p payload
  p data
end

put '*' do
  p params
end

delete '*' do
  p params
end
