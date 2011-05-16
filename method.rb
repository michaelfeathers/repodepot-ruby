

module RepoDepot
  class Method < CodeHistory

    def life_line
      events.map(&:complexity)
    end

    def deltas
      events.each_cons(2).map do |first, second|
        second.complexity - first.complexity
      end
    end

    def full_name
      events.first.full_method_name
    end

    def complexity
      return 0.0 if events.empty?
      events.last.complexity
    end

  end
end
