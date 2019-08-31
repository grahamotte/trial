def timeit
  log(Benchmark.measure { yield }.to_s)
end
