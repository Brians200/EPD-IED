private["_sectionName","_iedName","_iedArray","_itemRequirement"];
waituntil{sleep .5; (!isnull player and iedsAdded)};

_sectionName = _this select 0;
_iedName = _this select 1;

_iedArray = [_sectionName, _iedName] call EpdIed_fnc_getIedArray;

_itemRequirement = "";
for "_i" from 0 to (count itemsRequiredToDisarm) -1 do{
	_itemRequirement = _itemRequirement + format[" and ((items player) find ""%1"" > -1)", itemsRequiredToDisarm select _i];
};

(_iedArray select 0) addAction [("<t color=""#27EE1F"">") + ("Disarm") + "</t>", EpdIed_fnc_disarmAction, [_iedArray,[_sectionName, _iedName]], 10, false, true, "", format["(_target distance _this < 3) %1", _itemRequirement]];