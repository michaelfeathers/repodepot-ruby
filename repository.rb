require_relative 'code_history.rb'
require_relative 'source_file.rb'
require_relative 'class.rb'
require_relative 'delta.rb'

module RepoDepot
  class Repository < CodeHistory

    def source_files; @source_files ||= collection_of(:file_name, SourceFile); end
    def classes;      @classes      ||= collection_of(:class_name, Class); end

    def methods
      classes.map { |c| c.methods }.flatten
    end

    def delta_for_commits sha_a, sha_b
      delta_events = events.select { |e| e.commit == sha_a || e.commit == sha_b }
      Delta.new(delta_events, sha_a, sha_b)
    end

    def complexity
      complexity_of(classes)
    end

  end
end
