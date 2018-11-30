class Arena
  def initialize
    raise NotImplementedError
  end

  def get_glad()
    initGlad = lambda{ |baseAttributes, name|
      puts "HP =?"
      baseAttributes[0] = (gets.chomp.to_i)*10
      if baseAttributes[0] <= 0
        puts "YOU'RE ALREADY DEAD."
        exit
      end
      puts "SPD =?"
      baseAttributes[1] = gets.chomp.to_i
      puts "STR =?"
      baseAttributes[2] = gets.chomp.to_i
      puts "INT =?"
      baseAttributes[3] = gets.chomp.to_i

      puts "Name = ?"
      name[0] = gets.chomp

      puts "Weapon?"
      puts "Katana = 1"
      puts "Gladius = 2"
      puts "Nagamaki = 3"
      puts "Staff = 4"
      @choice = gets.chomp.to_i
      if @choice == 1
        return  Katana.new()
      elsif @choice == 2
        return  Gladius.new()
      elsif @choice == 3
        return  Nagamaki.new()
      elsif @choice == 4
        return  Staff.new()
      else
        puts "Invalid choice. That weapon has not been invented."
        exit
      end
    }

    @player = Gladiator.new(initGlad)
    puts "Your HP =" + @player.get_attributes[0].to_s
    puts "Your SPD =" + @player.get_attributes[1].to_s
    puts "Your STR =" + @player.get_attributes[2].to_s
    puts "Your INT =" + @player.get_attributes[3].to_s
    @counter = 10

    while @counter > 0
      Audience.new(@player)
      @counter  = @counter - 1
    end
  end

  def fight()
    raise NotImplementedError
  end

  def set_enemy
    raise NotImplementedError
  end

  def print_enemy_stats
    raise NotImplementedError
  end

  def getExtraPlayer  #hook
  end
end

class OneOnOne < Arena
  def initialize
    puts "You're in an elevator with some other shady looking guy. He is chewing"
    puts "a gum loudly with his mouth open, you can hear every droplet of spit "
    puts "in his mouth. Slowly some nasty smell crawls up your nosetrils, a smell"
    puts "of fart. You know it wasn't you. You have neutralize this guy out before"
    puts "the smell knocks you out. All of a sudden you hear some people speak"
    puts "from the speaker of the elevator. 'Welcome to jackass!'"
    puts "\nArena : One on one battle! Defeat your opponent!"
    @player = nil
    @enemy = nil
    set_enemy()
    print_enemy_stats()
    get_glad()
    fight()
  end

  def set_enemy()
    setWizard = lambda{ |baseAttributes, name|
      baseAttributes[0] = 70
      baseAttributes[1] = 5
      baseAttributes[2] = 2
      baseAttributes[3] = 6

      return  Staff.new()
    }

    setAlonne = lambda{ |baseAttributes, name|
      baseAttributes[0] = 70
      baseAttributes[1] = 5
      baseAttributes[2] = 6
      baseAttributes[3] = 2


      return  Nagamaki.new()
    }

    setCenturion = lambda{|baseAttributes, name|
      baseAttributes[0] = 70
      baseAttributes[1] = 4
      baseAttributes[2] = 7
      baseAttributes[3] = 2

      return  Gladius.new()
    }
    setOrochi= lambda{|baseAttributes, name|
      baseAttributes[0] = 70
      baseAttributes[1] = 6
      baseAttributes[2] = 2
      baseAttributes[3] = 5

      return  Katana.new()
    }


    @val = rand(4)

    if @val == 0
      @enemySetter = setWizard
    elsif @val == 1
      @enemySetter = setAlonne
    elsif @val == 2
      @enemySetter = setCenturion
    else
      @enemySetter = setOrochi
    end

    @enemy = Gladiator.new(@enemySetter)
  end

  def print_enemy_stats()
    print "\nEnemy = "
    puts @enemy.get_weapon().get_wielder_type

    print  "Enemy HP = "
    puts @enemy.get_attributes[0]

    print  "Enemy SPD = "
    puts @enemy.get_attributes[1]

    print  "Enemy STR = "
    puts @enemy.get_attributes[2]

    print  "Enemy INT = "
    puts @enemy.get_attributes[3]
    puts ""
  end

  def fight()
    puts "\n\nFIGHT!"
    @damage1 = 0
    @damage2 = 0
    (1..3).each do |i|
      @damage1 = @damage1 - (@player.get_attributes[i]*@player.get_weapon.get_favored_stats[i])
      @damage2 = @damage2 - (@enemy.get_attributes[i]*@enemy.get_weapon.get_favored_stats[i])
    end

    while(@player.get_attributes[0] > 0 && @enemy.get_attributes[0] > 0)
      @player.update_health(@damage2)
      puts @player.get_name[0] + " HP = " +  @player.get_attributes[0].to_s
      @enemy.update_health(@damage1)
      puts @enemy.get_weapon.get_wielder_type + " HP = " +  @enemy.get_attributes[0].to_s
    end
    if @player.get_attributes[0] > 0
      puts "\n\nYOU WON!"
    else
      puts "\n\nYOU LOST!"
      puts "The enemy had " + @enemy.get_attributes[0].to_s + " HP left."
    end
    @player.remove_observers
    #@player.printObs
  end
