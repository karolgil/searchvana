require 'sinatra'
require 'pp'
require 'base64'

COUNTER = {}
FREQS = [" ", "e", "t", "a", "o", "i", "n", "s", "h", "r", "d", "l", "c", "u", "m", "w", "f", "g", "y", "p", "b", "v", "k", "j", "x", "q", "z"]

def decode64(str)
  Base64.decode64(str)
end

def decrypt(str)
  while not str.include?(' ')
    str = decode64(str)
  end
  str
end

TEXTS = []

get '*' do
  p params
  "The Rubots are here!"
end

post '/oMgogNpBPIYZZCelExnMvOsFXWBckXhhohKTDqYbweRkbmlLDw' do
  payload = JSON.parse(request.body.read)
  text = payload.fetch('text')
  decrypt(text)
end

post '/YgFIxFBaFQYoWsqIviNPLBhvEtYWYBLsjKZTCmYDksCKunMJOZ' do
  payload = JSON.parse(request.body.read)
  p payload
  # p request
  runes = payload.fetch('text')
  p runes
  p runes.bytes
  # runes.force_encoding('ISO-8859-1')
  p runes
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
  p out
  puts out.join('')
  out
end

put '*' do
  p params
end

delete '*' do
  p params
end
