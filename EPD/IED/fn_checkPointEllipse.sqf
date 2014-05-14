//Checks if the point is within the given ellipse
private ["_angle","_sizeA","_sizeB","_ellipseCenter","_ellipseX","_ellipseY","_point","_pointX","_pointY","_left","_right"];
_angle = _this select 0;
_sizeA = _this select 1;
_sizeB = _this select 2;
_ellipseCenter = _this select 3;
_ellipseX = _ellipseCenter select 0;
_ellipseY = _ellipseCenter select 1;
_point = _this select 4;
_pointX = _point select 0;
_pointY = _point select 1;

//math

_left = (cos(_angle)*(_pointX - _ellipseX) + sin(_angle) * (_pointY - _ellipseY))/_sizeA;
_right = (sin(_angle)*(_pointX - _ellipseX) - cos(_angle) * (_pointY - _ellipseY))/_sizeB;

_left*_left + _right*_right <= 1;