/* adapted from:  Dynamic IED script by - Mantis and MAD_T -*/

//private ["t_%1"];

t = (_this select 0);

_array_item = items player;


//25% chance of it exploding if you don't have a toolkit
if ((_array_item find "ToolKit" > -1) or ((random 100) > 25)) then {

//player switchMove "AinvPknlMstpSlayWrflDnon_medic";
[[[player], {(_this select 0) switchMove "AinvPknlMstpSlayWrflDnon_medic";}], "BIS_fnc_call", nil, false, true] call BIS_fnc_MP;
disableUserInput true;
sleep 6;
disableUserInput false;
deletevehicle (_this select 3);
[[t],"removeAct", true, true] spawn BIS_fnc_MP;
hint "Disarmed!";

}

 else {

  
player switchMove "AinvPknlMstpSlayWrflDnon_medic";
disableUserInput true;
sleep 2;
disableUserInput false;
"M_Mo_82mm_AT_LG" createVehicle (position t);
"M_Mo_82mm_AT_LG" createVehicle (position t);
"M_Mo_82mm_AT_LG" createVehicle (position t);
deletevehicle (_this select 3);
[[t],"removeAct", true, true] spawn BIS_fnc_MP;
deletevehicle t;
};
 
  
removeAct = {
 _unit = _this select 0;
 _unit removeaction 0;
};