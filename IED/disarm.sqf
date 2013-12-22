/* adapted from:  Dynamic IED script by - Mantis and MAD_T -*/

//private ["t_%1"];

t = (_this select 0);

_array_item = items player;
//[[[_unit], {(_this select 0) switchMove "AdvePercMstpSnonWnonDnon_godown";}], "BIS_fnc_call", nil, false, true] call BIS_fnc_MP;

//25% chance of it exploding if you don't have a toolkit
if ((_array_item find "ToolKit" > -1) or ((random 100) > 25)) then {

//player switchMove "AinvPknlMstpSlayWrflDnon_medic";
[[[player], {(_this select 0) switchMove "AinvPknlMstpSlayWrflDnon_medic";}], "BIS_fnc_call", nil, false, true] call BIS_fnc_MP;
sleep 5.5;
deletevehicle (_this select 3);
[[t],"removeAct", true, true] spawn BIS_fnc_MP;
hint "Disarmed!";

}

 else {

  
  player switchMove "AinvPknlMstpSlayWrflDnon_medic";
  sleep 2;
  "M_Mo_82mm_AT_LG" createVehicle (position t);
  "M_Mo_82mm_AT_LG" createVehicle (position t);
  "M_Mo_82mm_AT_LG" createVehicle (position t);
  deletevehicle (_this select 3);
  [[t],"removeAct", true, true] spawn BIS_fnc_MP;
  deletevehicle t;
  };
 
  