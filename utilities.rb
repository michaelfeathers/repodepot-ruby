
module RepoDepot
  def assert_date_sorted events
    raise "events out of date order" unless events.each_cons(2).map {|e1, e2| e1.date < e2.date }.all?
  end
end
