/* Written by Brian Sweeney - [EPD] Brian*/

/***************SETTINGS***********************/
debug = false;
hideIedMarker = true;  //sets the alpha to 0 after spawning IEDs there

itemsRequiredToDisarm = ["ToolKit"];   //"MineDetector" or "ToolKit" for example
betterDisarmers = ["B_soldier_exp_F", "B_engineer_F", "B_diver_exp_F", "B_recon_exp_F"]; // people who are better at disarming

baseDisarmChance = 75; //how well everybody can disarm
bonusDisarmChance = 20; //increase that the "betterDisarmers" get

secondaryChance = 50; //Chance that a secondary IED will spawn.

smallChance = 40; //Chance that a small IED will be chosen.
mediumChance = 40; //Chance that a medium IED will be chosen.
largeChance = 20; //Chance that a medium IED will be chosen.

iedSecondaryItems = ["Land_CanisterOil_F","Land_FMradio_F","Land_Canteen_F","Land_CerealsBox_F","Land_BottlePlastic_V1_F","Land_HandyCam_F","Land_PowderedMilk_F","Land_RiceBox_F","Land_TacticalBacon_F","Land_VitaminBottle_F","Land_BottlePlastic_V2_F"];

iedSmallItems = ["RoadCone_F","Land_Pallets_F","Land_WheelCart_F","Land_Tyre_F","Land_ButaneCanister_F","Land_Bucket_F","Land_GasCanister_F","Land_Pillow_F"];
	
iedMediumItems = ["Land_Portable_generator_F","Land_WoodenBox_F","Land_MetalBarrel_F","Land_BarrelTrash_grey_F","Land_Sacks_heap_F","Land_WoodenLog_F","Land_WoodPile_F"];
	
iedLargeItems = ["Land_Bricks_V2_F","Land_Bricks_V3_F","Land_Bricks_V4_F","Land_GarbageBags_F","Land_GarbagePallet_F","Land_GarbageWashingMachine_F","Land_JunkPile_F","Land_Tyres_F","Land_Wreck_Skodovka_F","Land_Wreck_Car_F","Land_Wreck_Car3_F","Land_Wreck_Car2_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F"];

//If you want to use locations without making markers on the map, define them here. Altis has been provided as an example
//["Name",[LocationX,LocationY,LocationZ],size]
predefinedLocations = [["Gravia",[14491.1,17636.8,0],350],["Lakka",[12342.6,15682.6],350],["OreoKastro",[4557.53,21387.7,0],250],["Abdera",[9420.76,20252.7,0],150],["Galati",[10326.3,19055.6,0],150],["Syrta",[8634.13,18270.7,0],150],["Kore",[7144.03,16455.2,0],300],["Negades",[4895.13,16168.9,0],150],["Aggeochori",[3808.9,13694.7,0],500],["Kavala",[3543.03,13008.2,0],500],["Panochori",[5086.4,11263,0],350],["Zaros",[9197.17,11925.5,0],350],["Therisa",[10666.3,12270.4,0],250],["Poliakko",[10983.5,13424.3,0],250],["Alikampos",[11133,14561,0],250],["Neochori",[12501.5,14328.7,0],350],["Stravos",[12946.5,15057.3,0],250],["Agios Dionysios",[9358.66,15885.8,0],450],["Athira",[14022.3,18716.3,0],400],["Frini",[14615.4,20775.9,0],250],["Rodopoli",[18779.8,16643.9,0],350],["Paros",[20951.5,16958.9,0],450],["Kalochori",[21384.8,16362.2,0],250],["Sofia",[25702.1,21355.8,0],350],["Molos",[27033.2,23242.4,0],250],["Charkia",[18114.4,15241,0],400],["Pyrgos",[16828,12662.2,0],500],["Dorida",[19399,13251.5,0],250],["Chalkiea",[20250.4,11673.7,0],400],["Panagia",[20511.7,8867.04,0],250],["Feres",[21700.7,7576.93,0],350],["Selakano",[20803,6730.63,0],350],["AltisRandom1",[4941.03,20430.1,0],2000],["AltisRandom2",[5796.45,16578.8,0],2000],["AltisRandom3",[5435.57,12633.9,0],2000],["AltisRandom4",[9579.01,20978.4,0],2000],["AltisRandom5",[10020.1,16859.6,0],2000],["AltisRandom6",[9779.5,12901.4,0],2000],["AltisRandom7",[13749.2,21392.9,0],2000],["AltisRandom8",[13048.1,18153.4,0],2000],["AltisRandom9",[17677.8,17309.3,0],2000],["AltisRandom10",[26097.5,22777.3,0],2000],["AltisRandom11",[23259.9,19904.4,0],2000],["AltisRandom12",[21356.9,17014.4,0],2000],["AltisRandom13",[19267,13716.4,0],2000],["AltisRandom14",[17033.2,10641.5,0],2000],["AltisRandom15",[20342.5,8704.69,0],2000],["AltisRandom16",[11108.5,8551.36,0],2000]];

