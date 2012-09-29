require 'pathname'

class Pathname
  class << self
    def common_prefix(*paths)
      return if paths.empty?
      Pathname(paths.pop).common_prefix(*paths)
    end
  end

  def common_prefix(*paths)
    paths = paths.map {|path| Pathname(path).enum_for(:descend)}
    last_filename = nil
    enum_for(:descend).each do |filename|
      break unless paths.all? {|path|
        begin
          filename == path.next
        rescue StopIteration
        end
      }
      last_filename = filename
    end
    last_filename
  end
end
