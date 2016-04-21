class Blank < Tile
  def initialize
    super nil
  end

  def blank?
    true
  end

  def ==(another)
    another.blank?
  end
end
