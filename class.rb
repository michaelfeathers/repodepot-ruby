
module RepoDepot

  class Class

    def initialize name, events
      @events = events
    end

    def complexity
      @events.reduce(0) { |sum, e| sum += e.complexity }
    end

  end
end
