class Permutation

  def initialize(seed, params, bit_length=64)
    @bit_length = bit_length
    @mask = (1 << bit_length)-1
    xorshift = XORShift.new seed, params, @mask
    @masks = (0.upto bit_length*2).map { |i| xorshift.next & ((1 << (i >> 1)) ^ @mask) }
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

private

class XORShift

  def initialize(seed, params, bitmask)
    @seed = seed
    @a, @b, @c = params
    @bitmask = bitmask
  end

  def next
    @seed ^= @bitmask & (@seed << @a)
    @seed ^= @bitmask & (@seed >> @b)
    @seed ^= @bitmask & (@seed << @c)
  end
end
