# Convert Numbers into their word equivalents
# SovietKetchup
# v

class NumNames
  attr_reader :num

  def initialize num
    @num = num.to_s.scan(/./)
  end

  def to_word

  end

  private
  # Split the number into each part
  def split num
    num_sep = num.reverse.in_groups_of(3).map{ |g| g.compact.reverse }.reverse
  end

  # Sections of 3
  def hun_ten_uni; end

  # Suffixes (thousand, million etc.)
  def suffixes; end

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
