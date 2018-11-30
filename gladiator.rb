class Gladiator
  def initialize(gladInitializer)
    @observers = []
    @name = [""]
    @baseAttributes = [0, 0, 0, 0] #hp, spd, str, int
    @weapon = gladInitializer.call(@baseAttributes,@name)

    if @name[0] == ""
      @name[0] = @weapon.get_wielder_type
    end

    if @baseAttributes[0]/10 + @baseAttributes[1] + @baseAttributes[2] + @baseAttributes[3] > 20
      if @weapon.get_wielder_type != "O'Dimm"
        puts "STOP CHEATING NOOB"
        exit
      end
    end


    @dodgeChance = @baseAttributes[1] * 5
    @parryChance = @baseAttributes[1] * 4 + @baseAttributes[3] * 6
  end

  def printObs                #to check if observers have been deleted properly
    puts @observers           #can disregard this function unless TA asks to make
    puts @observers.length    #sure observers are deleted
  end

  def detlaff_heal(amount)
    if @weapon.get_wielder_type == "O'Dimm"
      @baseAttributes[0] = @baseAttributes[0] + amount
      puts "O'Dimm healed up to " + @baseAttributes[0].to_s + " HP"
    end
  end

  def get_name()
    return @name
  end

  def add_observer(o)
    @observers << o
  end

  def remove_observers()
    @observers.clear if defined? @observers
  end

  def detlaff_hit(offset)
    if offset < 0 && offset > -999999
      if @baseAttributes[0] + offset < 0
        @baseAttributes[0] = 0
        notify_observers(offset)
        die()
      else
        @baseAttributes[0] = @baseAttributes[0] + offset
        if @weapon.get_wielder_type == "O'Dimm"
          puts "O'Dimm got hit down to " + @baseAttributes[0].to_s + " HP"
        else
          puts "HP = " + @baseAttributes[0].to_s
        end
        notify_observers(offset)
      end
    end
  end

  def notify_observers(offset)

    positiveResponse = lambda{
      if rand(2) == 0
        print "Cheer! "
      else
        print "Laugh "
      end
    }
    negativeResponse = lambda{
      if rand(2) == 0
        print "Boo! "
      else
        print "Take this tomato! "
      end
    }
    neutralResponse = lambda{
      print "Gasp! "
    }

    @observers.each do |o|
      o.update(offset, positiveResponse, negativeResponse, neutralResponse)
    end

    if @observers.length != 0
      puts ""
    end

  end

  def get_attributes()
    @attributes = [0,0,0,0]
    @attributes[0] = @baseAttributes[0]
    @attributes[1] = @baseAttributes[1]
    @attributes[2] = @baseAttributes[2]
    @attributes[3] = @baseAttributes[3]

    @attributes = @weapon.modifyAttributes(@attributes)
  end

  def update_health(offset)
    if rand(0..100) < @dodgeChance
      print "Gladiator " + @name[0]
      puts " dodged."
      offset = -999999
    end

    if rand(0..100) < @parryChance && offset != -999999
      print "Gladiator " + @name[0]
      puts " parried."
      offset = offset / 2
    end

    if offset < 0 && offset > -999999
      if @baseAttributes[0] + offset < 0
        @baseAttributes[0] = 0
        notify_observers(offset)
        die()
      else
        @baseAttributes[0] = @baseAttributes[0] + offset
        notify_observers(offset)
      end
    else
      if offset > 0
        notify_observers(offset)
        puts "Gladiator " + @name[0] + " is ticklish."
      else
        notify_observers(offset)
        puts "I'm right here."
      end
    end
  end

  def get_weapon
    @weapon
  end

  def die()
    @baseAttributes[0] = 0
    print "Gladiator " + @name[0]
    puts " died."
  end
end
