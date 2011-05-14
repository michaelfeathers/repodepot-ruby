

module RepoDepot

  class CodeHistory < Struct.new(:name,:events)

    def commits
      @commits ||= events.map(&:commit)
    end

    protected

    def build_collection symbol, class_object
      events.group_by(&symbol).map { |args| class_object.new(*args) }
    end

    def complexity_of collection
      return 0.0 if collection.empty?
      collection.map(&:complexity).reduce(:+)
    end

  end

end