end


class MinionFight < Arena
  def initialize
    puts "You're going on a vacation, luckily you were able to get in your "
    puts "plane early. When you sat down, seats around you were mostly empty."
    puts "Relieved, you think 'Good thing there are no annoying ass kids around.'"
    puts "Right then a telepathic kid floats in the air pointing its wretched"
    puts "finger at you. He yells 'GET HIM!'. The crew of the aircraft begin "
    puts "to cheer, you don't know for whom yet, but it gets your blood pumping!"

    puts"\nTo win, you must discover the right combination of stats. Good luck!"
    puts "\nArena : Minion Fight! Defeat the minions!"
    @player = nil
    @enemies = []
    set_enemy()
    print_enemy_stats()
    get_glad()
    fight()
  end

  def set_enemy
    @numOfMinions = rand(8..15)
    setMiniCent = lambda{|baseAttributes, name|
      baseAttributes[0] = 1
      baseAttributes[1] = 1
      baseAttributes[2] = 2
      baseAttributes[3] = 1

      return  Gladius.new()
    }

    setMiniWiz = lambda{|baseAttributes, name|
      baseAttributes[0] = 1
      baseAttributes[1] = 1
      baseAttributes[2] = 1
      baseAttributes[3] = 2

      return  Staff.new()
    }

    setMiniAl = lambda{|baseAttributes, name|
      baseAttributes[0] = 1
      baseAttributes[1] = 1
      baseAttributes[2] = -2
      baseAttributes[3] = 1

      return  Nagamaki.new()
    }

    setMiniOro= lambda{|baseAttributes, name|
      baseAttributes[0] = 1
      baseAttributes[1] = 2
      baseAttributes[2] = 1
      baseAttributes[3] = 1

      return  Katana.new()
    }

    (0..@numOfMinions).each do
      @val = rand(4)
      if @val == 1
        @enemySetter = setMiniOro
      elsif @val == 2
        @enemySetter = setMiniAl
      elsif @val == 3
        @enemySetter = setMiniWiz
      else
        @enemySetter = setMiniCent
      end

      @enemies << Gladiator.new(@enemySetter)
    end

  end

  def print_enemy_stats()
    print "\nNum Of Minions = "
    puts @enemies.length
  end

  def fight()
    puts "\n\nFIGHT!"
    @playerDamage = 0
    @enemyDamages = []

    (0...@enemies.length).each do
      @enemyDamages << 0
    end

    (1..3).each do |i|
      @playerDamage = @playerDamage - (@player.get_attributes[i]*@player.get_weapon.get_favored_stats[i])

      (0...@enemies.length).each do |counter|
        @enemyDamages[counter] = @enemyDamages[counter] - (@enemies[counter].get_attributes[i]*@enemies[counter].get_weapon.get_favored_stats[i])
      end
    end

    while(@player.get_attributes[0] > 0 )
      @numOfDeadEnemies = 0

      (0...@enemies.length).each do |i|
        if @enemies[i].get_attributes[0] == 0
          @numOfDeadEnemies = @numOfDeadEnemies + 1
          @deadMinions = @numOfDeadEnemies
          next
        end
        if @player.get_attributes[0] == 0
          next
        end
        @player.update_health(@enemyDamages[i])
        puts @player.get_name[0] + " HP = " +  @player.get_attributes[0].to_s
        @enemies[i].update_health(@playerDamage)
      end

      if @numOfDeadEnemies == @enemies.length
        break
      end
    end
    if @player.get_attributes[0] > 0
      puts "\n\nYOU WON!"
    else
      puts "\n\nYOU LOST!"
    end

    @player.remove_observers
    #@player.printObs
  end
