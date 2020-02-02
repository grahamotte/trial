require 'test_helper'

class VariousTest < UnitTest
  def test_or_nil
    assert_nil or_nil { x }
    assert_nil or_nil { '' }
    assert_nil or_nil { '   ' }
    assert_nil or_nil { [] }
    assert_nil or_nil { raise 'wat' }
    assert_nil or_nil { 1 / 0 }
    assert_nil or_nil { nil }
    assert_nil or_nil { }

    refute_nil or_nil { 1 }
    refute_nil or_nil { Class }
    refute_nil or_nil { 'soup' }
    refute_nil or_nil { [1] }
  end

  def test_secrets
    assert_equal ({}), secrets
  end

  def test_float_eh
    assert float?('1.1')
    assert float?('1.1e10')
    assert float?('1')
    assert float?('0')
    assert float?(1.1)

    refute float?('')
    refute float?('aa')
    refute float?([])
    refute float?(Class)
  end

  def test_float_or_nil
    assert_equal 1.1, float_or_nil('1.1')
    assert_equal 11, float_or_nil('1.1e1')
    assert_equal 0, float_or_nil('0')
    assert_equal 10, float_or_nil('10')

    assert_nil float_or_nil('')
    assert_nil float_or_nil('aa')
    assert_nil float_or_nil([])
    assert_nil float_or_nil(Class)
  end

  def test_aggressive_deep_symbolize_keys
    actual = aggressive_deep_symbolize_keys(
      [
        { 'string' => 'keys' },
        { 'string' => 'keys' },
      ]
    )

    expected = [
      { string: 'keys' },
      { string: 'keys' },
    ]

    assert_equal expected, actual
  end
end
