//Since explosions don't trigger any hit events for these items, we have to detect them a funky way
//http://forums.bistudio.com/showthread.php?170903-How-do-you-find-out-what-type-of-explosive-hit-an-object
//Detects projectiles that go near this object

if(allowExplosiveToTriggerIEDs) then {
	_range = 35;
	_ied = _this select 0;
	_sectionName = _this select 1;
	_iedName = _this select 2;
	_iedSize = _this select 3;
	
	_fired = [];
	while {alive _ied} do 
	{
		_nearProjectiles = (position _ied) nearObjects ["Default",_range]; //Default = superclass of ammo
		if (count _nearProjectiles >=1) then 
		{
			_ammo = _nearProjectiles select 0;
			if (!(_ammo in _fired)) then
			{
				[_ammo, _ied, _iedSize, typeof _ammo, getpos _ammo, _sectionName, _iedName] spawn EpdIed_fnc_explosiveWatcher;
				_fired = _fired + [_ammo];
			};
			
		};
		sleep 0.1;
		_fired = _fired - [objNull]; //remove dead projectiles
	};
};