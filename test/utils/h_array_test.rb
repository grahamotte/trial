require 'test_helper'

class HArrayTest < UnitTest
  def test_uniq_keys
    assert_equal ([:a, :b, :c, :d, :f]).sort, all.to_harray.uniq_keys.sort
  end

  def test_count_by
    assert_equal ({4 => 2, 2 => 1}), all.to_harray.count_by { |x| x.length }
  end

  def test_merge__inner
    expected = [{ a:1, b:223, c:3123, f:1, d:4123 }]

    actual = [h1].to_harray.merge(
      [h2].to_harray,
      [h2, h3, h3],
      key: :a,
    )

    assert_equal expected, actual
  end

  def test_merge__all
    expected = [{ a:1, b:223, c:3123, f:1, d:4123 }, { a:"2", b:2 }]

    actual = [h1].to_harray.merge(
      [h2].to_harray,
      [h2, h3, h3],
      key: :a,
      join: :all,
    )

    assert_equal expected, actual
  end

  private

  def all
    [h1, h2, h3]
  end

  def h1
    { a: 1, b: 2.2, c: '', f: 1 }
  end

  def h2
    { a: 1, b: 223, c: 3123, d: 4123 }
  end

  def h3
    { a: '2', b: 2 }
  end
end
