_unit = _this select 0;
_b = _this select 1;
_unit addAction ["Disarm", "IED\Disarm.sqf", ( _b), 0, false, true, "", '((_target distance _this) < 3) and ((items player) find "MineDetector" > -1)'];