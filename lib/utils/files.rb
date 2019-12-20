# paths

def seeds_path(name)
  "seeds/#{name}"
end

alias seed_path seeds_path

def seed_exists?(name)
  File.exists?(seed_path(name))
end

alias seeds_exist? seed_exists?

def results_path(name)
  "results/#{RUN}/#{name}"
end

alias result_path results_path

def result_exists?(name)
  File.exists?(result_path(name))
end

alias results_exist? result_exists?

def tmp_path(name)
  "tmp/#{name}"
end

def tmp_exists?(name)
  File.exists?(tmp_path(name))
end

def list_dir(dir)
  Dir["#{seeds_path(dir)}/**/*"].map { |x| x.gsub('seeds/', '') }
end

# reading

def read(file)
  return unless seed_exists?(file)
  File.read(seeds_path(file))
end

alias read_seed read
alias read_seeds read

def read_tmp(file)
  return unless tmp_exists?(file)
  File.read(tmp_path(file))
end

def readlines(file)
  File.read(seeds_path(file)).split("\n")
end

# writing

def write(file, content)
  FileUtils.mkdir_p(File.dirname(results_path(file)))
  File.open(results_path(file), 'w') { |f| f << content }
end

alias write_result write
alias write_results write

def write_tmp(file, content)
  FileUtils.mkdir_p(File.dirname(tmp_path(file)))
  File.open(tmp_path(file), 'w') { |f| f << content }
end

def append(file, content)
  File.open(results_path(file), 'a') { |f| f << content }
end

alias append_result append
alias append_results append

# deleting

def delete(file)
  return unless result_exists?(file)
  File.delete(results_path(file))
end

alias delete_result delete
alias delete_results delete

def delete_tmp(file)
  return unless tmp_exists?(file)
  File.delete(tmp_path(file))
end

def delete_seeds(file)
  return unless seed_exists?(file)
  File.delete(seeds_path(file))
end

alias delete_seed delete_seeds

# other

def make_seed(file)
  FileUtils.cp(results_path(file), seeds_path(file))
end

def make_tmp(file)
  FileUtils.cp(results_path(file), tmp_path(file))
end
