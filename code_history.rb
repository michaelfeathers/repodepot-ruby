
require_relative 'utilities.rb'

module RepoDepot

  class CodeHistory
    include InstanceMethods

    attr_reader :name, :events

    def initialize name, events
      assert_date_sorted events
      @name = name
      @events = events
    end

    def commits
      @commits ||= events.map(&:commit).uniq
    end

    def for_commit sha1
      Repository.new(sha1, events.group_by(&:commit)[sha1])
    end

    def state_at_commit sha1
      events.group_by(&:commit)[sha1]
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
