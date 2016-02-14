# Convert Numbers into their word equivalents
# SovietKetchup
# v

class NumNames
  attr_reader :num

  def initialize num
    # Convert num into an array of strings e.g. 123 => ["1", "2", "3"] and put into groups of three
    @num = num.to_s.scan(/./).reverse.in_groups_of(3).map{ |g| g.compact.reverse }.reverse
  end

  # Convert the number into
  def to_word; end

  private
  # Sections of 3 -- hundreds, tens, units
  def hun_ten_uni num_sep
    c = -1
    num_sep.length.times {
      if num_sep[c][1] == "1"

      end
      c -= 1
    }
  end
end

# http://api.rubyonrails.org/classes/Array.html#method-i-in_groups_of
class Array
  def in_groups_of(number, fill_with = nil)
    if number.to_i <= 0
    raise ArgumentError,
      "Group size must be a positive integer, was #{number.inspect}"
    end
    if fill_with == false
      collection = self
    else
      # size % number gives how many extra we have;
      # subtracting from number gives how many to add;
      # modulo number ensures we don't add group of just fill.
      padding = (number - size % number) % number
      collection = dup.concat(Array.new(padding, fill_with))
    end
    if block_given?
      collection.each_slice(number) { |slice| yield(slice) }
    else
      collection.each_slice(number).to_a
    end
  end
end
