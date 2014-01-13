_placesToKeep = ["NameCityCapital","NameCity","NameVillage", "NameLocal"];
placesOfInterest = [];
_placesCfg = configFile >> "CfgWorlds" >> worldName >> "Names";
_counter = 0;
for "_i" from 0 to (count _placesCfg)-1 do
{
	_place = _placesCfg select _i;
	_name =	getText(_place >> "name");
	_sizeX = getNumber (_place >> "radiusA");
    _sizeY = getNumber (_place >> "radiusB");
	_avgSize = (_sizeX+_sizeY)/2;
	_position = getArray (_place >> "position");
	_type = getText(_place >> "type");
	if(_type in _placesToKeep) then
	{	
		placesOfInterest set [_counter, [_name, _position, _avgSize]];
		_counter = _counter + 1;
	};
};