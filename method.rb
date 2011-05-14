

module RepoDepot
  class Method
    def initialize name, events
      @events = events
    end

    def life_line
      @events.map(&:complexity)
    end

    def deltas
      @events.each_cons(2).map do |first, second|
        second.complexity - first.complexity
      end
    end

    def complexity
      return 0.0 if @events == []
      @events.last.complexity
    end

  end
end