end


class TagTeam < Arena
  def initialize
    puts "You decide to play monopoly with your friends. Luck has not been on"
    puts "anyone's side, everyone's completed a color set, set up their traps"
    puts "waiting for someone to roll the wrong die. The tension builds up with"
    puts "every roll until it becomes unbearable. All of you hit your fists on"
    puts "the table at the same time. There's no winner if everyone loses, you"
    puts "have to pick a teammate, and you have to do it quickly. Otherwise,"
    puts "it will be 2 vs 1, instead of 2 vs 2."
    puts "Seemingly lifeless figurines of monopoly come to life. They begin "
    puts "betting monopoly money on the teams."

    puts "\nArena : Tag Team! Choose an ally, fight your enemies!"
    @player = nil
    @player2 = nil
    @enemy1 = nil
    @enemy2 = nil
    set_enemy()
    set_enemy()
    print_enemy_stats()
    get_glad()

    @start = Time.now
    puts "YOU HAVE 10 SECONDS TO PICK YOUR TEAMMATE."
    getExtraPlayer()
    @finish = Time.now

    @duration = @finish - @start
    if @duration > 10
      puts "You took too long to decide. Your to be teammate fainted from stress."
      @player2.die()
    end
    fight()
  end

  def set_enemy()
    setWizard = lambda{ |baseAttributes, name|
      baseAttributes[0] = 70
      baseAttributes[1] = 5
      baseAttributes[2] = 2
      baseAttributes[3] = 6

      return  Staff.new()
    }

    setAlonne = lambda{ |baseAttributes, name|
      baseAttributes[0] = 70
      baseAttributes[1] = 5
      baseAttributes[2] = 6
      baseAttributes[3] = 2


      return  Nagamaki.new()
    }

    setCenturion = lambda{|baseAttributes, name|
      baseAttributes[0] = 70
      baseAttributes[1] = 4
      baseAttributes[2] = 7
      baseAttributes[3] = 2

      return  Gladius.new()
    }

    setOrochi= lambda{|baseAttributes, name|
      baseAttributes[0] = 70
      baseAttributes[1] = 6
      baseAttributes[2] = 2
      baseAttributes[3] = 5

      return  Katana.new()
    }
    @val = rand(3)

    if @val == 0
      @enemySetter = setWizard
    elsif @val == 1
      @enemySetter = setAlonne
    elsif @val == 2
      @enemySetter = setCenturion
    else
      @enemySetter = setOrochi
    end
    if @enemy1 == nil
      @enemy1 = Gladiator.new(@enemySetter)
    else
      @enemy2 = Gladiator.new(@enemySetter)
    end
  end

  def print_enemy_stats()
    print "\nEnemy1 = "
    puts @enemy1.get_weapon().get_wielder_type

    print  "Enemy1 HP = "
    puts @enemy1.get_attributes[0]

    print  "Enemy1 SPD = "
    puts @enemy1.get_attributes[1]

    print  "Enemy1 STR = "
    puts @enemy1.get_attributes[2]

    print  "Enemy1 INT = "
    puts @enemy1.get_attributes[3]

    print "\nEnemy2 = "
    puts @enemy2.get_weapon().get_wielder_type

    print  "Enemy2 HP = "
    puts @enemy2.get_attributes[0]

    print  "Enemy2 SPD = "
    puts @enemy2.get_attributes[1]

    print  "Enemy2 STR = "
    puts @enemy2.get_attributes[2]

    print  "Enemy2 INT = "
    puts @enemy2.get_attributes[3]
    puts ""
  end

  def getExtraPlayer
    initGlad = lambda{ |baseAttributes, name|
      puts "HP =?"
      baseAttributes[0] = (gets.chomp.to_i)*10
      puts "SPD =?"
      baseAttributes[1] = gets.chomp.to_i
      puts "STR =?"
      baseAttributes[2] = gets.chomp.to_i
      puts "INT =?"
      baseAttributes[3] = gets.chomp.to_i

      puts "Name = ?"
      name[0] = gets.chomp

      puts "Weapon?"
      puts "Katana = 1"
      puts "Gladius = 2"
      puts "Nagamaki = 3"
      @choice = gets.chomp.to_i
      if @choice == 1
        return  Katana.new()
      elsif @choice == 2
        return  Gladius.new()
      elsif @choice == 3
        return  Nagamaki.new()
      elsif @choice == 4
        return  Staff.new()
      end
    }

    @player2 = Gladiator.new(initGlad)
    puts "Friend HP =" + @player2.get_attributes[0].to_s
    puts "Friend SPD =" + @player2.get_attributes[1].to_s
    puts "Friend STR =" + @player2.get_attributes[2].to_s
    puts "Friend INT =" + @player2.get_attributes[3].to_s
    @counter = 10

    while @counter > 0
      Audience.new(@player2)
      @counter  = @counter - 1
    end
  end

  def fight()
    puts "\n\nFIGHT!"
    @player1Damage = 0
    @player2Damage = 0
    @enemy1Damage = 0
    @enemy2Damage = 0
    (1..3).each do |i|
      @player1Damage = @player1Damage - (@player.get_attributes[i]*@player.get_weapon.get_favored_stats[i])
      @player2Damage = @player2Damage - (@player2.get_attributes[i]*@player2.get_weapon.get_favored_stats[i])
      @enemy1Damage = @enemy1Damage - (@enemy1.get_attributes[i]*@enemy1.get_weapon.get_favored_stats[i])
      @enemy2Damage = @enemy2Damage - (@enemy2.get_attributes[i]*@enemy2.get_weapon.get_favored_stats[i])
    end

    if rand(2) == 0
      @allyTarget = @enemy1
    else
      @allyTarget = @enemy2
    end
    if rand(2) == 0
      @enemyTarget = @player
    else
      @enemyTarget = @player2
    end

    while(!((@player.get_attributes[0] == 0 && @player2.get_attributes[0] == 0) || (@enemy1.get_attributes[0] == 0 && @enemy2.get_attributes[0] == 0)))
      if(@allyTarget.get_attributes[0] <= 0)
        if @allyTarget == @enemy1
          @allyTarget = @enemy2
        else
          @allyTarget = @enemy1
        end
      end

      if(@enemyTarget.get_attributes[0] <= 0)
        if @enemyTarget == @player
          @enemyTarget = @player2
        else
          @enemyTarget = @player
        end
      end

      if @enemy1.get_attributes[0] > 0
        @enemyTarget.update_health(@enemy1Damage)
      end
      if @enemy2.get_attributes[0] > 0
        @enemyTarget.update_health(@enemy2Damage)
      end
      puts @enemyTarget.get_name[0] + " HP = " +  @enemyTarget.get_attributes[0].to_s

      if @player.get_attributes[0] > 0
        @allyTarget.update_health(@player1Damage)
      end
      if @player2.get_attributes[0]> 0
        @allyTarget.update_health(@player2Damage)
      end
      puts @allyTarget.get_weapon.get_wielder_type + " HP = " +  @allyTarget.get_attributes[0].to_s
    end

    if(@player.get_attributes[0] > 0 || @player2.get_attributes[0] > 0)
      puts "\n\nYOU WON!"
    else
      puts "\n\nYOU LOST!"
      puts "Enemy1 had " +@enemy1.get_attributes[0].to_s + " HP left."
      puts "Enemy2 had " +@enemy2.get_attributes[0].to_s + " HP left."
    end
    @player.remove_observers
    @player2.remove_observers

    #@player.printObs
    #@player2.printObs
  end
