dirs = {
  seed: { run: false, pluralized: ActiveSupport::Inflector.pluralize('seed') },
  result: { run: true, pluralized: ActiveSupport::Inflector.pluralize('result') },
  tmp: { run: false, pluralized: 'tmp' },
  cache: { run: false, pluralized: 'cache' },
}

dirs.each do |dir, opts|
  eval <<~RUBY
    def #{opts.dig(:pluralized)}_root
      File.join(
        ROOT,
        '#{opts.dig(:pluralized)}',
        '#{opts.dig(:run) ? RUN : nil}',
      ).to_s
    end

    def #{dir}_path(name)
      File.join(
        #{opts.dig(:pluralized)}_root,
        name,
      ).to_s
    end

    def #{dir}_exists?(name)
      File.exist?(#{dir}_path(name))
    end

    def list_#{opts.dig(:pluralized)}(name = nil)
      Dir[
        File.join(
          *[
            #{opts.dig(:pluralized)}_root,
            name,
            '**',
            '*',
          ].compact
        )
      ].reject { |d| File.directory?(d) }
    end

    def read_#{dir}(name)
      File.read(#{dir}_path(name)) if #{dir}_exists?(name)
    end

    def readlines_#{dir}(name)
      read_#{dir}(name).split("\\n")
    end

    def write_#{dir}(name, content)
      FileUtils.mkdir_p(File.dirname(#{dir}_path(name)))
      File.open(#{dir}_path(name), 'w') { |f| f << content }
    end

    def append_to_#{dir}(name, content)
      File.open(#{dir}_path(name), 'a') { |f| f << content }
    end

    def delete_#{dir}(name)
      FileUtils.rm_r(#{dir}_path(name)) if #{dir}_exists?(name)
    end
  RUBY

  dirs.each do |o_dir, o_opts|
    next if o_dir == dir
    eval <<~RUBY
      def cp_#{o_dir}_to_#{opts.dig(:pluralized)}(name)
        FileUtils.cp(#{o_dir}_path(name), #{dir}_path(name))
      end
    RUBY
  end
end
