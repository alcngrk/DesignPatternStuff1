require './arena.rb'
require './audience.rb'
require './gladiator.rb'
require './weapons.rb'

def main

  puts "The game requires strategy. Every weapon type has its favored attribute."
  puts "SPD affects dodge and parry chances, INT affects only parry chance."
  puts "Dodging is harder than parrying, however you take no damage if you succeed."
  puts "Parrying is easier than dodging, but you take half the damage."
  puts "STR has a special weapon that affects its favored stat more than the "
  puts "others. However it does not affect dodge or parry. See the weapons.rb"
  puts "file for more details."
  puts "\nEvery arena type has its own difficulty."
  puts "On ONE ON ONE, the enemies are at least as strong as you, and have the right"
  puts "stat type of weapon selected."
  puts "Hint : Choose the right weapon."
  puts "\nOn MINION FIGHT, the enemies outnumber you greatly, they deal a little"
  puts "less than half the normal damage. "
  puts "\nOn TAG TEAM, it is a 2 vs 2 fight. You pick 2 characters for yourself."
  puts "Hint : Try picking 2 different characters in case one of them gets "
  puts "countered.\n"
  puts "\nOn MASTER OF MIRRORS, you will be asked to defend against an attack"
  puts "pattern, solve riddles, and the rest will be a One on One fight, depending"
  puts "on how well you did on the previous tasks, and if you survived of course\n."

  puts "RULES: \nYour character's stats can not exceed 20."
  puts "If you dump all of your stats into HP you will deal no damage."
  puts "You do not have to spend all 20 of your stat points."
  puts ""



  @testArena1 = OneOnOne.new()
  @testArena2 = MinionFight.new()
  @testArena3 = TagTeam.new()
  @testArena4 = MasterOfMirrors.new()
end


main
