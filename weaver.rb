

def link events, link_symbol
  assign_symbol = (link_symbol.to_s + "=").to_sym
  events.each_cons(2).each { |e0, e1| e0.send(assign_symbol, e1) }
end

def weave events
  RepoDepot::Repository.new('', events).methods.each do |m|
    link m.events, :next_state
    link m.events.reverse, :previous_state
  end
end

