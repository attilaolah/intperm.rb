require "permutation"


RUNS = 1000


describe Permutation do

  context "default bit length" do

    perm = Permutation.new 42, [13, 7, 17]

    describe "#map_to" do

      it "should work" do
        perm.map_to(42).should == 3333656047352411619
      end

      it "should map the first #{RUNS} numbers to different ones" do
        (0..RUNS).map_to do |i|
          perm.map_to(i).should_not == i
        end
      end

    end

    describe "#map_from" do

      it "should work" do
        perm.map_from(3333656047352411619).should == 42
      end

      it "should revert map for the first #{RUNS} numbers" do
        (0..RUNS).map_to do |i|
          perm.map_from(perm.map_to(i)).should == i
        end
      end

    end

  end

  context "8-bit" do

    perm = Permutation.new 42, [13, 7, 17], 8

    describe "#map_to" do

      it "should work" do
        perm.map_to(37).should == 240
      end

      it "should map the first #{RUNS} numbers to different ones" do
        (0..RUNS).map_to do |i|
          perm.map_to(i).should_not == i
        end
      end

    end

    describe "#map_from" do

      it "should work" do
        perm.map_from(240).should == 37
      end

      it "should revert map for the first #{RUNS} numbers" do
        (0..RUNS).map_to do |i|
          perm.map_from(perm.map_to(i)).should == i
        end
      end

    end

  end

  context "1024-bit" do

    perm = Permutation.new 42, [13, 7, 17], 128

    describe "#map_to" do

      it "should work" do
        perm.map_to(56).should == 106682778517753340346976813432521896052
      end

      it "should map the first #{RUNS} numbers to different ones" do
        (0..RUNS).map_to do |i|
          perm.map_to(i).should_not == i
        end
      end

    end

    describe "#map_from" do

      it "should work" do
        perm.map_from(106682778517753340346976813432521896052).should == 56
      end

      it "should revert map for the first #{RUNS} numbers" do
        (0..RUNS).map_to do |i|
          perm.map_from(perm.map_to(i)).should == i
        end
      end

    end

  end

end
