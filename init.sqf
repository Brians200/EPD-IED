[] spawn {call compile preprocessFileLineNumbers "EPD\Ied_Init.sqf";};

if(isserver) then {
	sleep 60;
	_sectionName = [["Gravia",10,5,"West"]] call CREATE_IED_SECTION;
	hint format["%1 created", _sectionName];
	
	/*sleep 15;
	_sectionName call REMOVE_IED_SECTION;
	hint format["%1 removed", _sectionName];*/
};