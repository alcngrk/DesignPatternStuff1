#attributes[] = hp, spd, str, int

class Weapon
  def initialize
    raise NotImplementedError
  end

  def modifyAttributes
    raise NotImplementedError
  end

  def get_wielder_type
    @wielderType
  end

  def get_favored_stat
    raise NotImplementedError
  end
end


class Katana    < Weapon
  def initialize()
    @wielderType = "Orochi"
    #moderate reach, light weight, favors speed.
  end

  def modifyAttributes(attributes)
    @modifiedAttributes = attributes
    @modifiedAttributes[1] = attributes[1] + 3

    @modifiedAttributes
  end

  def get_favored_stats
    return [1,2,1,1]
  end
end


class Claws    < Weapon
  def initialize()
    @wielderType = "O'Dimm"
    #User can not have this weapon, it belongs to detlaff
  end

  def modifyAttributes(attributes)
    @modifiedAttributes = attributes
    @modifiedAttributes[1] = attributes[1] + 3
    @modifiedAttributes[2] = attributes[2] + 1

    @modifiedAttributes
  end

  def get_favored_stats
    return [1,3,1.25,0.5]
  end
end

class Gladius   < Weapon
  def initialize
    @wielderType = "Centurion"
    #short reach, light weight, double edged, favors strength and speed
  end

  def modifyAttributes(attributes)
    @modifiedAttributes = attributes
    @modifiedAttributes[1] = attributes[1] + 1
    @modifiedAttributes[2] = attributes[2] + 2

    @modifiedAttributes
  end

  def get_favored_stats
    return [1,1.33,1.67,1]
  end
end


class Nagamaki  < Weapon
  def initialize
    @wielderType = "Alonne"
    #huge reach, heavy weight, favors strength greatly, hinders speed.
  end

  def modifyAttributes(attributes)
    @modifiedAttributes = attributes
    @modifiedAttributes[1] = attributes[1] - 1
    @modifiedAttributes[2] = attributes[2] + 6

    @modifiedAttributes
  end

  def get_favored_stats
    return [1,1,2,1]
  end
end

class Staff   < Weapon
  def initialize
    @wielderType = "LameAssWizard"
    #really lame, favors int, for chumps
  end

  def modifyAttributes(attributes)
    @modifiedAttributes = attributes
    @modifiedAttributes[3] = attributes[3] + 3

    @modifiedAttributes
  end

  def get_favored_stats
    return [1,1,1,2]
  end
end
