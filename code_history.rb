

module RepoDepot

  class CodeHistory < Struct.new(:name, :events)

    def commits
      @commits ||= events.map(&:commit).uniq
    end

    def for_commit sha1
      Repository.new(sha1, events.select{|e| e.commit =~ /^#{sha1}/})
    end

    protected

    def collection_of symbol, class_object
      events.group_by(&symbol).map { |args| class_object.new(*args) }
    end

    def complexity_of collection
      collection.map(&:complexity).reduce(0.0, :+)
    end
  end

end
