
require_relative 'codehistory.rb'
require_relative 'class.rb'
require_relative 'sourcefile.rb'

module RepoDepot
  class Repository < CodeHistory
    attr_reader :classes, :source_files

    def initialize name, events
      super
      @classes = build_collection(:class_name, Class)
      @source_files = build_collection(:file_name, SourceFile)
    end

    def complexity
      return 0.0 if @classes.empty?
      @classes.map(&:complexity).reduce(:+)
    end

  end
end
