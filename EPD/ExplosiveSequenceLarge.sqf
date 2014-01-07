_iedPosition = _this select 0;
_ied = _this select 1;
_iedNumber = _this select 2;
_side = _this select 3;
_explosiveSequence = ["Bo_GBU12_LGB_MI10","M_Titan_AA_long","HelicopterExploSmall","M_Titan_AA_long", "M_PG_AT","M_Titan_AT"]; 

[[_iedPosition, _explosiveSequence, _ied, _iedNumber, _side], "INITIAL_EXPLOSION", false,false] spawn BIS_fnc_MP;