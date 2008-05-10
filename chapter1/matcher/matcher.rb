DEBUG=false

def log(*args)
  if DEBUG
    STDERR.puts *args
  end
end

def match(regexp, text)
  if regexp[0] && regexp[0].chr == '^'
    return matchhere(regexp[1..-1], text)
  end

  (0..text.size).each do |i|
    if matchhere(regexp, text[i..-1])
      return true
    end
  end

  return false
end

def matchhere(regexp, text)
  log %Q{"#{text}" =~ /#{regexp}/}
  if regexp.size == 0
    return true
  end

  if regexp[0].chr == '$' && regexp.size == 1
    return text.size == 0
  end

  if regexp[1] && regexp[1].chr == '*'
    return matchstar(regexp[0].chr, regexp[2..-1], text)
  end

  if text.size > 0 && (regexp[0].chr == '.' || regexp[0].chr == text[0].chr)
    return matchhere(regexp[1..-1], text[1..-1])
  end

  return false
end

def matchstar(c, regexp, text)
  start = 0
  if c == '.'
    start = text.size
  else
    text.each_byte do |tc|
      break if tc.chr != c
      start += 1
    end
  end

  start.downto(0) do |n|
    if matchhere(regexp, text[n..-1])
      return true
    end
  end

  return false
end
