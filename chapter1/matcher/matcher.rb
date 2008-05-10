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
  (0..text.size).each do |i|
    if matchhere(regexp, text[i..-1])
      return true
    end
    break if text[0].chr != c && text[0].chr != '.'
  end
  return false
end
