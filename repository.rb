
require_relative 'class.rb'
require_relative 'sourcefile.rb'

# MF remove duplication in initialize

module RepoDepot
  class Repository
    attr_reader :classes, :source_files

    def initialize name, events
      @events = events
      @classes = events.group_by {|e| e.class_name }
                       .map { |name, events| Class.new(name, events) }
      @source_files = events.group_by {|e| e.file_name }
                       .map { |name, events| SourceFile.new(name, events) }
    end

    def commits
      @commits ||= @events.map { |e| e.commit }
    end

  end
end
