class Blockage
  def color
    nil
  end

  def blank?
    false
  end

  def blocked?
    true
  end

  def ==(another)
    another.blocked?
  end
end
