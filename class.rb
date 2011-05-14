
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
      return 0.0 if declared_methods.empty?
      declared_methods.map(&:complexity).reduce(:+)
    end

  end
end
