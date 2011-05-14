
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

  it "should generate no commits when there are no events" do
    RepoDepot::Repository.new('example', []).commits.should be_empty
  end

  it "should create a list of commits for events" do
    events = [CodeEvent.new(commit: '9e9273dcbbc7bcc882520f2a8ffe13e4f3b273ac'),
              CodeEvent.new(commit: 'e9c1c0adb4e92d4b2c4117dbc139821ccf2b2851')]


  end
end
