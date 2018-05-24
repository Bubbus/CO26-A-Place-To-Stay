#define DELAY_DEFAULT 0.7
#define AMOUNT_DEFAULT 2
#define PAUSEDURATION_DEFAULT 10

// Fetch the parameters
params [
        ["_unit", objNull, [objNull]],
        ["_targetList", objNull, [objNull, []]],
        ["_amount", AMOUNT_DEFAULT, [AMOUNT_DEFAULT, []]],
        ["_delay", DELAY_DEFAULT, [DELAY_DEFAULT, []]],
        ["_pauseDuration", PAUSEDURATION_DEFAULT, [PAUSEDURATION_DEFAULT, []]],
        ["_instructor", objNull, [objNull]],
        ["_dangerVarName", "firingRange_danger", [""]]
];

if (!alive _unit or !local _unit) exitWith {};





// Define some constants
private _target = _targetList;
private _amountMin = _amount;
private _amountMax = _amount;
private _delayMin = _delay;
private _delayMax = _delay;
private _pauseDurationMin = _pauseDuration;
private _pauseDurationMax = _pauseDuration;


// Validate target list input
switch (typeName _targetList) do {
        case (typename []): {           // verify the array and fetch the first valid result
                private _typeNameObj = typeName objNull;

                for "_i" from (count _targetList - 1) to 0 step -1 do {
                        private _entry = _targetList param [_i, 0];

                        if (typeName _entry != _typeNameObj or {!alive _entry}) then {
                                _targetList deleteAt _i;
                        };
                };

                _target = selectRandom _targetList;
        };
	case (typeName objNull): {      // add the target into an array
                _targetList = [_targetList];
        };
};

// If no valid target was provided, exit
if (!alive _target) exitWith {};

// Validate amount input
switch (typeName _amount) do {
	case (typeName 0): {};	// all good, do nothing
	case (typename []): {	// read the min and max amount
		_amountMin = _amount param [0, AMOUNT_DEFAULT, [AMOUNT_DEFAULT]];
		_amountMax = 1 + _amount param [1, AMOUNT_DEFAULT, [AMOUNT_DEFAULT]];
	};
};

// Validate delay input
switch (typeName _delay) do {
	case (typeName 0): {};	// all good, do nothing
	case (typename []): {	// read the min and max delay
		_delayMin = _delay param [0, DELAY_DEFAULT, [DELAY_DEFAULT]];
		_delayMax = _delay param [1, DELAY_DEFAULT, [DELAY_DEFAULT]];
	};
};

// Validate pause duration input
switch (typeName _pauseDuration) do {
	case (typeName 0): {};	// all good, do nothing
	case (typename []): {	// read the min and max amount
		_pauseDurationMin = _pauseDuration param [0, PAUSEDURATION_DEFAULT, [PAUSEDURATION_DEFAULT]];
		_pauseDurationMax = _pauseDuration param [1, PAUSEDURATION_DEFAULT, [PAUSEDURATION_DEFAULT]];
	};
};

// Set up some variables
private _firing = false;
private _curAmount = floor (_amountMin + random (_amountMax - _amountMin));
private _targetIsReady = [{true}, {(_this animationPhase "terc") == 0}] select (_target isKindOf "TargetP_Inf_F");
private _isAiming = {((_this weaponDirection currentWeapon _this) vectorDotProduct (eyeDirection _this)) > 0.98};   // returns true if weapon direction and eye direction are within ~10° of one another





// Detect the unit firing
_unit addEventHandler ["Fired", {
        params ["_unit"];

        private _rounds = _unit getVariable ["fn_practiceTarget_rounds", 0];
        _unit setVariable ["fn_practiceTarget_rounds", _rounds + 1, false];
}];

// Detect the unit reloading (and resupply it with ammo)
_unit addEventHandler ["Reloaded", {
        params ["_unit", "_weapon", "_muzzle", ["_newMagazine", []], ["_oldMagazine", []]];

        // Figure out the magazine classname
        private _magClass = _oldMagazine param [0, ""];
        if (_magClass == "") then {
                _magClass = _newMagazine param [0, ""];
        };

        // Add a new magazine to the unit
        _unit addMagazine _magClass;
}];





// Prevent the unit (and his instructor, if he has one) from running away
_unit disableAI "PATH";
_instructor disableAI "PATH";

// Engage the target
while {alive _target and alive _target} do {

        private _rounds = _unit getVariable ["fn_practiceTarget_rounds", 0];

        // If we haven't fired yet, get ready to fire
        if (_rounds < _curAmount) then {

                // If a player was detected on the firing range, hold fire
                if (missionNamespace getVariable [_dangerVarName, false]) then {
                        _unit doWatch objNull;

                        sleep 1;

                // Otherwise, carry on
                } else {
                        // Set the unit into combat mode
                        if (!_firing) then {
                                _firing = true;

                                // Pick a target
                                _target = selectRandom _targetList;

                                // Set the unit into combat mode
                                (group _unit) setBehaviour "AWARE";
                        };

                        // Acquire the target
                        _unit lookAt _target;
                        _unit doFire _target;

                        // If the unit is aiming and the target is up, fire a round
                        if (_target call _targetIsready and {_unit call _isAiming}) then {
                                _unit forceWeaponFire [currentMuzzle _unit, "Single"];
                        };

                        sleep (_delayMin + random (_delayMax - _delayMin));
                };

        // Stop firing
        } else {
                if (_firing) then {
                        _firing = false;

                        // Stop watching the target
                        _unit doWatch objNull;

                        // Reset the amount of rounds fired
                        _unit setVariable ["fn_practiceTarget_rounds", 0, false];

                        // Determine how many rounds to fire next
                        _curAmount = floor (_amountMin + random (_amountMax - _amountMin));

                        // If we have an instructor, do some extra steps
                        if (alive _instructor) then {

                                // Make the instructor grab his binoculars and look at the target
                                _instructor doWatch objNull;
                                _instructor selectWeapon binocular _instructor;
                                _instructor lookAt _target;
                                _instructor doFire _target;

                                // Wait some
                                sleep _pauseDurationMin - 1 + random (_pauseDurationMax - _pauseDurationMin);

                                // Make the instructor put his binoculars away...
                                _instructor doWatch objNull;
                                _instructor action ["SwitchWeapon", _instructor, _instructor, -1];

                                sleep 1;

                                // ...and sometimes look at the unit
                                if ((random 1) < 0.3) then {
                                        _instructor lookAt (ASLtoATL eyePos _unit);
                                };

                        // Otherwise, just wait
                        } else {
                                sleep _pauseDurationMin + random (_pauseDurationMax - _pauseDurationMin);

                        };
                };
        };
};
