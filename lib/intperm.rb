require 'data'

class Permutation

  def initialize(seed, bit_length=64)
    @mask = (1 << bit_length)-1
    xorshift = XORShift.new seed, @mask
    @masks = (0.upto bit_length*2).map { |i| xorshift.next & ((1 << (i >> 1)) ^ @mask) }
    @bit_length = bit_length
  end

  def map_to(num)
    do_map num, (0.upto @bit_length-1)
  end

  def map_from(num)
    do_map num, ((@bit_length-1).downto 0)
  end

  private

  def do_map(num, range)
    for i in range
      bit = 1 << i
      if (bit & num) >> i == 0
        num ^= @mask ^ (@masks[(i << 1)+((bit & num) >> i)] | (bit ^ bit & num))
      else
        num ^= @mask ^ (@masks[(i << 1)+((bit & num) >> i)] | (bit & num))
      end
    end
    num
  end
end

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
