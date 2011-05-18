
require 'rspec'
require_relative 'code_event.rb'
require_relative 'method.rb'

describe "RepoDepot::Method" do
  it "should generate a life line" do
    events = [CodeEvent.new(complexity: 1.2),
              CodeEvent.new(complexity: 3.4)]
    RepoDepot::Method.new('', events).life_line.should == [1.2, 3.4]
  end

  it "should generate deltas" do
    events = [CodeEvent.new(complexity: 1),
              CodeEvent.new(complexity: 2),
              CodeEvent.new(complexity: 1)]
    RepoDepot::Method.new('', events).deltas.should == [1, -1]
  end

  it "should report its current complexity" do
    events = [CodeEvent.new(complexity: 1.2),
              CodeEvent.new(complexity: 2),
              CodeEvent.new(complexity: 11.4)]
    RepoDepot::Method.new('', events).complexity.should == 11.4
  end

  it "reports zero complexity when it has no events" do
    RepoDepot::Method.new('', []).complexity.should == 0.0
  end

end
