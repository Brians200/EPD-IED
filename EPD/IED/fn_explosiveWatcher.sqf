//Since explosions don't trigger any hit events for planted explosives and a few others for these items, we have to detect them a funky way

private["_isExplosive","_ammoToWatch","_ied","_iedSize","_class","_position","_sectionName","_iedName","_trigger"];

_isExplosive = false;
_ammoToWatch = _this select 0;
_ied = _this select 1;
_iedSize = _this select 2;
_class = _this select 3;
_position = _this select 4;
_sectionName = _this select 5;
_iedName = _this select 6;
_trigger = _this select 7;

{
	if(_class iskindof _x) then {
		_isExplosive = true;
	};
} foreach explosiveSuperClasses;

{//smoke grenades.. chem lights.. ir strobes.. rocks..
	if(_class iskindof _x) then{
		_isExplosive = false;
	}
} foreach projectilesToIgnore;

if(_isExplosive) then {
	_updateInterval = .1;
	_radiusSqr = 49;
	
	while{(alive _ammoToWatch) && !(isnull _ied)} do {
		_position = getpos _ammoToWatch;
		sleep _updateInterval;
	};
	
	_origin = getpos _ied;
	if(EPD_IED_debug) then {player sidechat format["distance = %1", (_origin distance _position)]; };
	if((_origin distancesqr _position < _radiusSqr) and !(isnull _ied)) then {
		_chance = 100; //since this handles mostly giant explosions. Bombs, planted satchels...
		if(_class iskindof "Grenade") then { _chance = 35; }; 
		
		_r = random 100;
		if(EPD_IED_debug) then {hint format["random = %1\nmax to explode = %2\n%3",_r,_chance,_class];};
		if(_r < _chance) then {
			if(EPD_IED_debug) then { player sidechat format ["%1 triggered IED",_class]; };
			if(!(isnull _ied)) then {
				_ied removeAllEventHandlers "HitPart";
				call compile format['["%2", "%3" ] call EpdIed_fnc_explosiveSequence%1', _iedSize, _sectionName,_iedName ];
			};
		};
	};		
};