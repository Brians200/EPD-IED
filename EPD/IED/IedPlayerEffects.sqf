//http://forums.bistudio.com/showthread.php?172864-Any-idea-how-this-was-done
_iedPos = _this select 0;
sleep 0.25;
if(alive player) then {
	_distance = (getpos player) distance _iedPOS;
	if(_distance < 75) then {
		0.5 fadeSound 0.2;
		playSound3d["A3\Missions_F_EPA\data\sounds\combat_deafness.wss", player];
		[] spawn {
			sleep 0.5;
			15 fadeSound 1;
		};
	};
	if(_distance < 40) then {
		[] spawn {	
			private ["_blur"];
			_blur = ppEffectCreate ["DynamicBlur", 474];
			_blur ppEffectEnable true;
			_blur ppEffectAdjust [0];
			_blur ppEffectCommit 0;
			
			waitUntil {ppEffectCommitted _blur};
			
			_blur ppEffectAdjust [10];
			_blur ppEffectCommit 0;
			
			//titleCut ["", "WHITE IN", 5];
			
			_blur ppEffectAdjust [0];
			_blur ppEffectCommit 5;
			
			waitUntil {ppEffectCommitted _blur};
			
			_blur ppEffectEnable false;
			ppEffectDestroy _blur;
		};
	};
};