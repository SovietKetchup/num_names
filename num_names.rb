# Convert Numbers into their word equivalents
# SovietKetchup
# v

class NumNames
  attr_reader :num

  def initialize num
    # Convert num into an array of strings e.g. 123 => ["1", "2", "3"] and put into groups of three
    @num = num.to_s.scan(/./).reverse.in_groups_of(3).map{ |g| g.compact.reverse }.reverse
  end

  protected
  # Convert the number into
  def to_word
    puts hun_ten_uni
  end

  private
  # Sections of 3 -- hundreds, tens, units
  def hun_ten_uni num_sep
    c = -1
    num_sep.length.times {
      # No tens or hundreds
      if num_sep[c].length == 1
        # Applying the name of the number to a new array
        num_names[c] = digit_names(num_sep[c][-1])
      # No hundreds
      elsif num_sep[c].length == 2
        # If it's a 'teen' (or 10)
        if num_sep[c][-2] == 1
          num_names[c] = digit_names(num_sep[c][-2] + num_sep[c][-1])
        # Not a 'teen' i.e. 20, 21 etc
        else
          # Ends in 0 i.e. 20, 30, 40 etc
          if num_sep[c][-1] == 0
            num_names[c] = digit_names(num_sep[c][-2])
          # Not a 0
          else
            num_names[c] = digit_names(num_sep[c][-2]) + " " + digit_names(num_sep[c][-1])
          end
        end
      # Units tens and hundreds
      else
        # Hundreds is 0
        if num_sep[c][-3] == "0"
          # If it's a 'teen' (or 10)
          if num_sep[c][-2] == 1
            num_names[c] = digit_names(num_sep[c][-2] + num_sep[c][-1])
          # Not a 'teen' i.e. 20, 21 etc
          else
            # Ends in 0 i.e. 20, 30, 40 etc
            if num_sep[c][-1] == 0
              num_names[c] = digit_names(num_sep[c][-2])
            # Not a 0
            else
              num_names[c] = digit_names(num_sep[c][-2]) + " " + digit_names(num_sep[c][-1])
            end
          end
        # Hundreds has a value
        else
          # Tens and units are 0
          if num_sep[c][-2] == 0 and num_sep[c][-1] == 0
            num_names[c] = digit_names(num_sep[c][-3]) + " hundred"
          # Tens or units have value
          else
            a = digit_names(num_sep[c][-3]) + " hundred"
            # If it's a 'teen' (or 10)
            if num_sep[c][-2] == 1
              b = digit_names(num_sep[c][-2] + num_sep[c][-1])
            # Not a 'teen' i.e. 20, 21 etc
            else
              # Ends in 0 i.e. 20, 30, 40 etc
              if num_sep[c][-1] == 0
                b = digit_names(num_sep[c][-2])
              # Not a 0
              else
                b = digit_names(num_sep[c][-2]) + " " + digit_names(num_sep[c][-1])
              end
            end
            num_names[c] = a + b
          end
        end
      end
      # The suffix (thousand, million etc)
      case c
      when -2 then num_names[c] += " thousand"
      when -3 then num_names[c] += " million"
      when -4 then num_names[c] += " billion"
      c -= 1
    }
    num_names
  end

  # Takes digits (and >10 but sshh) and retuerns the word value
  def digit_names dig
    case dig
    when "1" then val = "one"
    when "2" then val = "two"
    when "3" then val = "three"
    when "4" then val = "four"
    when "5" then val = "five"
    when "6" then val = "six"
    when "7" then val = "seven"
    when "8" then val = "eight"
    when "9" then val = "nine"
    when "10" then val = "ten"
    when "11" then val = "eleven"
    when "12" then val = "twelve"
    when "13" then val = "thirteen"
    when "14" then val = "fourteen"
    when "15" then val = "fifteen"
    when "16" then val = "sixteen"
    when "17" then val = "seventeen"
    when "18" then val = "eighteen"
    when "19" then val = "nineteen"
    when "20" then val = "twenty"
    when "30" then val = "thirty"
    when "40" then val = "fourty"
    when "50" then val = "fifty"
    when "60" then val = "sixty"
    when "70" then val = "seventy"
    when "80" then val = "eighty"
    when "90" then val = "ninety"
    end
    val
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
