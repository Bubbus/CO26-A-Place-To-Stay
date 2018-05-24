#define DELAY_DEFAULT 1.5
#define SPEED_DEFAULT 1

// Fetch the parameters
params [
	["_target", objNull, [objNull]],
	["_dist", 3, [3]],
	["_delay", DELAY_DEFAULT, [DELAY_DEFAULT, []]],
	["_speed", SPEED_DEFAULT, [SPEED_DEFAULT, []]]
];

if (!alive _target) exitWith {};





// Define some constants
private _delayMin = _delay;
private _delayMax = _delay;
private _speedMin = _speed;
private _speedMax = _speed;
private _startPos = getPosWorld _target;
private _ticksPerSec = 60;
private _vectorRight = (vectorDir _target) vectorCrossProduct (vectorUp _target);

// Validate delay input
switch (typeName _delay) do {
	case (typeName 0): {};	// all good, do nothing
	case (typename []): {	// read the min and max delay
		_delayMin = _delay param [0, DELAY_DEFAULT, [DELAY_DEFAULT]];
		_delayMax = _delay param [1, DELAY_DEFAULT, [DELAY_DEFAULT]];
	};
};

// Validate speed input
switch (typeName _speed) do {
	case (typeName 0): {};	// all good, do nothing
	case (typename []): {	// read the min and max speed
		_speedMin = _speed param [0, SPEED_DEFAULT, [SPEED_DEFAULT]];
		_speedMax = _speed param [1, SPEED_DEFAULT, [SPEED_DEFAULT]];
	};
};

// Define some variables
private _reverse = false;
private _curDist = 0;
private _curSpeed = _speedMin + random (_speedMax - _speedMin);




// Move the target
while {alive _target} do {

	// Determine the next position
	if (_reverse) then {
		_curDist = _curDist - (_curSpeed / _ticksPerSec);
	} else {
		_curDist = _curDist + (_curSpeed / _ticksPerSec);
	};

	// If we hit the end, stop
	if (_curDist <= 0 or {_curDist >= _dist}) then {
		_curSpeed = _speedMin + random (_speedMax - _speedMin);

		if (_curDist <= 0) then {
			_curDist = 0;
			_reverse = false;
		} else {
			_curDist = _dist;
			_reverse = true;
		};

		_target setPosWorld (_startPos vectorAdd (_vectorRight vectorMultiply _curDist));

		sleep (_delayMin + random (_delayMax - _delayMin));

	// Otherwise, move the target
	} else {
		_target setPosWorld (_startPos vectorAdd (_vectorRight vectorMultiply _curDist));

		sleep (1 / _ticksPerSec);
	};
};
