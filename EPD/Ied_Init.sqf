/* Written by Brian Sweeney - [EPD] Brian*/

/***************SETTINGS***********************/
iedSmallItems = ["RoadCone_F","Land_Pallets_F","Land_WheelCart_F","Land_Tyre_F","Land_ButaneCanister_F","Land_Bucket_F","Land_GasCanister_F","Land_Pillow_F"];
	
iedMediumItems = ["Land_Portable_generator_F","Land_WoodenBox_F","Land_MetalBarrel_F","Land_BarrelEmpty_grey_F","Land_BarrelSand_grey_F","Land_BarrelTrash_grey_F","Land_BarrelWater_grey_F","Land_Sacks_heap_F","Land_WoodenLog_F","Land_WoodPile_F"];
	
iedLargeItems = ["Land_Bricks_V2_F","Land_Bricks_V3_F","Land_Bricks_V4_F","Land_GarbageBags_F","Land_GarbagePallet_F","Land_GarbageWashingMachine_F","Land_JunkPile_F","Land_Tyres_F","Land_Wreck_Skodovka_F","Land_Wreck_Car_F","Land_Wreck_Car3_F","Land_Wreck_Car2_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F"];
/***************END SETTINGS*******************/



IED_SMOKE = compile preprocessFileLineNumbers "EPD\IedSmoke.sqf";
IED_ROCKS = compile preprocessFileLineNumbers "EPD\IEDRocks.sqf";
Disarm = compile preprocessFileLineNumbers "EPD\disarmAddAction.sqf";

if(isserver) then {
	[[[	/*["IEDSINGLE1","West"],
		["IEDSINGLE2","West"],
		["IEDSINGLE3","West"],*/
		/*["Random1",6,"West"],
		["Random2",6,"West"],
		["Random3",6,"West"],
		["Random4",6,"West"],
		["Random5",6,"West"],
		["Random6",6,"West"],
		["Random7",6,"West"],
		["Random8",6,"West"],
		["Random9",6,"West"],
		["Random10",6,"West"],
		["Random11",6,"West"],
		["Random12",6,"West"],
		["Random13",6,"West"],
		["Random14",6,"West"],
		["Random15",6,"West"],
		["Random16",6,"West"],*/
		["Gravia", 45, "West" ],
		["Lakka", 2, "West" ]/*,
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
		["Selakano", 2, "West" ]*/
		],"EPD\Ied.sqf"],"BIS_fnc_execVM",false,false] spawn BIS_fnc_MP;
};