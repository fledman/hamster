require "spec_helper"
require "hamster/sorted_set"

describe Hamster::SortedSet do
  [:find_index, :index].each do |method|
    describe "##{method}" do
      [
        [[], "A", nil],
        [[], nil, nil],
        [["A"], "A", 0],
        [["A"], "B", nil],
        [["A"], nil, nil],
        [["A", "B", "C"], "A", 0],
        [["A", "B", "C"], "B", 1],
        [["A", "B", "C"], "C", 2],
        [["A", "B", "C"], "D", nil],
        [[2], 2, 0],
        [[2], 2.0, 0],
        [[2.0], 2.0, 0],
        [[2.0], 2, 0],
      ].each do |values, item, expected|
        context "looking for #{item.inspect} in #{values.inspect}" do
          it "returns #{expected.inspect}" do
            Hamster.sorted_set(*values).send(method) { |x| x == item }.should == expected
          end
        end
      end
    end
  end
end