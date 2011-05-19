
require 'rspec'
require_relative 'code_event.rb'
require_relative 'utilities.rb'

describe "assert_date_sorted" do
  include RepoDepot::InstanceMethods

  it "doesn't throw when dates are in order" do
    events = [CodeEvent.new(date: '1/1/2011'),
              CodeEvent.new(date: '2/1/2011')]
    lambda { assert_date_sorted(events) }.should_not raise_error
  end

  it "throws when dates of events are not in order" do
    events = [CodeEvent.new(date: '2/1/2011'),
              CodeEvent.new(date: '1/1/2011')]
    lambda { assert_date_sorted(events) }.should raise_error
  end

  it "ignores events without dates" do
    events = [CodeEvent.new(complexity: 2.1),
              CodeEvent.new(date: '2/1/2011')]
    lambda { assert_date_sorted(events) }.should_not raise_error
  end

end
