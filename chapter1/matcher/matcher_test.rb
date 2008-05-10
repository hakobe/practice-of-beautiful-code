require 'test/unit'
require 'matcher'

class MatcherTest < Test::Unit::TestCase
  def test_match_char # c
    # match
    assert(match('abc', 'abc'))
    assert(match('abc', 'aaabccc'))

    # not match
    assert(!match('abc', 'xyz'))
    assert(!match('abc', 'ab'))
    assert(!match('abc', ''))
  end

  def test_match_any # .
    # match
    assert(match('.',   'a'))
    assert(match('..', 'ab'))
    assert(match('.',  'abc'))

    # not match
    assert(!match('..', 'a'))
    assert(!match('.', ''))
  end

  def test_match_start # ^
    # matche
    assert(match('^abc', 'abcxyz'))

    # not match
    assert(!match('^abc', 'xyzabc'))
  end

  def test_match_end # $
    # matche
    assert(match('abc$', 'xyzabc'))

    # not match
    assert(!match('abc$', 'abcxyz'))
  end

  def test_match_star # *
    # match
    assert(match('a*x', 'aaaax')) 
    assert(match('a*x', 'aaaabaaaax')) 
    assert(match('a*x', 'x')) 
    assert(match('a*',  '')) 
    assert(match('a*',  'xyz')) 
    assert(match('.*x', 'aaaax')) 
    assert(match('.*x', 'aaaaxaaaab')) 

    # not match
    # ??
  end

  def test_match_plus # +
    # match
    assert(match('a+x', 'aaaax')) 
    assert(match('a+x', 'aaaabaaaax')) 
    assert(match('.+x', 'aaaax')) 
    assert(match('.+x', 'aaaaxaaaab')) 

    # not match
    assert(!match('a+x', 'x')) 
    assert(!match('a+',  '')) 
    assert(!match('a+',  'xyz')) 
  end
  
  def test_match_empty_pattern
    assert(match('', 'abcdefghijklm'))
    assert(match('', ''))
  end
end
