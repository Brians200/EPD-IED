private["_smallChance","_mediumChance","_largeChance","_size","_r","_type"];

_smallChance = 0;
_mediumChance = 0;
_largeChance = 0;

if( typename _this == "ARRAY") then {
	_smallChance = _this select 0;
	_mediumChance = _this select 1;
	_largeChance = _this select 2;
} else {
	_smallChance = smallChance;
	_mediumChance = mediumChance;
	_largeChance = largeChance;
};

_size = "SMALL";
 _r = floor random (_smallChance+_mediumChance+_largeChance);
 if(_r>_smallChance) then {
	_size = "MEDIUM";
 };
 
 if(_r>_smallChance+_mediumChance) then {
	_size = "LARGE";
 };

_type = "";
if(_size == "SMALL") then
{
	_type = iedSmallItems select(floor random(iedSmallItemsCount));
} else {
	if(_size == "MEDIUM") then
	{
		_type = iedMediumItems select(floor random(iedMediumItemsCount));
	} else { //large
		_type = iedLargeItems select(floor random(iedLargeItemsCount));
	};
};
[_size,_type];