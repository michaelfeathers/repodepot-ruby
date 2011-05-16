
class CodeEvent

  def initialize(hash = {})
    hash.each_pair do |attr,value|
      define_attribute(attr)
      self.send(writer_for(attr), value)
    end
  end

  # Considering moving this to code that populates
  # events so that this class isn't making assumptions
  # about what it will be populated with
  def full_method_name
    class_name + "#" + method_name
  end

private
  def define_attribute(attr)
    singleton_class.send(:public)
    singleton_class.send(:attr_accessor, attr)
  end

  def singleton_class
    class << self; self; end
  end

  def reader_for(sym)
    sym.to_s.end_with?('=') ? sym.to_s.chop.to_sym : sym
  end

  def writer_for(sym)
    (sym.to_s + "=").to_sym
  end

  def method_missing(sym, *args, &block)
    if sym.to_s.end_with?('=')
      define_attribute(reader_for(sym))
      self.send(sym,*args)
    elsif args.count == 0
      return 0
    else
      super
    end
  end

end

