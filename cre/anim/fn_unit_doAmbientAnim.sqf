params [
        ["_unit", objNull, [objNull]],
        ["_anim", "", [""]],
        ["_type", 0, [0]],
        ["_forceWeaponType", -1, [0]],
        ["_loop", true, [true]],
        ["_mimics", true, [true]]
];

if (!alive _unit) exitWith {};





// Wait until mission start
waitUntil {time > 0};

// Determine which weapon the unit should use for this animation (if specified)
if (_forceWeaponType >= 0) then {
        switch (_forceWeaponType) do {
                case 0: {_unit action ["SwitchWeapon", _unit, _unit, -1]};
                case 1: {if (primaryWeapon _unit != "") then {_unit selectWeapon primaryWeapon _unit} else {_unit action ["SwitchWeapon", _unit, _unit, -1]}};
                case 2: {if (handgunWeapon _unit != "") then {_unit selectWeapon handgunWeapon _unit} else {_unit action ["SwitchWeapon", _unit, _unit, -1]}};
                case 3: {if (secondaryWeapon _unit != "") then {_unit selectWeapon secondaryWeapon _unit} else {_unit action ["SwitchWeapon", _unit, _unit, -1]}};
        };
};





// If looping is enabled, turn of the anim component
if (_loop) then {
        _unit disableAI "ANIM";

        // Store the animation on the unit for future use
        _unit setVariable ["fnc_ambientAnim_anim", toLower _anim, false];

        // Detect animation changes
        _unit addEventHandler ["AnimDone", {
                params ["_unit", "_anim"];

                if (!alive _unit) exitWith {};

                private _targetAnim = _unit getVariable ["fnc_ambientAnim_anim", ""];

                // If the target animation finished, reapply it (without transition)
                if (toLower _anim == _targetAnim) then {
                        [_unit, _anim] remoteExec ["switchMove", 0, false];
                };
        }];
};




// Disable  facial gestures, if desired
_unit enableMimics _mimics;

// Type 1 means switchMove (no transition)
if (_type == 1) then {
         [_unit, _anim] remoteExec ["switchMove", 0, false];

// Type 0 means playMove (with transition)
} else {
        [_unit, _anim] remoteExec ["playMove", 0, false];
};
