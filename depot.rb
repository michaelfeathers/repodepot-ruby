
module RepoDepot
  class Depot

    def self.load name
      events = read_events(name).sort_by(&:date)
      events = events.select {|e| e.class_name =~ /^[A-Z]/ }
      events = events.reject {|e| e.method_name == "none" }
      weave(events)
      Repository.new(name, events)
    end

  end
end
