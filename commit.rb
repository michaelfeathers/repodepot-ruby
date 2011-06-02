
module RepoDepot

  class Commit < CodeHistory

    def added_methods
      Repository.new('', @events.select {|e| e.previous_state }).methods
    end

  end
end
