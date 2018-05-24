//	Zeus extensions for CA, by Bubbus.
//	
//	This is the configuration file for the gearscript spawner.
//	The default example in this file covers all factions of vanilla Arma.  You can modify it to spawn your own custom units.
//	The NATO example has comments to help understanding.


if (isDedicated) exitWith {};	// Don't remove this line!


_units = 
[	
	[
		"Wurstmeisters",
		"inf", "blu_f", west,
		[
			[
				"Rifleman",
				["rif"]
			],
		
			[
				"Fireteam 4x",
				["ftl", "med", "ar", "lat"]
			],
			
			[
				"Squad 6x",
				["ftl", "med", "ar", "lat", "aar", "mk"]
			],
			
			[
				"Rifle Sec 9x",
				["ftl", "med", "ar", "aar", "rif", "rif", "rif", "rif", "rif"]
			],
			
			[
				"Weapons team 4x",
				["ftl", "ar", "lat", "mk"]
			]
		]
	], 
	
	[
		"Deutsche maschinen", 
		"veh", "blu_f", west,
		[
			[
				"Hunter HMG",
				"B_MRAP_01_hmg_F",
				["ftl", "med", "ar", "rif"]
			],
			
			[
				"Hunter Unarmed",
				"B_MRAP_01_F",
				["ftl", "med", "ar", "rif"]
			],
			
			[
				"IFV Pandur II (Net)",
				"Cre8ive_PandurII_D_Net",
				["ftl", "rif", "rif"]
			],
			
			[
				"IFV Pandur II (Cage)",
				"Cre8ive_PandurII_D_Cage",
				["ftl", "rif", "rif"]
			],
			
			[
				"MBT Revolution",
				"Cre8ive_MBT_Revolution_D",
				["ftl", "rif", "rif"]
			],
			
			[
				"MBT Revolution (Net)",
				"Cre8ive_MBT_Revolution_D_Net",
				["ftl", "rif", "rif"]
			]
		]
	],
	
	
	[
		"Good Kebab",
		"inf", "ind_f", west,
		[
			[
				"Rifleman",
				["rif"]
			],
		
			[
				"Fireteam 4x",
				["ftl", "med", "ar", "lat"]
			],
			
			[
				"Squad 6x",
				["ftl", "med", "ar", "lat", "aar", "mk"]
			],
			
			[
				"Rifle Sec 9x",
				["ftl", "med", "ar", "aar", "rif", "rif", "rif", "rif", "rif"]
			],
			
			[
				"Weapons team 4x",
				["ftl", "ar", "lat", "mk"]
			]
		]
	], 
	
	[
		"Kebabmobiles", 
		"veh", "ind_f", west,
		[
			[
				"Humvee",
				"LOP_IA_M1025_D",
				["ftl", "med", "ar", "rif"]
			],
			
			[
				"Humvee HMG",
				"LOP_IA_M1025_W_M2",
				["ftl", "med", "ar", "rif"]
			],
			
			[
				"BTR-60PB",
				"LOP_IRAN_BTR60",
				["ftl", "rif", "rif"]
			],
			
			[
				"T-72B",
				"LOP_IRAN_T72BA",
				["ftl", "rif", "rif"]
			]
		]
	],
	

	[
		"Bad boys",
		"inf", "opf_f", east,
		[
			[
				"Rifleman",
				["rif"]
			],
		
			[
				"Marksman",
				["mk"]
			],
			
			[
				"RPG lad",
				["mat"]
			],
		
			[
				"Fireteam 4x",
				["ftl", "med", "ar", "lat"]
			],
			
			[
				"Squad 6x",
				["ftl", "med", "ar", "lat", "aar", "mk"]
			],
			
			[
				"Rifle Sec 9x",
				["ftl", "med", "ar", "rif", "rif", "rif", "rif", "rif", "rif"]
			],
			
			[
				"Weapons team 4x",
				["ftl", "ar", "mk", "mat"]
			]
		]
	], 
	
	[
		"Bad boops", 
		"veh", "opf_f", east,
		[
			[
				"Ural Rifle sec 9x",
				"LOP_TKA_Ural",
				["ftl", "med", "ar", "rif", "rif", "rif", "rif", "rif", "rif"]
			],
		
			[
				"Pickup Squad 6x",
				"O_G_Offroad_01_F",
				["ftl", "med", "ar", "lat", "rif", "mk"]
			],
			
			[
				"Pickup Fireteam 4x",
				"O_G_Offroad_01_F",
				["ftl", "med", "ar", "lat"]
			],
			
			[
				"BRDM (oh no)",
				"rhsgref_BRDM2",
				["ftl", "rif", "rif"]
			],
			
			[
				"BTR (oshit)",
				"LOP_ISTS_OPF_BTR60",
				["ftl", "rif", "rif"]
			]
		]
	]
	
];	// <-- Comma rule does not apply here - do not edit.

ca_zeus_unitsStructure = _units; // Don't remove this line!