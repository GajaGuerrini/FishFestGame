extends Node3D

@export var WEAPON_RESORCES : Array[WeaponRes]
@export var START_WEAPON : Array[String]
var Current_weapon = null

var Weapon_Stack = [] # all the weapons
var Weapon_Indicator
var Next_weapon : String
var Weapon_List = {} # all og them

func _ready():
	Initialize(START_WEAPON) #enter state machine

func _input(event):
	if event.is_action_pressed("next_weapon"):
		Weapon_Indicator = min(Weapon_Indicator+1, Weapon_Stack.size()-1)
		exit(Weapon_Stack[Weapon_Indicator])

func Initialize(_start_weapons : Array):
	for weapon in WEAPON_RESORCES:
		Weapon_List[weapon.WEAPON_NAME] = weapon
	
	for i in _start_weapons:
		Weapon_Stack.push_back(i)
	
	Current_weapon = Weapon_List[Weapon_Stack[0]]
	enter()

func enter():
	# Animation_Player.queue(Current_weapon.Activate_anim)
	pass

func exit(_next_weapon: String):
	if _next_weapon != Current_weapon.WEAPON_NAME:
		Next_weapon = _next_weapon
		
func Change_weapon(weapon_name: String):
	Current_weapon = Weapon_List[weapon_name]
	Next_weapon = ""
	exit(Next_weapon)
	
