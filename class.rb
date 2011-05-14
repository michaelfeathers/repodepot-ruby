
require_relative 'method.rb'

module RepoDepot
  class Class
    attr_reader :declared_methods

    def initialize name, events
      @events = events
      @declared_methods = @events.group_by(&:method_name).map {|args| Method.new(*args) }
    end

    def complexity
      @events.reduce(0) { |sum, e| sum += e.complexity }
    end

  end
end
