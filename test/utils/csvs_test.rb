require 'test_helper'

class CsvsTest < UnitTest
  def test_read_csv
    assert_equal parsed_csv, read_csv('csv_file.csv')
  end

  def test_write_csv_from_hashes
    write_csv_from_hashes('new_csv_file.csv', read_csv('csv_file.csv'))
    make_seed('new_csv_file.csv')
    assert_equal parsed_csv, read_csv('new_csv_file.csv')
  end

  def test_write_csv_from_hashes__subset
    write_csv_from_hashes(
      'new_csv_file.csv',
      read_csv('csv_file.csv'),
      attrs: [:age, :country],
    )

    make_seed('new_csv_file.csv')

    expected = [
      {age:"89", country:"barcelona"},
      {age:"25", country:"hawaii, USA"},
    ]

    assert_equal expected, read_csv('new_csv_file.csv')
  end

  private

  def parsed_csv
    [
      {id:"1", name:"hubert williamson", age:"89", country:"barcelona"},
      {id:"2", name:"clarence, alex", age:"25", country:"hawaii, USA"},
      {id:"3", name:"incomplete", age:nil, country:nil},
      {id:"4", name:nil, age:nil, country:nil},
    ]
  end
end
