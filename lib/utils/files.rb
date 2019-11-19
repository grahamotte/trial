def seeds_path(name)
  "seeds/#{name}"
end

def results_path(name)
  "results/#{RUN}/#{name}"
end

def tmp_path(name)
  "tmp/#{name}"
end

def read(file)
  File.read(seeds_path(file))
end

def write(file, content)
  File.open(results_path(file), 'w') { |f| f << content }
end

def delete(file)
  File.delete(results_path(file))
end

def append(file, content)
  File.open(results_path(file), 'a') { |f| f << content }
end

def readlines(file)
  File.read(seeds_path(file)).split("\n")
end

def list_dir(dir)
  Dir["#{seeds_path(dir)}/**/*"].map { |x| x.gsub('seeds/', '') }
end

def make_seed(file)
  FileUtils.cp(results_path(file), seeds_path(file))
end
