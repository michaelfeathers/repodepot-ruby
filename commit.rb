
module RepoDepot

  class Commit < CodeHistory

    def added_methods
      Repository.new('', events.reject {|e| e.previous_state }).methods
    end

    def added_complexity
      events.reduce(0.0) do |sum,e|
        if not e.previous_state
          sum += e.complexity
        elsif e.previous_state.complexity >= e.complexity
          sum += 0.0
        else
          sum += e.complexity - e.previous_state.complexity
        end
      end
    end

  end
end
