

class Delta < Struct.new(:events_commitA, :events_commitB)

  def removed_methods
    events_commitA.map(&:method_name).uniq - events_commitB.map(&:method_name).uniq
  end
end
