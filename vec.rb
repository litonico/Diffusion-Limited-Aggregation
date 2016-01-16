class Vec2
  attr_accessor :x, :y
  def initialize x, y
    @x = x
    @y = y
  end

  def + other
    Vec2.new @x+other.x, @y+other.y
  end

  def - other
    Vec2.new @x-other.x, @y-other.y
  end

  def scale s
    Vec2.new @x*s, @y*s
  end

  def * s
    Vec2.new @x*s, @y*s
  end

  def / s
    Vec2.new @x/s, @y/s
  end

  def == other
    @x == other.x && @y == other.y
  end

  def magnitude_squared
    @x**2 + @y**2
  end

  def magnitude
    Math.sqrt(self.magnitude_squared)
  end

  def normalize
    m = self.magnitude
    if m == 0
      Vec2.new 0, 0
    else
      Vec2.new @x.to_f/m, @y.to_f/m
    end
  end

  def distance_from other
    (other - self).magnitude
  end

  def distance_squared_from other
    (other - self).magnitude_squared
  end

  def clamp s
    m = self.magnitude
    if m == 0.0
      Vec2.new 0, 0
    elsif m > s
      self.scale s.to_f/m
    else
      self
    end
  end

  def self.random
    angle = rand * 2.0*Math::PI
    Vec2.new Math.cos(angle), Math.sin(angle)
  end

  def self.random_positive
    Vec2.new rand, rand
  end

  def map &block
    Vec2.new block.call(self.x), block.call(self.y)
  end
end

ORIGIN = Vec2.new 0.0, 0.0

class Particle
  attr_accessor :velocity, :position, :age
  alias pos position

  def initialize pos=ORIGIN, vel=ORIGIN
    @position = pos
    @velocity = vel
    @age = 0
  end

  def step
    @position += @velocity

    if position.x > 500
      position.x = position.x % 500
    elsif position.x < 0
      position.x = 500 - position.x
    end

    if position.y > 500
      position.y = position.y % 500
    elsif position.y < 0
      position.y = 500 - position.y
    end

    self
  end

  def distance_from other
    (other.position - self.position).magnitude
  end
end
