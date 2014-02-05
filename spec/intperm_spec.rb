require 'intperm'


RUNS = 1000


describe Permutation do

  context "default bit length" do

    perm = Permutation.new 42

    describe "#map_to" do

      it "should work" do
        perm.map_to(42).should == 4627128764160949907
      end

      it "should map the first #{RUNS} numbers to different ones" do
        (0..RUNS).map do |i|
          perm.map_to(i).should_not == i
        end
      end

    end

    describe "#map_from" do

      it "should work" do
        perm.map_from(4627128764160949907).should == 42
      end

      it "should revert map for the first #{RUNS} numbers" do
        (0..RUNS).map do |i|
          perm.map_from(perm.map_to(i)).should == i
        end
      end

    end

  end

  context "8-bit" do

    perm = Permutation.new 42, 8

    describe "#map_to" do

      it "should work" do
        perm.map_to(37).should == 176
      end

      it "should map the first #{RUNS} numbers to different ones" do
        (0..RUNS).map do |i|
          perm.map_to(i).should_not == i
        end
      end

    end

    describe "#map_from" do

      it "should work" do
        perm.map_from(176).should == 37
      end

      it "should revert map for the first #{RUNS} numbers" do
        (0..RUNS).map do |i|
          perm.map_from(perm.map_to(i)).should == i
        end
      end

    end

  end

  context "1024-bit" do

    perm = Permutation.new 42, 128

    describe "#map_to" do

      it "should work" do
        perm.map_to(56).should == 81392983963414944927135017739969369693
      end

      it "should map the first #{RUNS} numbers to different ones" do
        (0..RUNS).map do |i|
          perm.map_to(i).should_not == i
        end
      end

    end

    describe "#map_from" do

      it "should work" do
        perm.map_from(81392983963414944927135017739969369693).should == 56
      end

      it "should revert map for the first #{RUNS} numbers" do
        (0..RUNS).map do |i|
          perm.map_from(perm.map_to(i)).should == i
        end
      end

    end

  end

end