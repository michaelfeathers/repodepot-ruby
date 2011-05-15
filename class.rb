
require_relative 'codehistory.rb'
require_relative 'method.rb'

# Calling the collection `methods'.  If the override of
# Object#methods is too confusing, may rename it.

module RepoDepot

  class Class < CodeHistory

    def methods; @methods ||= collection_of(:method_name, Method); end

    def complexity
      complexity_of(methods)
    end

  end
end
