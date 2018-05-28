class Payload < Hash
  def self.load(data)
    data.each_line.reduce(self.new) do |hsh, line|
      hsh.put(*line.split('='))
      hsh
    end
  end

  def put(path, value)
    set_recursively(self, path.split('.'), value.strip)
  end

  def get(path)
    get_recursively(self, path.split('.'))
  end

  private

  # FIXME does not play nice with the explicit path like Some.Object.0.other.attribute
  # TODO think about applying the same pattern as in initialization i.e Some.Object[0].other.attribute
  def get_recursively(ctx, path)
    this, *rest = path

    if rest.any?
      if ctx[this].is_a?(Array)
        ctx[this].map { |e| get_recursively(e, rest)  }
      else
        get_recursively(ctx[this], rest)
      end
    else
      ctx[this]
    end
  end

  def set_recursively(ctx, path, val)
    this, *rest = path
    that, _ = rest

    return ctx[this] = val unless that || this.is_a?(String) && this.match(/.+\[\d+\]/)

    case this
      when /(.+)\[(\d+)\]/
        set_recursively(ctx[$1] ||= Array.new, rest.unshift($2.to_i), val)
      when Integer
        ctx[this] ||= that.match(/.+\[\d+\]/) ? Array.new : Hash.new
        set_recursively(ctx[this], rest, val)
      else
        set_recursively(ctx[this] ||= Hash.new, rest, val)
    end
  end
end
