class Blank
  def color
    nil
  end

  def blank?
    true
  end

  def blocked?
    false
  end

  def ==(another)
    another.blank?
  end
end
