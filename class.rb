
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
      complexity_of(@declared_methods)
    end

  end
end
