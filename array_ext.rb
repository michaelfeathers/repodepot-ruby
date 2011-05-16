

class Array

  def date_sorted
    sort { |left,right| left.date <=> right.date }
  end

  def transitions
    each_cons(2).to_a
  end

  def freq
    groups = group_by { |value| value }
    (0..(max || -1)).map { |bin| groups.fetch(bin, []).count }
  end

  def convolve filter_function
    window_size = method(filter_function).arity
    each_cons(window_size).map { |window| send(filter_function, *window) }
  end
end

