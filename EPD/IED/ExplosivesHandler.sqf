PROJECTILE_DETECTION = {
	//http://forums.bistudio.com/showthread.php?170903-How-do-you-find-out-what-type-of-explosive-hit-an-object
	//Detects projectiles that go near this object

	if(allowExplosiveToTriggerIEDs) then {
		_range = 35;
		_ied = _this select 0;
		_iedNumber = _this select 1;
		_iedSize = _this select 2;
		_trigger = _this select 3;

		_fired = [];
		while {alive _ied} do 
		{
			_list = (position _ied) nearObjects ["Default",_range]; //Default = superclass of ammo

			if (count _list >=1) then 
			{
				_ammo = _list select 0;

				if (!(_ammo in _fired)) then
				{
					[_ammo, _ied, _trigger, _iedSize, typeof _ammo, getpos _ammo, _iedNumber ] spawn EXPLOSION_WATCHER;
					_fired = _fired + [_ammo];
				};
			};
			sleep 0.1;
			//remove dead projectiles
			_fired = _fired - [objNull];
		};
	};
};

EXPLOSION_WATCHER = {
	//watch projectiles that passed by these and sees if they are explosives and if they are close enough to set off the IED

	_isExplosive = false;
	_item = _this select 0;
	_class = _this select 4;
	_position = _this select 5;

	{
		if(_class iskindof _x) then {
			_isExplosive = true;
		};
	} foreach explosiveSuperClasses;

	{//smoke grenades.. chem lights.. ir strobes.. rocks..
		if(_class iskindof _x) then{
			_isExplosive = false;
		}
	} foreach thingsToIgnore;

	if(_isExplosive) then {
		_updateInterval = .1;
		_radius = 49;		
		_ied = _this select 1;
		_trigger = _this select 2;
		
		while {(alive _item) and !(isnull _ied) and !(isnull _trigger)} do {
			_position = getpos _item;
			sleep _updateInterval;
		};
		
		_origin = getpos (_this select 1);
		
		if(EPD_IED_debug) then {player sidechat format["distance = %1", (_origin distance _position)]; };
		if((_origin distancesqr _position < _radius) and !(isnull _ied) and !(isnull _trigger)) then {
			_chance = 100;
			if(_class iskindof "Grenade") then { _chance = 35; };
			
			_r = random 100;
			if(EPD_IED_debug) then {hint format["random = %1\nmax to explode = %2\n%3",_r,_chance,_class];};
			if(_r < _chance) then {
				_iedNumber = _this select 6;
				_iedSize = _this select 3;
				if(EPD_IED_debug) then { player sidechat format ["%1 triggered IED",_class]; };
				if(!(isnull _ied)) then {
					_ied removeAllEventHandlers "HitPart";
					call compile format["terminate pd_%2; [_origin, _ied, _iedNumber] call EXPLOSIVESEQUENCE_%1", _iedSize, _iedNumber ];
					deleteVehicle _ied;
					deleteVehicle _trigger;
				};
			};
		};
	};
};

EXPLOSION_EVENT_HANDLER = {
	if(allowExplosiveToTriggerIEDs) then {

		_ied = _this select 1;
		_trigger = _this select 5;	
		if((isnull _ied) or (isnull _trigger)) exitwith{};

		_iedSize = _this select 2; 
		_iedPosition = _this select 3;
		_iedNumber = _this select 4;

		_projectile =  _this select 0 select 0 select 6 select 4;
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
		} foreach thingsToIgnore;

		//hint format["projectile = %3\nexplosive = %1\nexbullet = %2", _isExplosive, _isExplosiveBullet,_projectile];
		if(_isExplosive || _isExplosiveBullet) then {
			_chance = 100;
				
			if(_projectile iskindof "GrenadeCore") then { _chance = 50; };
			if(_isExplosiveBullet) then {_chance = 40; };
			
			_r = random 100;
			if(EPD_IED_debug) then {hint format["random = %1\nmax to explode = %2\n%3",_r,_chance,_projectile];};
			if(_r < _chance) then {
				if(!(isnull _ied) and !(isnull _trigger)) then {
					
					if(EPD_IED_debug) then { player sidechat format ["%1 triggered IED",_projectile]; };
					eventHandlers set [_iedNumber, compile "true;"];
					publicVariable "eventHandlers";
					call compile format["terminate pd_%2; [_iedPosition, _ied, _iedNumber] call EXPLOSIVESEQUENCE_%1", _iedSize, _iedNumber ];	
					_ied removeAllEventHandlers "HitPart";
					deleteVehicle _ied;
					deleteVehicle _trigger;
				};
			};
		};
	};
};

EXPLOSION_EVENT_HANDLER_ADDER = {
	_ied = _this select 0;
	_iedSize = _this select 1;
	_iedPosition = _this select 2;
	_trigger = _this select 3;
	_iedNumber = _this select 4;

	//if(EPD_IED_debug) then {player sidechat format["synching %1 and %2", compile _trigger, compile _ied];};

	call compile format['%1 addEventHandler ["HitPart", {[_this, %1, "%2", %3, %5,%4] call EXPLOSION_EVENT_HANDLER;}];',_ied,_iedSize, _iedPosition, _trigger,_iedNumber];
};

SECONDARY_EVENT_ADDER = {
	_code = _this select 0;
	call compile _code;
};