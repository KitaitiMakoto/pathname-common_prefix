require 'pathname'

class Pathname
  class << self
    def common_prefix(*paths)
      paths.flatten!
      return if paths.empty?
      # @type var paths: NonEmptyArray[Pathname | String]
      # Actualy _ToStr instead of String but type of Pathname() requires String
      Pathname(paths.pop).common_prefix(paths)
    end
  end

  def common_prefix(*others)
    others.flatten!
    # @type var others: Array[Pathname | String]
    # Actualy _ToStr instead of String but type of Pathname() requires String
    others.map! {|path| Pathname path}
    enum_for(:ascend).find {|path|
      # @type path: pathnamable
      others.all?{|other|other.start_with?(path)}
    }
  end

  def start_with?(other)
    # @type var other: Pathname | String
    # Actualy _ToStr instead of String but type of Pathname() requires String
    enum_for(:descend).include?(Pathname(other))
  end
end