/***************EXPERIMENTAL***********************/
// This is still being worked on and may contain bugs, please report them on the forums.
allowExplosiveToTriggerIEDs = true; 

/***************END SETTINGS*******************/



IED_SMOKE = compile preprocessFileLineNumbers "EPD\IedSmoke.sqf";
IED_ROCKS = compile preprocessFileLineNumbers "EPD\IEDRocks.sqf";
Disarm = compile preprocessFileLineNumbers "EPD\disarmAddAction.sqf";

//These are the actual IEDs that will spawn. Add them using one of the following formats.
//["marker", iedsToPlace, fakesToPlace, side]
//["marker", amountToPlace, side]
//["marker", side]
//["predefinedLocation", side]
//["predefinedLocation", amountToPlace, side];
//["predefinedLocation", iedsToPlace, fakesToPlace, side];
if(isserver) then {
	[[[	["IEDSINGLE1","West"],
		["IEDSINGLE2","West"],
		["IEDSINGLE3","West"],
		["AltisRandom1",6,"West"],
		["AltisRandom2",6,"West"],
		["AltisRandom3",6,"West"],
		["AltisRandom4",6,"West"],
		["AltisRandom5",6,"West"],
		["AltisRandom6",6,"West"],
		["AltisRandom7",6,"West"],
		["AltisRandom8",6,"West"],
		["AltisRandom9",6,"West"],
		["AltisRandom10",6,"West"],
		["AltisRandom11",6,"West"],
		["AltisRandom12",6,"West"],
		["AltisRandom13",6,"West"],
		["AltisRandom14",6,"West"],
		["AltisRandom15",6,"West"],
		["AltisRandom16",6,"West"],
		["Gravia", 25, 0, "West" ],
		["Lakka", 2, 8, "West" ],
		["OreoKastro", 2, "West"],
		["Abdera", 2, "West" ],
		["Galati", 2, "West" ],
		["Syrta", 3, "West" ],
		["Kore", 2, "West" ],
		["Negades", 2, "West" ],
		["Aggeochori", 4, "West" ],
		["Kavala", 4, "West" ],
		["Panochori", 3, "West" ],
		["Zaros", 3, "West" ],
		["Therisa", 3, "West"],
		["Poliakko", 3, "West" ],
		["Alikampos", 3, "West" ],
		["Neochori", 4, "West" ],
		["Stravos", 3, "West" ],
		["Agios Dionysios", 3, "West" ],
		["Athira", 4, "West" ],
		["Frini", 2, "West" ],
		["Rodopoli", 3, "West" ],
		["Paros", 4, "West" ],
		["Kalochori", 3, "West" ],
		["Sofia", 3, "West" ],
		["Molos", 2, "West" ],
		["Charkia", 3, "West" ],
		["Pyrgos", 2, "West" ],
		["Dorida", 2, "West" ],
		["Chalkiea", 3, "West" ],
		["Panagia", 2, "West" ],
		["Feres", 2, "West" ],
		["Selakano", 2, "West" ]
		],"EPD\Ied.sqf"],"BIS_fnc_execVM",false,false] spawn BIS_fnc_MP;
};
