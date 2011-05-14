
require_relative 'codehistory.rb'
require_relative 'method.rb'

module RepoDepot

  class Class < CodeHistory
    attr_reader :declared_methods

    def initialize name, events
      super
      @declared_methods = build_collection(:method_name, Method)
    end

    def complexity
      events.reduce(0) { |sum, e| sum += e.complexity }
    end

  end
end