end



class MasterOfMirrors < Arena
  def initialize
    puts "*************************************************"
    puts "*SPOILERS FROM WITCHER 3 : HEARTS OF STONE BELOW*"
    puts "*************************************************\n\n"

    puts "                        ----SPOILERS BEGIN----"
    puts "  You're a witcher. You take up a contract sent out by a noble named"
    puts "Olgierd Von Everec to kill a Giant Toad who has been murdering people"
    puts "and dragging them into sewers. After killing the toad, it transforms"
    puts "into a person, who turns out to be a prince. The prince's guards"
    puts "capture you for execution. While imprisoned, a figure approaches"
    puts "you, tells you that he will help you escape, but in return, you must"
    puts "recover a debt from Olgierd Von Everec. The debt is, geralt must fulfill"
    puts "3 wishes of Everec. You accept, and the figure leaves a mark on your face."
    puts "  Everec tells you he wished immortality from the same mysterious figure"
    puts "who he reveals to be Gaunter O'Dimm. The toad you killed earlier was "
    puts "supposed to marry Olgierd's now long dead wife, so he traded his soul"
    puts "to turn him into a toad, become immortal, and to get 3 more wishes."
    puts "However Gaunter O'Dimm took away Olgierd's emotions, and gave him a "
    puts "heart of stone, which ruined his life. He warns you the same thing"
    puts "will happen to you unless you defeat Gaunter O'Dimm"
    puts "  You learn from ancient books that the only way to defeat him is to"
    puts "challenge him into a game of his own rules. And you do so, he sends you"
    puts "into a nightmare. On every corner is another demon charging at you."
    puts "The last one reveals to be O'Dimm himself"
    puts "                        ----SPOILERS END----"

    puts "\nArena : Master Of Mirrors. Are you well rounded enough?"
    @player = nil
    @enemy = nil
    @questions = []
    @answers = []
    set_enemy()
    print_enemy_stats()
    get_glad()
    @detlaffDamage = @player.get_attributes[0]/3 + 1
    set_riddles()
    fight()
  end

  def set_enemy()
    setDetlaff = lambda{ |baseAttributes, name|
      baseAttributes[0] = 1000
      baseAttributes[1] = 7
      baseAttributes[2] = 15
      baseAttributes[3] = 2
      @timeLimit = 3;

      return  Claws.new()
    }

    @enemy = Gladiator.new(setDetlaff)
  end

  def print_enemy_stats()
    print "\nEnemy = "
    puts "Master Of Mirrors"

    print  "Enemy HP = "
    puts @enemy.get_attributes[0]

    print  "Enemy SPD = "
    puts @enemy.get_attributes[1]

    print  "Enemy STR = "
    puts @enemy.get_attributes[2]

    print  "Enemy INT = "
    puts @enemy.get_attributes[3]
  end

  def set_riddles()
    if @player.get_attributes[1] > 10
      @timeLimit = @timeLimit*2
    elsif @player.get_attributes[1] > 5
      @timeLimit = @timeLimit * 1.5
    else
      @timeLimit = @timeLimit   #added for clarity only, this line is meaningless
    end

    if @player.get_attributes[3] > 10
      @questions << "
                      What is my weapon?
                    "
      @answers << "claws"
      @questions << "
                      What is my name?
                    "
      @answers << "god"
      @questions << "
                      Who are you?
                    "
      @answers << @player.get_name[0]
      puts @answers[2]
    elsif @player.get_attributes[3] > 5
      @questions << "
                      The more you take, the more you leave behind.\nWhat am I?
                    "
      @answers << "footsteps"
      @questions << "
                      I'm tall when I'm young, I'm short when I'm old.\nWhat am I?
                    "
      @answers << "candle"
      @questions << "
                      Feed me and I live, quench my thirst and I die.\nWhat an I?
                    "
      @answers << "fire"
    else
      @questions << "
                      To all things and men I appertein,
                      and yet by some am shunned and distained.
                      Fondle me and ogle me til you're insane,
                      but no blow can harm me, cause me pain.
                      Children take delight in me, elders take fright.
                      Fair maids rejoice and spin.
                      Cry and I weep, yawn and I sleep.
                      Smile, and I too shall grin.
                      What am I?
                    "
      @answers << "mirror"
      @questions << "
                      I kill kings, make mountains crumble.
                      Take lives and hand to another.
                      What am I?
                    "
      @answers << "time"
      @questions << "
                      I'm among the most unwelcome guests,
                      I crash whichever home I like best,
                      am known as a dirty reveler.
                      Though, I am an innocent traveler.
                      What am I?
                    "
      @answers << "meteor"
    end



  end

  def defend(att_pattern, def_pattern, duration)
    @temp = []
    att_pattern.each do |arrow|
      if arrow == "<"
        @temp << ">"
      elsif arrow == "^"
        @temp << "^"
      elsif arrow == ">"
        @temp << "<"
      end
    end

    if @temp[0]+@temp[1]+@temp[2] != def_pattern || duration > @timeLimit
      puts "Got hit"
      @player.detlaff_hit(-@detlaffDamage)
      @enemy.detlaff_heal(@detlaffDamage)
      return false
    else
      puts "Defended"
      return true
    end
  end

  def fight()
    puts "
                      YOU'LL SEE O'DIMM'S ATTACK. PERFORM AN ATTACK
                      IN REVERSE ORDER OF HIS TO DEFEND.

                      YOUR TIME TO DEFEND EACH ATTACK IS %d SECONDS

                      FIGHT STARTS IN 5 SECONDS...
         " %[@timeLimit]
    sleep(5)
    puts "\n\nFIGHT!"
    (0..2).each do
      @attacks = []
      (0..2).each do
        @val = rand(3)
        if @val == 0
          @attacks << "<"
        elsif @val == 1
          @attacks << "^"
        else
          @attacks << ">"
        end
      end

      puts "INCOMING ATTACK : " + @attacks[0] + @attacks[1] + @attacks[2]

      @start = Time.now
      @defense = gets.chomp()
      @finish =Time.now


      defend(@attacks, @defense, @finish - @start)
      if(@player.get_attributes[0] == 0)
        puts "YOU LOST"
        return
      end
    end

    puts "\nAfter you defend against all the incoming attacks from O'Dimm he vanishes"
    puts "with a laughter. The mirror in front of you reflects words written in"
    puts "burning charcoal. They seem to be riddles."

    (0...@questions.length).each do |i|
      puts @questions[i]
      if @player.get_attributes[0] == 0
        puts "YOU LOST"
        return
      end
      if gets.chomp == @answers[i]
        puts "correct!"
        @enemy.detlaff_hit(-300)
      else
        puts "Wrong. You lose blood. "
        puts "ANSWER = " + @answers[i].to_s
        @player.detlaff_hit(-@detlaffDamage)
        @enemy.detlaff_heal(@detlaffDamage)
      end
    end


    @damage1 = 0
    @damage2 = 0
    (1..3).each do |i|
      @damage1 = @damage1 - (@player.get_attributes[i]*@player.get_weapon.get_favored_stats[i])
      @damage2 = @damage2 - (@enemy.get_attributes[i]*@enemy.get_weapon.get_favored_stats[i])
    end
    @damage1 = @damage1 * 5

    while(@player.get_attributes[0] > 0 && @enemy.get_attributes[0] > 0)
      @player.update_health(@damage2)
      puts @player.get_name[0] + " HP = " +  @player.get_attributes[0].to_s
      @enemy.update_health(@damage1)
      puts "O'Dimm HP = " +  @enemy.get_attributes[0].to_s
    end
    if @player.get_attributes[0] > 0
      puts "\n\nYOU WON!"
      puts "You released Everec from his immortality, for which he thanked you,"
      puts "and gifted you his family sword. Saying he won't be needing it anymore."
      puts "Even though you refuse, he asks you to take it, for saving him from"
      puts "immortality. The mark on your face disappears, O'Dimm gets incinerated."
      puts "While burning and turning into a more demonic figure, he claps, as if"
      puts "he is congratulating you for your victory, slowly turning into ashes."
    else
      puts "\n\nYOU LOST!"
      puts "O'Dimm had " + @enemy.get_attributes[0].to_s + " HP left."
    end
    @player.remove_observers
  end
end
