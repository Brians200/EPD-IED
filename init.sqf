iedcounter = 0;
Disarm = {
     _unit = _this select 0;
	 _b = _this select 1;
	 _unit addAction ["Disarm", "IED\Disarm.sqf", ( _b), 0, false, true, "", '((_target distance _this) < 3) and ((items player) find "MineDetector" > -1)'];
	 
};		 
removeAct = {
 _unit = _this select 0;
 _unit removeaction 0;
 };
//BIS_Effects_Burn=compile preprocessFileLineNumbers "\ca\Data\ParticleEffects\SCRIPTS\destruction\burn.sqf";
if(isServer) then
{
	[[[	/*["Random1",6,"West"],
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
		["Gravia", 35, "West" ]/*,
		["Lakka", 2, "West" ],
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
		],"IED\Ied.sqf"],"BIS_fnc_execVM",true,true] spawn BIS_fnc_MP;

};