require 'intperm'

describe Permutation do

  RUNS = 1000

  context 'default bit length' do

    perm = Permutation.new 42
    long_number = 4_627_128_764_160_949_907

    describe '#map_to' do

      it 'should work' do
        perm.map_to(42).should == long_number
      end

      it "should map the first #{RUNS} numbers to different ones" do
        (0..RUNS).map do |i|
          perm.map_to(i).should_not == i
        end
      end

    end

    describe '#map_from' do

      it 'should work' do
        perm.map_from(long_number).should == 42
      end

      it "should revert map for the first #{RUNS} numbers" do
        (0..RUNS).map do |i|
          perm.map_from(perm.map_to(i)).should == i
        end
      end

    end

  end

  context '8-bit' do

    perm = Permutation.new 42, 8

    describe '#map_to' do

      it 'should work' do
        perm.map_to(37).should == 176
      end

      it "should map the first #{RUNS} numbers to different ones" do
        (0..RUNS).map do |i|
          perm.map_to(i).should_not == i
        end
      end

    end

    describe '#map_from' do

      it 'should work' do
        perm.map_from(176).should == 37
      end

      it "should revert map for the first #{RUNS} numbers" do
        (0..RUNS).map do |i|
          perm.map_from(perm.map_to(i)).should == i
        end
      end

    end

  end

  context '1024-bit' do

    perm = Permutation.new 42, 128
    very_long_number = 81_392_983_963_414_944_927_135_017_739_969_369_693

    describe '#map_to' do

      it 'should work' do
        perm.map_to(56).should == very_long_number
      end

      it "should map the first #{RUNS} numbers to different ones" do
        (0..RUNS).map do |i|
          perm.map_to(i).should_not == i
        end
      end

    end

    describe '#map_from' do

      it 'should work' do
        perm.map_from(very_long_number).should == 56
      end

      it "should revert map for the first #{RUNS} numbers" do
        (0..RUNS).map do |i|
          perm.map_from(perm.map_to(i)).should == i
        end
      end

    end

  end

end
