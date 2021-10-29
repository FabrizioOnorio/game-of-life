class Cell
  attr_accessor :active, :x, :y

  # Every cell is inizialized with a non-active attribute

  def initialize(x = 0, y = 0)
    @active = false
    @x = x
    @y = y
  end

  def active?
    active
  end

  def dead?
    !active
  end
end
