
module RepoDepot
  class Repository
    attr_reader :classes

    def initialize name, events
      @events = events
      @classes = events.group_by {|e| e.class_name }
                       .map { |name, events| Class.new(name, events) }
    end

    def commits
      @commits ||= @events.map { |e| e.commit }
    end
  end
end
