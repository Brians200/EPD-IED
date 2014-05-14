private["_junkPosition","_junkType","_sectionDictionary","_fakesDictionary","_junk","_fakeName","_markerName"];
_junkPosition = _this select 0;
_junkType = _this select 1;
_sectionDictionary = _this select 2;
_fakesDictionary = [_sectionDictionary, "fake"] call Dictionary_fnc_get;

_junk = _junkType createVehicle _junkPosition;
_junk setdir(random 360);
_junk setPos _junkPosition;
_junk enableSimulation false;
_junk allowDamage false;

_fakeName = call EpdIed_fnc_getRandomIedName;
_markerName = "fake"+_fakeName;
[_fakesDictionary, _fakeName, [_junk, _markerName]] call Dictionary_fnc_set;

if(EPD_IED_debug) then {			
	createmarker [_markerName, _junkPosition];
	_markerName setMarkerTypeLocal "hd_warning";
	_markerName setMarkerColorLocal "ColorBlue";
	_markerName setMarkerTextLocal "fake";
};