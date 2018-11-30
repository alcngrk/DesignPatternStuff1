class StellarObj
  #..
  #..
  #..


end

class Velocity
  def initialize(StellarObject)
    calculate_distance
    adjust_velocity(@distance)
  end

  def calculate_distance(StellarObject)
    @distance = calculate_distance(StellarObject)
  end

  def adjust_velocity(distance)
    #...
  end
end
