
require 'rspec'
require_relative 'class.rb'

describe "RepoDepot::Class" do
  it "should have complexity zero if it has no events" do
    RepoDepot::Class.new("A", []).complexity.should == 0.0
  end

  it "should sum the complexities of its code events" do
    events = [CodeEvent.new(method_name: "a", complexity: 1.0),
              CodeEvent.new(method_name: "b", complexity: 2.0)]
    RepoDepot::Class.new("A", events).complexity.should == 3.0
  end

  it "should have no methods when it is given no events" do
    RepoDepot::Class.new("A", []).declared_methods.should be_empty
  end

  it "should have two methods when given appropriate events" do
   events = [CodeEvent.new(method_name: 'a'),
             CodeEvent.new(method_name: 'b')]
   RepoDepot::Class.new("A", events).declared_methods.count.should == 2
  end
end
