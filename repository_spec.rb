
require 'rspec'
require_relative 'codeevent.rb'
require_relative 'repository.rb'

describe "RepoDepot::Repository" do
  it "should not populate classes when not given events" do
    repository = RepoDepot::Repository.new('example', [])
    repository.classes.should be_empty
  end

  it "should add a class when there is an event for a class" do
    event = CodeEvent.new(class_name: "A")
    repository = RepoDepot::Repository.new('example', [event])
    repository.classes.count.should == 1
  end


end
