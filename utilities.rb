
module RepoDepot
  module InstanceMethods
    def assert_date_sorted events
      transitions = events.select {|e| e.date }.each_cons(2).to_a
      return unless transitions.map { |e1, e2| e1.date > e2.date }.any?

      failure = transitions.detect { |e1, e2| e1.date > e2.date }
      raise "events out of order #{failure[0].date}, #{failure[1].date}"
    end
  end
end
