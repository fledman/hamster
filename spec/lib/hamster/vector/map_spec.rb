require "spec_helper"
require "hamster/vector"

describe Hamster::Vector do
  [:map, :collect].each do |method|
    describe "##{method}" do
      describe "when empty" do
        before do
          @original = Hamster.vector
          @mapped = @original.send(method) {}
        end

        it "returns self" do
          @mapped.should equal(@original)
        end
      end

      describe "when not empty" do
        before do
          @original = Hamster.vector("A", "B", "C")
        end

        describe "with a block" do
          before do
            @mapped = @original.send(method, &:downcase)
          end

          it "preserves the original values" do
            @original.should == Hamster.vector("A", "B", "C")
          end

          it "returns a new vector with the mapped values" do
            @mapped.should == Hamster.vector("a", "b", "c")
          end
        end

        describe "with no block" do
          before do
            @result = @original.send(method)
          end

          it "returns an Enumerator" do
            @result.class.should be(Enumerator)
            @result.each(&:downcase).should == Hamster.vector('a', 'b', 'c')
          end
        end
      end

      context "from a subclass" do
        it "returns an instance of the subclass" do
          @subclass = Class.new(Hamster::Vector)
          @instance = @subclass[1,2,3]
          @instance.map { |x| x + 1 }.class.should be(@subclass)
        end
      end
    end
  end
end