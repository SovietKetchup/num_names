# Convert Numbers into their word equivalents
# SovietKetchup
# v1.0.0

class NumNames
  attr_reader :num

  def initialize num
    # Convert num into an array of strings e.g. 123 => ["1", "2", "3"] and put into groups of three
    num = num.to_s
    @int = num.split(".").first.scan(/./).reverse.in_groups_of(3).map{ |g| g.compact.reverse }.reverse
    # A decimal
    if num.include? "."
      @dec = num.split(".").last.scan(/./)
    # Not a decimal
    else
      @dec = nil
    end

    # Hash of pre-determined values for certain numbers
    @lookup =  { "1" => "one",
      "2" => "two",
      "3" => "three",
      "4" => "four",
      "5" => "five",
      "6" => "six",
      "7" => "seven",
      "8" => "eight",
      "9" => "nine",
      "10" => "ten",
      "11" => "eleven",
      "12" => "twelve",
      "13" => "thirteen",
      "14" => "fourteen",
      "15" => "fifteen",
      "16" => "sixteen",
      "17" => "seventeen",
      "18" => "eighteen",
      "19" => "nineteen",
      "20" => "twenty",
      "30" => "thirty",
      "40" => "fourty",
      "50" => "fifty",
      "60" => "sixty",
      "70" => "seventy",
      "80" => "eighty",
      "90" => "ninety"
    }
  end

  # Convert the number into
  def to_word
    pos = -1
    num_words = " "
    @int.length.times {
      case pos
        when -1 then num_words = compile_i(@num[pos]) + num_words
        when -2 then num_words = compile_i(@num[pos]) + " thousand, " + num_words
        when -3 then num_words = compile_i(@num[pos]) + " million, " + num_words
        when -4 then num_words = compile_i(@num[pos]) + " billion, " + num_words
        when -5 then num_words = compile_i(@num[pos]) + " trillion, " + num_words
        when -6 then num_words = compile_i(@num[pos]) + " quadrillion, " + num_words
        when -7 then num_words = compile_i(@num[pos]) + " quintillion, " + num_words
        when -8 then num_words = compile_i(@num[pos]) + " sextillion, " + num_words
        when -9 then num_words = compile_i(@num[pos]) + " septillion, " + num_words
        when -10 then num_words = compile_i(@num[pos]) + " octillion, " + num_words
        when -11 then num_words = compile_i(@num[pos]) + " nonillion, " + num_words
        when -12 then num_words = compile_i(@num[pos]) + " decillion, " + num_words
      end
      pos -= 1
    }
    num_words
  end

  private
  # Compile the Integer Sections of 3 -- units, tens, hundreds
  def compile_i num_section
    # Only units
    if num_section.length == 1
      u = units num_section
    elsif num_section.length == 2
      u = units num_section; t = tens num_section
    else
      u = units num_section; t = tens num_section; h = hundreds num_section
    end
    h.to_s + t.to_s + u.to_s
  end

  # Names for numbers in the units
  def units n
    unless n[-1] == "0"
      # Teen
      if n[-2] == "1"
        u = " " + @lookup[n[-2] + n[-1] ]
      # Not a teen
      else
        u = " " + @lookup[ n[-1] ]
      end
    end
    u
  end

  # Names for numbers in the tens
  def tens n
    # Not a teen
    unless n[-2] == "1" or n[-2] == nil
      t = " " + @lookup[ n[-2] + "0" ]
    end
  end

  # Names for numbers in the hundreds
  def hundreds n
    unless n[-3] == "0" or n[-3] == nil
      if n[-1] == "0" and n[-2] == "0"
        h = @lookup[ n[-3] ] + " hundred "
      else
        h = @lookup[ n[-3] ] + " hundred and"
      end
    end
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

x = NumNames.new 123_456_789_012_345_678
print x.to_word
