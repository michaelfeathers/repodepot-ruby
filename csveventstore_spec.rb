
require 'rspec'
require_relative 'csv_event_store.rb'

describe "CSVEventStore" do
  it "should read a complexity" do
    store = CSVEventStore.new('complexity,\n1.0\n')
    store.read_events.first.complexity.should == 1.0
  end

  it "should read a date" do
    store = CSVEventStore.new('date,complexity,\n1/12/1995,1.0\n')
    store.read_events.first.date.year.should == 1995
  end

end
