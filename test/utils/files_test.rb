require 'test_helper'

class FilesTest < UnitTest
  def test_base_path_generation
    assert_equal 'test/fake_root/seeds/subdir/file.txt', seed_path('subdir/file.txt')
    assert_equal 'test/fake_root/results/run_dir.rb/subdir/file.txt', result_path('subdir/file.txt')
    assert_equal 'test/fake_root/tmp/subdir/file.txt', tmp_path('subdir/file.txt')
  end

  def test_create_file_and_make_seed
    write_result('test_file.txt', 'super special datas')
    cp_result_to_seeds('test_file.txt')
    assert_equal 'super special datas', read_seed('test_file.txt')
  end

  def test_list_dir
    expected = [
      'test/fake_root/seeds/files/5_file.f',
      'test/fake_root/seeds/files/7_file.f',
      'test/fake_root/seeds/files/3_file.f',
      'test/fake_root/seeds/files/1_file.f',
      'test/fake_root/seeds/files/8_file.f',
      'test/fake_root/seeds/files/4_file.f',
      'test/fake_root/seeds/files/6_file.f',
      'test/fake_root/seeds/files/2_file.f',
    ]

    assert_equal expected.sort, list_seeds('files').sort
  end

  def test_read
    assert_nil read_seed('this_file_doesnt_exist.txt')
    assert_equal 'Enim quisq', read_seed('some_text.txt').first(10)
  end
end
