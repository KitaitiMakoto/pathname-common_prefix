require 'pathname'

class Pathname
  class << self
    def common_prefix(*paths)
      paths.flatten!
      return if paths.empty? # @type var paths: Array[Pathname | _ToStr]
      Pathname(paths.pop).common_prefix(paths) # @type var paths: NonEmptyArray[Pathname | String] Actualy _ToStr instead of String but type of Pathname() requires String
    end
  end

  def common_prefix(*others)
    others.flatten!
    others.map! {|path| Pathname path} # @type var others: Array[Pathname | String] Actualy _ToStr instead of String but type of Pathname() requires String
    enum_for(:ascend).find {|path| # @type path: Pathname | _ToStr
      others.all?{|other|other.start_with?(path)}
    }
  end

  def start_with?(other)
    enum_for(:descend).include?(Pathname(other)) # @type var other: Pathname | String Actualy _ToStr instead of String but type of Pathname() requires String
  end
end
