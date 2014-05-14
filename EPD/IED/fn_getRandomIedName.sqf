private["_letters","_name","_numberOfLettersToUse"];
_letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
_name = "";
_numberOfLettersToUse = 10;

for "_i" from 0 to _numberOfLettersToUse-1 do
{
	_name = _name + (_letters select floor random 26);
};
_name;