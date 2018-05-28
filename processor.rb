module Processor
  def self.call(path, enumerable)
    Enumerator.new do |yielder|
      enumerable.each do |payload|
        yielder << payload.get(path)
      end
    end
  end
end
