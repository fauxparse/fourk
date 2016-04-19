class Color
  attr_reader :name

  def initialize(name)
    @name = name
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
    new(:red),
    new(:blue),
    new(:green),
    new(:yellow)
  ]

  COLOR_NAMES = ALL.map(&:name)

  HASH = Hash[COLOR_NAMES.map(&:to_sym).zip(COLOR_NAMES.map(&:to_s))].freeze
end
