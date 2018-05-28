module Reader
  def self.call(file)
    file = File.open(file, 'r')

    Enumerator.new do |yielder|
      begin
        file.each_line do |line|
          if line.match(/--myboundary/)
            text_body = file.readline.match(/Content-Type: text\/plain/)
            size = file.readline.match(/Content-Length: (\d+)/) && $1.to_i

            if text_body && size
              file.readline # one line after size
              yielder << file.read(size)
            end
          end
        end
      ensure
        file.close
      end
    end.lazy
  end
end
