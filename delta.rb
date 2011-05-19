
module RepoDepot

  class Delta
    def initialize events, first_commit, second_commit
      @repository = Repository.new('', events)
      @first_commit = first_commit
      @second_commit = second_commit
    end

    def removed_methods
      methods_with_only @first_commit
    end

    def added_methods
      methods_with_only @second_commit
    end

    def changed_methods
      methods_with_both_commits.select { |m| m.events[0].complexity != m.events[1].complexity }
    end

    private

    def methods_with_only commit
       @repository.methods.select { |m| m.events.count == 1 }
                          .select { |m| m.events.first.commit == commit }
    end

    def methods_with_both_commits
       @repository.methods.select { |m| m.events.count == 2 }
    end
  end

end
