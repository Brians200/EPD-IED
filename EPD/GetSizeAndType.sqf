_size = "SMALL";
 r = floor random (smallChance+mediumChance+largeChance);
 if(r>smallChance) then {
	_size = "MEDIUM";
 };
 
 if(r>smallChance+mediumChance) then {
	_size = "LARGE";
 };

_type = "";
if(_size == "SMALL") then
{
	_type = iedSmallItems select(floor random(count iedSmallItems));
} else {
	if(_size == "MEDIUM") then
	{
		_type = iedMediumItems select(floor random(count iedMediumItems));
	} else { //large
		_type = iedLargeItems select(floor random(count iedLargeItems));
	};
};
[_size,_type];