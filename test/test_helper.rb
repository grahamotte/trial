require "minitest/autorun"
require 'trial'

ROOT = 'test/fake_root'
RUN = 'run_dir.rb'

class UnitTest < Minitest::Test
  def setup
    FileUtils.rm_rf('test/fake_root')
    FileUtils.mkdir_p('test/fake_root')
    FileUtils.cp_r('test/fake_root_static/.', 'test/fake_root')
  end

  def teardown
    FileUtils.rm_rf('test/fake_root')
  end
end
