

require 'rspec'
require_relative 'commit.rb'

describe "RepoDepot::Commit" do
  context "#added_methods" do
    it "reports zero when there are no events" do
      RepoDepot::Commit.new('', []).added_methods.should be_empty
    end

    it "has one method when the commit has an event with no previous state" do
      (events ||= []) << CodeEvent.new({})
      RepoDepot::Commit.new('', events).added_methods.count.should eq(1)
    end

    it "has no methods when the commit has an event with a previous state" do
      (events ||= []) << CodeEvent.new(previous_state: CodeEvent.new({}))
      RepoDepot::Commit.new('', events).added_methods.count.should eq(0)
    end
  end

  context "#added_complexity" do
    it "has the complexity of added methods when there are no previous events" do
      events = [CodeEvent.new(complexity: 0.5), CodeEvent.new(complexity: 0.5)]
      RepoDepot::Commit.new('', events).added_complexity.should eq(1.0)
    end

    it "has the difference of current and previous complexities for non-added methods" do
      previous = CodeEvent.new(complexity: 0.3)
      current = CodeEvent.new(complexity: 1.0, previous_state: previous)
      RepoDepot::Commit.new('', [current]).added_complexity.should eq(0.7)
    end

    it "reports zero for added complexity when a method reduces in complexity" do
      previous = CodeEvent.new(complexity: 0.3)
      current = CodeEvent.new(complexity: 0.1, previous_state: previous)
      RepoDepot::Commit.new('', [current]).added_complexity.should eq(0.0)
    end

    it "dances grand coupe den finalen" do
      previous = CodeEvent.new(complexity: 0.1)
      events = [CodeEvent.new(complexity: 0.5),
                CodeEvent.new(complexity: 0.3),
                CodeEvent.new(complexity: 0.2, previous_state: previous)]
      RepoDepot::Commit.new('', events).added_complexity.should eq(0.9)
    end
  end
end

