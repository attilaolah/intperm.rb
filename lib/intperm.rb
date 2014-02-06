require 'yaml'

# Main permutation class.
class Permutation
  def initialize(seed, bit_length = 64)
    @mask = (1 << bit_length) - 1
    xorshift = XORShift.new seed, @mask
    @masks = (0.upto bit_length * 2).map do |i|
      xorshift.next & ((1 << (i >> 1)) ^ @mask)
    end
    @bit_length = bit_length
  end

  def map_to(num)
    permutate num, (0.upto @bit_length - 1)
  end

  def map_from(num)
    permutate num, ((@bit_length - 1).downto 0)
  end

  private

  def permutate(num, range)
    range.each do |i|
      num ^= bitmask_at_bit num, i
    end
    num
  end

  def bitmask_at_bit(num, bit)
    bit_mask = 1 << bit
    if (bit_mask & num) >> bit == 0
      num = @mask ^ (@masks[(bit << 1) +
                     ((bit_mask & num) >> bit)] | (bit_mask ^ bit_mask & num))
    else
      num = @mask ^ (@masks[(bit << 1) +
                     ((bit_mask & num) >> bit)] | (bit_mask & num))
    end
    num
  end
end

TRIPLETS = YAML.load_file File.join File.dirname(__FILE__), 'parameters.yaml'

# XOR shift helper class.
# Used for expanding the seed to a random stream.
class XORShift
  def initialize(seed, bitmask)
    @seed = seed
    @a, @b, @c = TRIPLETS[seed % TRIPLETS.length]
    @bitmask = bitmask
  end

  def next
    @seed ^= @bitmask & (@seed << @a)
    @seed ^= @bitmask & (@seed >> @b)
    @seed ^= @bitmask & (@seed << @c)
  end
end
