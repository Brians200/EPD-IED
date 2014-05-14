//Event that happens when a projectile explosive or bullet hits the IED object
if(allowExplosiveToTriggerIEDs) then {	
	_hitEvent = _this select 0;
	_ied = _hitEvent select 0;
	_sectionName = _ied getVariable ["_sectionName", ""];
	_iedName = _ied getVariable ["_iedName", ""];
	_iedSize= _ied getVariable ["_iedSize", ""];
	
	//hint format["%1", _hitEvent select 6];
	_projectile =  _hitEvent select 6 select 4;
	
	_isExplosive = false;
	_isExplosiveBullet = false;
	
	{
		if(_projectile iskindof _x) then {
			_isExplosive = true;
		};
	} foreach ehExplosiveSuperClasses;
	
	if(! _isExplosive) then
	{
		_explosiveValue = getNumber(configfile >> "CfgAmmo" >> format["%1", _projectile] >> "explosive");
		if(_explosiveValue > 0) then {
			_isExplosiveBullet = true;
		};
	};
	
	{//smoke grenades.. chem lights.. ir strobes.. rocks..
		if(_projectile iskindof _x) then{
			_isExplosive = false;
			_isExplosiveBullet = false;
		}
	} foreach projectilesToIgnore;
	
	
	//hint format["projectile = %3\nexplosive = %1\nexbullet = %2", _isExplosive, _isExplosiveBullet,_projectile];
	if(_isExplosive || _isExplosiveBullet) then {
		_chance = 100;
			
		if(_projectile iskindof "GrenadeCore") then { _chance = 50; }; //grenade launcher
		
		if(_isExplosiveBullet) then {_chance = 40; };
		_r = 0;//random 100;
		if(EPD_IED_debug) then {hint format["random = %1\nmax to explode = %2\n%3",_r,_chance,_projectile];};
		if(_r < _chance) then {
			//if(!(isnull _ied) and !(isnull _trigger)) then {
				if(EPD_IED_debug) then { player sidechat format ["%1 triggered IED",_projectile]; };
				//call compile format["terminate pd_%2; [_iedPosition, _ied, _iedNumber] call EXPLOSIVESEQUENCE_%1", _iedSize, _iedNumber ];	
				_ied removeAllEventHandlers "HitPart";
				call compile format['["%2", "%3" ] call EpdIed_fnc_explosiveSequence%1', _iedSize, _sectionName,_iedName ];
			//};
		};
	};		
};