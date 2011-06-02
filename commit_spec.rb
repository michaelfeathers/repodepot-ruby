

require 'rspec'
require_relative 'commit.rb'

describe "RepoDepot::Commit" do
  context "#added_methods" do
    it "reports zero when there are no events" do
      RepoDepot::Commit.new('', []).added_methods.should be_empty
    end

    it "has zero methods when the commit has only events with no previous state" do
      (events ||= []) << CodeEvent.new({})
      RepoDepot::Commit.new('', events).added_methods.should be_empty
    end

    it "has one method when the commit has an event with a previous state" do
      events = [CodeEvent.new({}), CodeEvent.new({})]
      weave(events)
      RepoDepot::Commit.new('', events).added_methods.count.should eq(1)
    end
  end
end

