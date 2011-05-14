
module RepoDepot
  class Repository
    attr_reader :classes

    def initialize name, events
      @classes = events.group_by {|e| e.class_name }
                       .map { |name, events| Class.new(name, events) }
    end
  end
end
