
module RepoDepot
  class Depot < Repository

    def initialize name
      super(name, load(name))
    end

    private

    def load name
      new_events = read_events(name).sort_by(&:date)
      weave(new_events)
      new_events
    end

  end
end
