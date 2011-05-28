
require 'rspec'
require_relative 'code_event.rb'
require_relative 'code_history.rb'

describe "RepoDepot::CodeHistory" do
  context "#for_commit" do
    it "returns a new repository for a commit" do
      commit = 'a1b2c3'
      event = CodeEvent.new(commit: commit, method_name: 'bar')
      repository = RepoDepot::CodeHistory.new('', [event]).for_commit commit
      repository.methods.count.should eq(1)
    end
  end

  context "#state_at_commit" do
    it "finds an event at a commit" do
      commit = 'a1b2c3'
      event = CodeEvent.new(commit: commit, method_name: 'bar')
      repository = RepoDepot::CodeHistory.new('', [event]).for_commit(commit)
      repository.state_at_commit(commit).map {|e| e.method_name }.should == ["bar"]
    end

    it "finds two events at a commit" do
      events = []
      commit = 'a'
      events << CodeEvent.new(commit: commit, class_name: 'Foo', method_name: 'bar')
      events << CodeEvent.new(commit: commit, class_name: 'Foo', method_name: 'baz')
      repository = RepoDepot::CodeHistory.new('', events).for_commit(commit)
      repository.state_at_commit(commit).map {|e| e.method_name }.should == ["bar", "baz"]
    end

    #it "finds an event that is earlier than the commit if there is no event for the commit" do
    #  events = []
    #  events << CodeEvent.new(commit: 'a', class_name: 'Foo', method_name: 'bar', date: '1/1/2011')
    #  events << CodeEvent.new(commit: 'b', class_name: 'Foo', method_name: 'baz', date: '1/1/2012')
    #  repository = RepoDepot::CodeHistory.new('', events).for_commit('b')
    #  repository.state_at_commit('b').map {|e| e.method_name }.should == ["bar", "baz"]
    #end
  end

end
