/* original work from: Tankbuster */
/* adapted from:  Dynamic IED script by - Mantis -*/
/* Rewritten by Brian Sweeney - [EPD] Brian*/

if(!isserver) exitwith {};
if (isnil ("iedcounter")) then {iedcounter=0;} ;
if (isnil ("junkcounter")) then {junkcounter=0;} ;
	
ehExplosiveSuperClasses = ["RocketCore", "MissileCore", "SubmunitionCore", "GrenadeCore", "ShellCore"];
publicVariable "ehExplosiveSuperClasses";

explosiveSuperClasses = ["TimeBombCore","BombCore", "Grenade"];
publicVariable "explosiveSuperClasses";

explosiveBullets = ["B_20mm", "B_20mm_Tracer_Red", "B_30mm_HE", "B_30mm_HE_Tracer_Green", "B_30mm_HE_Tracer_Red", "B_30mm_HE_Tracer_Yellow", "B_30mm_MP", "B_30mm_MP_Tracer_Green", "B_30mm_MP_Tracer_Red", "B_30mm_MP_Tracer_Yellow", "B_35mm_AA", "B_35mm_AA_Tracer_Green", "B_35mm_AA_Tracer_Red", "B_35mm_AA_Tracer_Yellow", "B_40mm_GPR", "B_40mm_GPR_Tracer_Green", "B_40mm_GPR_Tracer_Red", "B_40mm_GPR_Tracer_Yellow"];
publicVariable "explosiveBullets";	

thingsToIgnore = ["SmokeShell", "FlareCore", "IRStrobeBase", "GrenadeHand_stone", "Smoke_120mm_AMOS_White", "TMR_R_DG32V_F"];
publicVariable "thingsToIgnore";

private["_paramArray", "_paramCounter"];

_paramCounter = 0;
_paramArray = _this;

while{_paramCounter < count _paramArray} do {

	_arr = _paramArray select _paramCounter;
	_paramCounter = _paramCounter + 1;
	
	//["marker", iedsToPlace, fakesToPlace, side]
	//["marker", amountToPlace, side]
	//["marker", side]
	//["predefinedLocation", side]
	//["predefinedLocation", amountToPlace, side];
	//["predefinedLocation", iedsToPlace, fakesToPlace, side];
	
	_origin = [0,0,0];
	_distance = [0,0,0];
	_cityIndex = -1;//_cityNames find (_arr select 0);
	for "_i" from 0 to (count predefinedLocations) -1 do{
		if(predefinedLocations select _i select 0 == _arr select 0) then {
			_cityIndex = _i;
			_i = (count predefinedLocations);
		};
	};
	
	
	if(_cityIndex > -1) then {
		_origin = predefinedLocations select _cityIndex select 1;
		_distance = predefinedLocations select _cityIndex select 2;
		
	} else {
		_origin = getmarkerpos (_arr select 0);
		if(hideIedMarker) then {
			(_arr select 0) setMarkerAlpha 0;
		};
		_size = getMarkerSize (_arr select 0);
		_distance = ((_size select 0) min (_size select 1));
	};
	
	if(not ([_origin,[0,0,0]] call BIS_fnc_areEqual)) then { //don't bother if the marker doesn't exist
		if(_distance > 1) then {
			_side = "";
			_iedsToPlace = 0;
			_junkToPlace = 0;
			if(count _arr == 2) then
			{
				_iedsToPlace = ceil (_distance / 100.0);
				_junkToPlace = _iedsToPlace;
				_side = _arr select 1;
			} else {
				if( count _arr == 3) then
				{
					_iedsToPlace = _arr select 1;
					_junkToPlace = _iedsToPlace;
					_side = _arr select 2;
				} else {
					_iedsToPlace = _arr select 1;
					_junkToPlace = _arr select 2;
					_side = _arr select 3;
				};
			};
			
			//prevent race condition...
			_iedc = iedcounter;
			_junkc = junkcounter;
			
			[[_origin, _distance, _side, _iedsToPlace, _junkToPlace, _iedc, _junkc], "CREATE_RANDOM_IEDS", false,false] spawn BIS_fnc_MP;
			iedcounter = iedcounter + _iedsToPlace;
			junkcounter = junkcounter + _junkToPlace;
		}
		else  //single IED exactly on the marker spot
		{
			_side = _arr select ((count _arr) -1); 
			
			//prevent race condition...
			_iedc = iedcounter;
			
			[[_iedc, _origin, _side], "CREATE_SPECIFIC_IED", false,false] spawn BIS_fnc_MP;
			iedcounter = iedcounter + 1;
		};
	};
};