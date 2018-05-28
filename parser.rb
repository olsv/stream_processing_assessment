require_relative 'payload'

module Parser
  def self.call(enumerable)
    Enumerator.new do |yielder|
      enumerable.each do |chunk|
        yielder << Payload.load(chunk)
      end
    end.lazy
  end
end
