
module RepoDepot
  module InstanceMethods
    def assert_date_sorted events
      events_to_check = events.select {|e| e.date }
      raise "events out of date order" unless events_to_check.each_cons(2).map {|e1, e2| e1.date < e2.date }.all?
    end
  end
end
