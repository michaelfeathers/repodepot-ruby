
require 'rspec'
require_relative 'repository.rb'

describe "RepoDepot::Delta" do
  context "#removed_methods" do
    it "reports zero when the commits are empty" do
      r = RepoDepot::Repository.new('', [])
      r.delta_for_commits('1a2', '3b4').removed_methods.count.should eq(0)
    end

    it "reports one when a method disappears between commits" do
      event = CodeEvent.new(commit: 'a', class_name: 'class_a', method_name: 'method_a')
      r = RepoDepot::Repository.new('', [event])
      r.delta_for_commits('a', 'b').removed_methods.count.should eq(1)
    end

  end
end
