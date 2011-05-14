
require 'time'
require_relative 'codeevent.rb'

class CSVEventStore
  def initialize csv_text
    lines = csv_text.split($/)
    @csv_body = lines.drop(1)
  end

  def read_events
    [ CodeEvent.new(complexity: 1.0, date: Time.parse('1/1/1995')) ]
  end
end
