_iedNumber = _this select 0;
_origin = _this select 1;
_side = _this select 2;

_st = [] call GET_SIZE_AND_TYPE;
[_iedNumber, _origin, _st select 0, _st select 1, _side] spawn { call CREATE_IED; };