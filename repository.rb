
require_relative 'class.rb'
require_relative 'sourcefile.rb'

module RepoDepot
  class Repository
    attr_reader :classes, :source_files

    def initialize name, events
      @events = events
      @classes = build_collection(:class_name, Class)
      @source_files = build_collection(:file_name, SourceFile)
    end

    def commits
      @commits ||= @events.map { |e| e.commit }
    end

  private
    def build_collection symbol, class_object
      @events.group_by(&symbol).map { |args| class_object.new(*args) }
    end

  end
end
