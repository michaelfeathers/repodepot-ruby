
require 'rspec'
require_relative 'class.rb'

describe "RepoDepot::Class" do
  it "should have complexity zero if it has no events" do
    RepoDepot::Class.new("A", []).complexity.should == 0.0
  end

  it "should sum complexities of code events" do
    events = [CodeEvent.new(complexity: 1.0),
              CodeEvent.new(complexity: 2.0)]
    RepoDepot::Class.new("A", events).complexity.should == 3.0
  end
end
