
module RepoDepot

  class Delta
    def initialize events, first_commit, second_commit
      @repository = Repository.new('', events)
      @first_commit = first_commit
      @second_commit = second_commit
    end

    def removed_methods
      @repository.methods.select {|m| m.events.count == 1 && m.events.first.commit == @first_commit }.map(&:full_name)
    end
  end

end
