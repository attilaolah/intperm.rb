require "permutation"


RUNS = 1000


describe Permutation do

  context "default bit length" do

    perm = Permutation.new 42, [13, 7, 17]

    describe "#map" do

      it "should work" do
        perm.map(42).should == 3333656047352411619
      end

      it "should map the first #{RUNS} numbers to different ones" do
        (0..RUNS).map do |i|
          perm.map(i).should_not == i
        end
      end

    end

    describe "#unmap" do

      it "should work" do
        perm.unmap(3333656047352411619).should == 42
      end

      it "should revert map for the first #{RUNS} numbers" do
        (0..RUNS).map do |i|
          perm.unmap(perm.map(i)).should == i
        end
      end

    end

  end

  context "8-bit" do

    perm = Permutation.new 42, [13, 7, 17], 8

    describe "#map" do

      it "should work" do
        perm.map(37).should == 240
      end

      it "should map the first #{RUNS} numbers to different ones" do
        (0..RUNS).map do |i|
          perm.map(i).should_not == i
        end
      end

    end

    describe "#unmap" do

      it "should work" do
        perm.unmap(240).should == 37
      end

      it "should revert map for the first #{RUNS} numbers" do
        (0..RUNS).map do |i|
          perm.unmap(perm.map(i)).should == i
        end
      end

    end

  end

  context "1024-bit" do

    perm = Permutation.new 42, [13, 7, 17], 128

    describe "#map" do

      it "should work" do
        perm.map(56).should == 106682778517753340346976813432521896052
      end

      it "should map the first #{RUNS} numbers to different ones" do
        (0..RUNS).map do |i|
          perm.map(i).should_not == i
        end
      end

    end

    describe "#unmap" do

      it "should work" do
        perm.unmap(106682778517753340346976813432521896052).should == 56
      end

      it "should revert map for the first #{RUNS} numbers" do
        (0..RUNS).map do |i|
          perm.unmap(perm.map(i)).should == i
        end
      end

    end

  end

end
