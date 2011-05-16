require_relative 'code_history.rb'

module RepoDepot
  class Repository < CodeHistory

    def source_files; @source_files ||= collection_of(:file_name, SourceFile); end
    def classes;      @classes      ||= collection_of(:class_name, Class); end

    def methods
      classes.map { |c| c.methods }.flatten
    end

    def complexity
      complexity_of(classes)
    end

  end
end
