
require 'rspec'
require_relative 'repository.rb'

describe "RepoDepot::Delta" do
  context "#removed_methods" do
    it "reports when commits are empty" do
      r = RepoDepot::Repository.new('', [])
      r.delta_for_commits('1a2', '3b4').removed_methods.should be_empty
    end

    it "reports a method that disappears between commits" do
      event = CodeEvent.new(commit: 'a', class_name: 'class_a', method_name: 'method_a')
      r = RepoDepot::Repository.new('', [event])
      r.delta_for_commits('a', 'b').removed_methods.first.name.should eq('method_a')
    end
  end

  context "#added_methods" do
    it "reports when commits are empty" do
      r = RepoDepot::Repository.new('', [])
      r.delta_for_commits('1a2', '3b4').added_methods.should be_empty
    end

    it "reports a method that appears between commits" do
      event = CodeEvent.new(commit: 'b', class_name: 'class_a', method_name: 'method_a')
      r = RepoDepot::Repository.new('', [event])
      r.delta_for_commits('a', 'b').added_methods.first.name.should eq('method_a')
    end
 end

  context "#changed_methods" do
    it "reports no changed methods when all methods have the same complexity across commits" do
      eventA = CodeEvent.new(commit: 'a', class_name: 'class_a', method_name: 'method_a', complexity: 3.0)
      eventB = CodeEvent.new(commit: 'b', class_name: 'class_a', method_name: 'method_a', complexity: 3.0)
      r = RepoDepot::Repository.new('', [eventA, eventB])
      r.delta_for_commits('a', 'b').changed_methods.should be_empty
    end

    it "reports a change when a method changes in complexity" do
      eventA = CodeEvent.new(commit: 'a', class_name: 'class_a', method_name: 'method_a', complexity: 3.0)
      eventB = CodeEvent.new(commit: 'b', class_name: 'class_a', method_name: 'method_a', complexity: 2.0)
      r = RepoDepot::Repository.new('', [eventA, eventB])
      r.delta_for_commits('a', 'b').changed_methods.first.name.should eq('method_a')
    end
  end
end
