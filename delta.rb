
module RepoDepot

  class Delta
    def initialize events, first_commit, second_commit
      @repository = Repository.new('', events)
      @first_commit = first_commit
      @second_commit = second_commit
    end

    def removed_methods
      @repository.methods.select { |m| m.events.count == 1 }
                         .select { |m| m.events.first.commit == @first_commit }
    end

    def added_methods
      @repository.methods.select {|m| m.events.count == 1 }
                         .select { |m| m.events.first.commit == @second_commit }
    end

    def changed_methods
      @repository.methods.select { |m| m.events.count == 2 }
                         .select { |m| m.events[0].complexity != m.events[1].complexity }
    end
  end

end
