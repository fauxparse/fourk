class Color
  attr_reader :name, :hex

  def initialize(name, hex)
    @name = name
    @hex = hex
  end

  def ==(another)
    to_s == another.to_s
  end

  def to_s
    name.to_s
  end

  def self.[](name)
    @cache ||= {}
    name = name.to_s
    @cache[name] ||= ALL.detect { |color| color.to_s == name }
  end

  def self.first(n)
    ALL[0, n]
  end

  ALL = [
    new(:red,    '#F44336'),
    new(:blue,   '#2196F3'),
    new(:green,  '#8BC34A'),
    new(:yellow, '#FFEB3B')
  ]
end
