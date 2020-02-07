class Hash
  def to_os(n = nil)
    n ||= self

    case n
    when Array
      n.map { |x| to_os(x) }
    when NilClass, Hash
      n
        .map { |k, v| [k, to_os(v)] }
        .to_h
        .then { |x| OpenStruct.new(x) }
    else
      n
    end
  end

  def sanitize_value(key, type, date_format: nil, datetime_format: nil)
    self.merge(
      key => or_nil do
        case type
        when :date
          Date.strptime(*[self.dig(key), date_format].compact)
        when :datetime
          DateTime.parse(*[self.dig(key), datetime_format].compact)
        when :integer, :int
          self.dig(key).to_i
        when :float
          self.dig(key).to_f
        when :string
          self.dig(key).to_s
        when :present?
          self.dig(key).present?
        when :blank?
          self.dig(key).blank?
        end
      end
    )
  end

  def sanitize(schema, date_format: '%Y-%m-%d')
    cp = self.dup
    schema.each do |key, type|
      cp = cp.sanitize_value(key, type, date_format: date_format)
    end
    cp
  end
end
