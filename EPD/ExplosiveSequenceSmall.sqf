_iedPosition = _this select 0;
_ied = _this select 1;
_iedNumber = _this select 2;
_side = _this select 3;
_explosiveSequence = ["M_PG_AT","M_Zephyr","M_Titan_AA_long","M_PG_AT"]; 

[_iedPosition, _explosiveSequence, _ied, _iedNumber, _side] spawn INITIAL_EXPLOSION;