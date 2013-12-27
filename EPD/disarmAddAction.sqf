/* adapted from:  Dynamic IED script by - Mantis and MAD_T -*/
/* Rewritten by Brian Sweeney - [EPD] Brian*/
_unit = _this select 0;
_b = _this select 1;
_unit addAction ["Disarm", "EPD\Disarm.sqf", ( _b), 0, false, true, "", '((_target distance _this) < 3) and ((items player) find "MineDetector" > -1)'];