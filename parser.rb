module Parser
  def self.call(loader, enumerable)
    Enumerator.new do |yielder|
      enumerable.each do |chunk|
        yielder << loader.load(chunk)
      end
    end.lazy
  end
end
