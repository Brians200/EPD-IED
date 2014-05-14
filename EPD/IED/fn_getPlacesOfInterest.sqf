private["_placesToKeep","_cities","_villages","_locals","_placesCfg"];

_placesToKeep = ["NameCityCapital","NameCity","NameVillage", "NameLocal"];
_cities = ["NameCityCapital","NameCity"];
_villages = ["NameVillage"];
_locals = ["NameLocal"];

iedAllMapLocations = call Dictionary_fnc_new;
iedCityMapLocations = call Dictionary_fnc_new;
iedVillageMapLocations = call Dictionary_fnc_new;
iedLocalMapLocations = call Dictionary_fnc_new;

_placesCfg = configFile >> "CfgWorlds" >> worldName >> "Names";
for "_i" from 0 to (count _placesCfg)-1 do
{
	_place = _placesCfg select _i;
	_name =	 toUpper(getText(_place >> "name")); 
	_sizeA = getNumber (_place >> "radiusA");
	_sizeB = getNumber (_place >> "radiusB");
	_angle = -1*(getNumber (_place >> "angle"));
	_size = [_sizeA, _sizeB, _angle];
	_position = getArray (_place >> "position");
	_type = getText(_place >> "type");
	
	/*_markerName = format["f%1", _name];
	createmarker [_markerName, _position];
	_markerName setMarkerColorLocal "ColorRed";
	_markerName setMarkerShapeLocal "ELLIPSE";
	_markerName setMarkerSizeLocal [_sizeA, _sizeB];
	_markerName setMarkerDirLocal _angle;*/

	if(_type in _placesToKeep) then
	{	
		[iedAllMapLocations, _name , [_name, _position, _size]] call Dictionary_fnc_set;
	};
	if(_type in _cities) then
	{	
		[iedCityMapLocations, _name , [_name, _position, _size]] call Dictionary_fnc_set;
	};
	if(_type in _villages) then
	{	
		[iedVillageMapLocations, _name , [_name, _position, _size]] call Dictionary_fnc_set;
	};
	if(_type in _locals) then
	{	
		[iedLocalMapLocations, _name , [_name, _position, _size]] call Dictionary_fnc_set;
	};
};	