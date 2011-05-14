
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
    RepoDepot::Repository.new('', events).commits.count == 2
  end

  it "should not populate files when not given events" do
    repository = RepoDepot::Repository.new('', [])
    repository.source_files.should be_empty
  end

  it "should add a file when there is an event for a file" do
    event = CodeEvent.new(file_name: "A")
    repository = RepoDepot::Repository.new('', [event])
    repository.source_files.count.should == 1
  end

  it "can calculate its total complexity" do
    events = [
      CodeEvent.new(class_name: "A", method_name: "a", complexity: 0.2),
      CodeEvent.new(class_name: "B", method_name: "a", complexity: 0.4)
    ]
    RepoDepot::Repository.new('', events).complexity.should be_within(0.1).of(0.6)
  end

end
