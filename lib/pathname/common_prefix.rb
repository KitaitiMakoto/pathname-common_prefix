require 'pathname'

class Pathname
  class << self
    def common_prefix(*paths)
      paths.flatten!
      return if paths.empty? # @type var paths: Array[Pathname | String]
      Pathname(paths.pop).common_prefix(paths) # @type var paths: NonEmptyArray[Pathname]
    end
  end

  def common_prefix(*others)
    others.flatten!
    others.map! {|path| Pathname path} # @type var others: Array[Pathname | String]
    enum_for(:ascend).find {|path|
      others.all?{|other|other.start_with?(path)}
    }
  end

  def start_with?(other)
    enum_for(:descend).include?(Pathname(other))
  end
end
