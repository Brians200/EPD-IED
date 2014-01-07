_ied = _this select 0;
_iedSize = _this select 1;
_iedPosition = _this select 2;
_side = _this select 3;
_trigger = _this select 4;
_iedNumber = _this select 5;

if(!allowExplosiveToTriggerIEDs) exitwith{};

hint format['%1 addEventHandler ["HitPart", {[_this, %1, "%2", %3, %6, "%4",%5] call EXPLOSION_EVENT_HANDLER;}];',_ied,_iedSize, _iedPosition, _side,_trigger,_iedNumber];

call compile format['%1 addEventHandler ["HitPart", {[_this, %1, "%2", %3, %6, "%4",%5] call EXPLOSION_EVENT_HANDLER;}];',_ied,_iedSize, _iedPosition, _side,_trigger,_iedNumber];