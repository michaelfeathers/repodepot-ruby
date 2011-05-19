
require 'rspec'
require_relative 'code_event.rb'
require_relative 'code_history.rb'

describe "RepoDepot::CodeHistory" do
  context "#for_commit" do
    it "returns a new repository for a commit" do
      commit = 'a1b2c3'
      event = CodeEvent.new(commit: commit, method_name: 'bar')
      repository = RepoDepot::CodeHistory.new('example', [event]).for_commit commit
      repository.methods.count.should eq(1)
    end
  end

end
