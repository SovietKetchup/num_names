# Convert Numbers into their word equivalents
# SovietKetchup
# v

class NumNames
  attr_reader :num

  def initialize num
    # Convert num into an array of strings e.g. 123 => ["1", "2", "3"] and put into groups of three
    @num = num.to_s.scan(/./).reverse.in_groups_of(3).map{ |g| g.compact.reverse }.reverse
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
    puts hun_ten_uni @num
  end

  private
  # Sections of 3 -- hundreds, tens, units
  def hun_ten_uni num_sep
    c = -1
    num_names = []
    num_sep.length.times {
      # No tens or hundreds
      if num_sep[c].length == 1
        # Applying the name of the number to a new array
####################################
## raise num_sep.inspect
####################################
        num_names[1] = @lookup[num_sep[c][num_sep[c].length -1]]
      # No hundreds
      elsif num_sep[c].length == 2
        # If it's a 'teen' (or 10)
        if num_sep[c][num_sep[c].length-2] == 1
          num_names[1] = @lookup[num_sep[c][num_sep[c].length -2]] + @lookup[num_sep[c][num_sep[c].length -2]]
        # Not a 'teen' i.e. 20, 21 etc
        else
          # Ends in 0 i.e. 20, 30, 40 etc
          if num_sep[c][num_sep[c].length-1] == 0
            num_names[1] = @lookup[num_sep[c][num_sep[c].length -2]]
          # Not a 0
          else
            num_names[1] = @lookup[num_sep[c][num_sep[c].length -2]] + " " + @lookup[num_sep[c][num_sep[c].length -1]]
          end
        end
      # Units tens and hundreds
      else
        # Hundreds is 0
        if num_sep[c][num_sep[c].length-3] == "0"
          # If it's a 'teen' (or 10)
          if num_sep[c][num_sep[c].length-2] == 1
            num_names[1] = digit_names(num_sep[c][num_sep[c].length-2] + num_sep[c][num_sep[c].length-1])
          # Not a 'teen' i.e. 20, 21 etc
          else
            # Ends in 0 i.e. 20, 30, 40 etc
            if num_sep[c][num_sep[c].length-1] == 0
              num_names[1] = @lookup[ num_sep[c] [num_sep[c].length -2] ]
            # Not a 0
            else
              num_names[1] = @lookup[num_sep[c][num_sep[c].length -2]] + " " + @lookup[num_sep[c][num_sep[c].length -1]]
            end
          end
        # Hundreds has a value
        else
          # Tens and units are 0
          if num_sep[c][num_sep[c].length-2] == 0 and num_sep[c][num_sep[c].length-1] == 0
            num_names[1] = @lookup[num_sep[c][num_sep[c].length -3]] + " hundred"
          # Tens or units have value
          else
            a = @lookup[num_sep[c][num_sep[c].length -3]] + " hundred"
            # If it's a 'teen' (or 10)
            if num_sep[c][num_sep[c].length-2] == 1
              b = digit_names(num_sep[c][num_sep[c].length-2] + num_sep[c][num_sep[c].length-1])
            # Not a 'teen' i.e. 20, 21 etc
            else
              # Ends in 0 i.e. 20, 30, 40 etc
              if num_sep[c][num_sep[c].length-1] == 0
                b = @lookup[num_sep[c][num_sep[c].length -2]]
              # Not a 0
              else
                b = @lookup[num_sep[c][num_sep[c].length -2]] + " " + @lookup[num_sep[c][num_sep[c].length -2]]
              end
            end
            num_names[1] = a + b
          end
        end
      end
      # The suffix (thousand, million etc)
      case c
        when -2 then num_names[1] += " thousand"
        when -3 then num_names[1] += " million"
        when -4 then num_names[1] += " billion"
      end
      c -= 1
    }
    num_names
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

x = NumNames.new 1
x.to_word
