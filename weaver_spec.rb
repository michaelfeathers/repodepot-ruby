
require 'rspec'
require_relative 'weaver.rb'

describe "Weaver" do

  it "should be able to link events" do
    events = (0..2).map { |i| CodeEvent.new(name: i.to_s) }
    link events, :next_state
    events[0].next_state.should == events[1]
    events[1].next_state.should == events[2]
  end

  it "should be able to weave events" do
    events = []
    events << CodeEvent.new(class_name: 'Foo', commit: 'a', method_name: 'moe')
    events << CodeEvent.new(class_name: 'Foo', commit: 'a', method_name: 'larry')
    events << CodeEvent.new(class_name: 'Foo', commit: 'a', method_name: 'curly')
    events << CodeEvent.new(class_name: 'Foo', commit: 'b', method_name: 'moe')
    events << CodeEvent.new(class_name: 'Foo', commit: 'b', method_name: 'larry')
    events << CodeEvent.new(class_name: 'Foo', commit: 'b', method_name: 'curly')
    events << CodeEvent.new(class_name: 'Foo', commit: 'c', method_name: 'moe')
    events << CodeEvent.new(class_name: 'Foo', commit: 'c', method_name: 'larry')
    events << CodeEvent.new(class_name: 'Foo', commit: 'c', method_name: 'curly')

    weave(events)
    method_events = RepoDepot::Repository.new('', events).methods.first.events
    method_events.each_cons(2).map { |e0, e1| e0.next_state.should == e1 }
  end
end

