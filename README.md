# Mutant Tanks

## PayPal
[Donate to Motivate](https://paypal.me/Psyk0tikism?locale.x=en_US)

## Languages
[Russian](https://github.com/Psykotikism/Mutant_Tanks/blob/master/README_RU.md)

## License
> The following license is placed inside the source code of each plugin and include file.
<details>
	<summary>Click to expand!</summary>

Mutant Tanks: a L4D/L4D2 SourceMod Plugin
Copyright (C) 2023  Alfred "Psyk0tik" Llagas

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
</details>

## About
Originally an extended version of Super Tanks, Mutant Tanks combines Last Boss, Last Boss Extended, and Super Tanks to grant Tanks unique powers and abilities that enhance the player experience.

## Requirements
<details>
	<summary>Click to expand!</summary>

1. `SourceMod 1.12.0.6985` or higher
2. Recommended (Optional):
- [`Actions`](https://forums.alliedmods.net/showthread.php?t=336374)
- [`AutoExecConfig`](https://forums.alliedmods.net/showthread.php?t=204254)
- [`Explosive Chains Credit`](https://forums.alliedmods.net/showthread.php?t=334655)
- [`ThirdPersonShoulder_Detect`](https://forums.alliedmods.net/showthread.php?t=298649)
- [`Updater`](https://github.com/Teamkiller324/Updater)
- [`WeaponHandling_API`](https://forums.alliedmods.net/showthread.php?t=319947)
3. Knowledge of installing SourceMod plugins.
</details>

## Notes
<details>
	<summary>Click to expand!</summary>

1. I do not provide support for listen/local servers but the plugin and its modules should still work properly on them.
2. I will not help you with installing or troubleshooting problems on your part.
3. If you get errors from SourceMod itself, that is your problem, not mine.
4. MAKE SURE YOU MEET ALL THE REQUIREMENTS AND FOLLOW THE INSTALLATION GUIDE PROPERLY.
</details>

## Features
<details>
	<summary>Click to expand!</summary>

1. Fully compatible with all game modes.
2. Fully customizable Mutant Tanks.
3. Flexible config file.
4. Auto-reload the config file when changes are made mid-game.
5. Supports custom configurations for different scenarios/setups.
6. Store up to 500 Mutant Tank types.
7. Administration system designed for access and immunity to Mutant Tanks.
8. Custom target filters for targeting survivors, special infected, and Mutant Tanks.
9. Over 1,500 optional settings to configure.
10. Over 70 unique abilities to choose from.
11. Choose which abilities to install.
12. Add custom abilities and features through the use of forwards and natives.
13. Create all kinds of combinations of abilities.
14. Supports multiple languages.
15. Chat color tags for translation files.
16. Detects idle or bugged Tanks.
17. Toggle damage scaling based on difficulty.
18. Fully customizable reward system.
</details>

## Commands
<details>
	<summary>Click to expand!</summary>

```
// Accessible by admins with "z" (Root) flag only.
sm_mt_admin - View the Mutant Tanks admin panel.
sm_mt_config - View a section of a config file.
sm_mt_edit - Edit a setting in the config file.
sm_mt_list - View a list of installed abilities.
sm_mt_reload - Reload the config file.
sm_tank - Spawn a Mutant Tank.
sm_mt_tank - Spawn a Mutant Tank.
sm_mt_version - Find out the current version of Mutant Tanks.

// Accessible by the developer only.
sm_mt_dev - Used only by and for the developer.

// Accessible by all players.
sm_mutanttank - Choose a Mutant Tank. (This command only works if the "Spawn Mode" setting under the "Plugin Settings/Human Support" section is set to 0.)
sm_mt_info - View information about Mutant Tanks.
sm_mt_prefs - Set your Mutant Tanks preferences.

// Packaged
sm_mt_ability - View information about each ability (A-L).
sm_mt_ability2 - View information about each ability (M-Z).

// Standalone
sm_mt_absorb - View information about the Absorb ability.
sm_mt_acid - View information about the Acid ability.
sm_mt_aimless - View information about the Aimless ability.
sm_mt_ammo - View information about the Ammo ability.
sm_mt_blind - View information about the Blind ability.
sm_mt_bomb - View information about the Bomb ability.
sm_mt_bury - View information about the Bury ability.
sm_mt_car - View information about the Car ability.
sm_mt_choke - View information about the Choke ability.
sm_mt_clone - View information about the Clone ability.
sm_mt_cloud - View information about the Cloud ability.
sm_mt_drop - View information about the Drop ability.
sm_mt_drug - View information about the Drug ability.
sm_mt_drunk - View information about the Drunk ability.
sm_mt_electric - View information about the Electric ability.
sm_mt_enforce - View information about the Enforce ability.
sm_mt_fast - View information about the Fast ability.
sm_mt_fire - View information about the Fire ability.
sm_mt_fling - View information about the Fling ability.
sm_mt_fly - View information about the Fly ability.
sm_mt_fragile - View information about the Fragile ability.
sm_mt_ghost - View information about the Ghost ability.
sm_mt_god - View information about the God ability.
sm_mt_gravity - View information about the Gravity ability.
sm_mt_gunner - View information about the Gunner ability.
sm_mt_heal - View information about the Heal ability.
sm_mt_hit - View information about the Hit ability.
sm_mt_hurt - View information about the Hurt ability.
sm_mt_hypno - View information about the Hypno ability.
sm_mt_ice - View information about the Ice ability.
sm_mt_idle - View information about the Idle ability.
sm_mt_invert - View information about the Invert ability.
sm_mt_item - View information about the Item ability.
sm_mt_jump - View information about the Jump ability.
sm_mt_kamikaze - View information about the Kamikaze ability.
sm_mt_lag - View information about the Lag ability.
sm_mt_laser - View information about the Laser ability.
sm_mt_leech - View information about the Leech ability.
sm_mt_lightning - View information about the Lightning ability.
sm_mt_medic - View information about the Medic ability.
sm_mt_meteor - View information about the Meteor ability.
sm_mt_minion - View information about the Minion ability.
sm_mt_necro - View information about the Necro ability.
sm_mt_nullify - View information about the Nullify ability.
sm_mt_omni - View information about the Omni ability.
sm_mt_panic - View information about the Panic ability.
sm_mt_pimp - View information about the Pimp ability.
sm_mt_puke - View information about the Puke ability.
sm_mt_pyro - View information about the Pyro ability.
sm_mt_quiet - View information about the Quiet ability.
sm_mt_recall - View information about the Recall ability.
sm_mt_recoil - View information about the Recoil ability.
sm_mt_regen - View information about the Regen ability.
sm_mt_respawn - View information about the Respawn ability.
sm_mt_restart - View information about the Restart ability.
sm_mt_rock - View information about the Rock ability.
sm_mt_rocket - View information about the Rocket ability.
sm_mt_shake - View information about the Shake ability.
sm_mt_shield - View information about the Shield ability.
sm_mt_shove - View information about the Shove ability.
sm_mt_slow - View information about the Slow ability.
sm_mt_smash - View information about the Smash ability.
sm_mt_smite - View information about the Smite ability.
sm_mt_spam - View information about the Spam ability.
sm_mt_splash - View information about the Splash ability.
sm_mt_splatter - View information about the Splatter ability.
sm_mt_throw - View information about the Throw ability.
sm_mt_track - View information about the Track ability.
sm_mt_ultimate - View information about the Ultimate ability.
sm_mt_undead - View information about the Undead ability.
sm_mt_vampire - View information about the Vampire ability.
sm_mt_vision - View information about the Vision ability.
sm_mt_warp - View information about the Warp ability.
sm_mt_whirl - View information about the Whirl ability.
sm_mt_witch - View information about the Witch ability.
sm_mt_xiphos - View information about the Xiphos ability.
sm_mt_yell - View information about the Yell ability.
sm_mt_zombie - View information about the Zombie ability.
```
</details>

## ConVar Settings
<details>
	<summary>Click to expand!</summary>

```
// Automatically update Mutant Tanks.
// Requires "Updater": https://github.com/Teamkiller324/Updater
// 0: OFF
// 1: ON
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
mt_autoupdate "0"

// The config filename used by Mutant Tanks to read settings from.
// Empty: None
// Not empty: The custom config filename to use.
// -
// Default: "mutant_tanks.cfg"
mt_configfile "mutant_tanks.cfg"

// Disable Mutant Tanks in these game modes.
// Separate by commas.
// Empty: None
// Not empty: Disabled only in these game modes.
// -
// Default: ""
mt_disabledgamemodes ""

// Enable Mutant Tanks in these game modes.
// Separate by commas.
// Empty: All
// Not empty: Enabled only in these game modes.
// -
// Default: ""
mt_enabledgamemodes ""

// Enable Mutant Tanks in these game mode types.
// 0 OR 15: All game mode types.
// 1: Co-Op modes only.
// 2: Versus modes only.
// 4: Survival modes only.
// 8: Scavenge modes only. (Only available in Left 4 Dead 2.)
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "15.000000"
mt_gamemodetypes "0"

// Enable Mutant Tanks on listen servers.
// 0: OFF
// 1: ON
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
mt_listensupport "0"

// Enable Mutant Tanks.
// 0: OFF
// 1: ON
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
mt_pluginenabled "1"
```
</details>

## KeyValues Settings
> View the [INFORMATION.md](https://github.com/Psykotikism/Mutant_Tanks/blob/master/INFORMATION.md) file for information about each available setting. (Over 1,500 customization options!)

## Installation
<details>
	<summary>Click to expand!</summary>

1. Delete files from old versions of the plugin.
2. Extract the folder inside the `mutant_tanks.zip` file.
3. Place all the contents into their respective folders.
4. If prompted to replace or merge anything, click `Yes`.
5. Load the plugin by restarting the server.
6. Customize the plugin in `addons/sourcemod/data/mutant_tanks/mutant_tanks.cfg`
</details>

## Compiling
<details>
	<summary>Click to expand!</summary>

1. Make sure all the ability plugin source files are in their respective folders.
- `scripting/mutant_tanks/abilities`
- `scripting/mutant_tanks/abilities2`
2. To disable/exclude one or more abilities, move the file(s) to one of the corresponding folders:
- `scripting/mutant_tanks/abilities/disabled`
- `scripting/mutant_tanks/abilities2/disabled`
3. Move the following files from the `scripting/mutant_tanks` folder to the `scripting` folder:
- `mutant_tanks.sp`
- `mt_abilities.sp`
- `mt_abilities2.sp`
4. Drag the files to `compile.exe` (all at once) or `spcomp.exe` (one by one).
- If `compile.exe` is used, the plugins will be created inside the `scripting/compiled` folder.
- If `spcomp.exe` is used, the plugins will be created inside the `scripting` folder.
5. Move the plugin(s) to the `plugins/mutant_tanks` folder.
- If the `mutant_tanks` folder isn't in the `plugins` folder, create one.
</details>

## Uninstalling/Upgrading to Newer Versions
<details>
	<summary>Click to expand!</summary>

1. Delete `mutant_tanks` folder from:
- `addons/sourcemod/plugins` folder (`mutant_tanks.smx` and all of its modules)
- `addons/sourcemod/scripting` folder (`mutant_tanks.sp` and all of its modules)
2. Delete `mutant_tanks.txt` from `addons/sourcemod/gamedata` folder.
3. Delete `mutant_tanks.inc` and `mt_clone.inc` from `addons/sourcemod/scripting/include` folder.
4. Delete `mutant_tanks.phrases.txt` from:
- `addons/sourcemod/translations` folder
- `addons/sourcemod/translations/chi` folder
- `addons/sourcemod/translations/hu` folder
- `addons/sourcemod/translations/ru` folder
5. Backup `mutant_tanks.cfg` in `addons/sourcemod/data/mutant_tanks` folder.
6. Delete `mutant_tanks_detours.cfg` from `addons/sourcemod/data/mutant_tanks` folder.
7. Delete `mutant_tanks_patches.cfg` from `addons/sourcemod/data/mutant_tanks` folder.
8. Delete `mutant_tanks_signatures.cfg` from `addons/sourcemod/data/mutant_tanks` folder.
9. Delete `mutant_tanks_updater.txt` from `addons/sourcemod` folder.
10. Follow the Installation guide above. (Only for upgrading to newer versions.)
</details>

## Disabling
<details>
	<summary>Click to expand!</summary>

1. Move `mutant_tanks` folder (`mutant_tanks.smx` and all of its modules) to `plugins/disabled` folder.
2. Disable the plugin by restarting the server. (Using `sm plugins unload` will take too long.)
</details>

## Disabling Announcements
<details>
	<summary>Click to expand!</summary>

> You need to disable a few settings.	
```
"Mutant Tanks"
{
	"Plugin Settings"
	{
		"Announcements"
		{
			"Announce Arrival"		"0"
			"Announce Death"		"0"
			"Announce Kill"			"0"
		}
	}
	"Tank #1"
	{
		"General"
		{
			"Tank Note"			"0" // you have to do this for each tank
		}
		"Absorb Ability"
		{
			"Ability Message"		"0" // you have to do this for each ability
		}
	}
}
```
</details>

## Custom Configuration Files
> Mutant Tanks has features that allow for creating and executing custom configuration files.
<details>
	<summary>Click to expand!</summary>

By default, `Mutant Tanks` can create and execute the following types of configurations:
1. Difficulty - Files are created/executed based on the current game difficulty. (Example: If the current `z_difficulty` is set to Impossible (Expert mode), then `Impossible.cfg` is executed (or created if it doesn't exist already).
2. Map - Files are created/executed based on the current map. (Example: If the current map is `c1m1_hotel`, then `c1m1_hotel.cfg` is executed (or created if it doesn't exist already).
3. Game mode - Files are created/executed based on the current game mode. (Example: If the current game mode is Versus, then `versus.cfg` is executed (or created if it doesn't exist already).
4. Daily - Files are created/executed based on the current day. (Example: If the current day is Friday, then `friday.cfg` is executed (or created if it doesn't exist already).
5. Player (survivor/infected/all) count - Files are created/executed based on the current number of human players. (Example: If the current number is 8, then `8.cfg` is executed (or created if it doesn't exist already).
6. Finale stages - Files are created/executed based on the finale stages called by the game. (Example: If the finale starts, then `finale_start.cfg` is executed (or created if it doesn't exist already)).
</details>

### Features
<details>
	<summary>Click to expand!</summary>

1. Create custom config files (can be based on difficulty, map, game mode, day, player (survivor/infected/all) count, or finale stage).
2. Execute custom config files (can be based on difficulty, map, game mode, day, player (survivor/infected/all) count, or finale stage).
3. Automatically generate config files for up to 66 players, all difficulties specified by `z_difficulty`, maps installed on the server, game modes specified by `sv_gametypes` and `mp_gamemode`, days of the `week`, and all possible `finale stages`.
</details>

## Questions You May Have
> If you have any questions that aren't addressed below, feel free to message me or post on this [thread](https://forums.alliedmods.net/showthread.php?t=302140). Read the INFORMATION.md file to learn about every setting/feature available. Visit the [Wiki](https://github.com/Psykotikism/Mutant_Tanks/wiki) for more information, including examples and/or tutorials.

### Main Features
<details>
	<summary>Click to expand!</summary>

<details>
	<summary>Question 1</summary>

1. How do I make my own Mutant Tank?
- Create an entry.
<details>
	<summary>Examples</summary>

<details>
	<summary>This is okay</summary>

```
"Mutant Tanks"
{
	"Tank #25"
	{
		"General"
		{
			"Tank Name"				"Test Tank" // Tank has a name.
			"Tank Enabled"				"1" // Tank is enabled.
			"Tank Chance"				"100.0" // Tank has 100% chance of spawning.
			"Spawn Enabled"				"1" // Tank can spawn.
			"Menu Enabled"				"1" // Tank can be spawned through the "sm_tank" command.
			"Skin Color"				"255,0,0,255" // Tank has red skin.
			"Glow Color"				"255,255,0" // Tank has a yellow glow outline.
		}
	}
}
```
</details>
<details>
	<summary>This is not okay</summary>

```
"Mutant Tanks"
{
	"Tank #25"
	{
		"General"
		{
			// "Tank Enabled" is missing so this entry is disabled.
			"Tank Name"				"Test Tank" // Tank has a name.
			"Tank Chance"				"47.0" // Tank has 47% chance of spawning.
			"Spawn Enabled"				"1" // Tank can spawn.
			"Menu Enabled"				"1" // Tank can be spawned through the "sm_tank" command.
			"Skin Color"				"255,0,0,255" // Tank has red skin.
			"Glow Color"				"255,255,0" // Tank has a yellow glow outline.
		}
	}
}
```
</details>
<details>
	<summary>This is okay</summary>

```
"Mutant Tanks"
{
	"Tank #25"
	{
		"General"
		{
			// Since "Tank Name" is missing, the default name for this entry will be "Tank"
			"Tank Enabled"				"1" // Tank is enabled.
			"Tank Chance"				"12.3" // Tank has 12.3% chance of spawning.
			"Spawn Enabled"				"1" // Tank can spawn.
			"Menu Enabled"				"1" // Tank can be spawned through the "sm_tank" command.
			"Skin Color"				"255,0,0,255" // Tank has red skin.
			"Glow Color"				"255,255,0" // Tank has a yellow glow outline.
		}
	}
}
```
</details>
<details>
	<summary>This is not okay</summary>

```
"Mutant Tanks"
{
	"Tank #25"
	{
		"General"
		{
			"Tank Name"				"Test Tank" // Tank has a name.
			"Tank Enabled"				"1" // Tank is enabled.
			"Tank Chance"				"59.0" // Tank has 59% chance of spawning.
			"Spawn Enabled"				"1" // Tank can spawn.
			"Menu Enabled"				"1" // Tank can be spawned through the "sm_tank" command.
			"Skin Color"				"255 0 0 255" // The values should be separated by commas not white spaces.
			"Glow Color"				"255 255 0" // The values should be separated by commas not white spaces.
		}
	}
}
```
</details>
</details>
- Adding the entry to the roster.

Here's our final entry:
<details>
	<summary>Click to expand!</summary>

```
"Mutant Tanks"
{
	"Tank #25"
	{
		"General"
		{
			"Tank Name"				"Test Tank" // Named "Test Tank".
			"Tank Enabled"				"1" // Entry is enabled.
			"Tank Chance"				"9.5" // Tank has 9.5% chance of spawning.
			"Spawn Enabled"				"1" // Tank can spawn.
			"Menu Enabled"				"1" // Tank can be spawned through the "sm_tank" command.
			"Skin Color"				"255,0,0,255" // Tank has red skin.
			"Glow Color"				"255,255,0" // Tank has a yellow glow outline.
		}
		"Immunities"
		{
			"Fire Immunity"				"1" // Immune to fire.
		}
	}
}
```
</details>

To make sure that this entry can be chosen, we must change the value in the `Type Range` setting.

<details>
	<summary>Click to expand!</summary>

```
"Mutant Tanks"
{
	"Plugin Settings"
	{
		"General"
		{
			"Type Range"				"1-14" // Determines what entry to start and stop at when reading the entire config file.
		}
	}
}
```
</details>

Now, assuming that `Tank #15` is our highest entry, we just raise the maximum value of `Type Range` by 1, so we get 15 entries to choose from. Once the plugin starts reading the config file, when it gets to `Tank #15` it will stop reading the rest.

<details>
	<summary>Advanced Entry Examples</summary>

```
"Mutant Tanks"
{
	"Plugin Settings"
	{
		"General"
		{
			"Type Range"				"1-10" // Check "Tank #1" to "Tank #10"
		}
	}
	"Tank #10" // Checked by the plugin.
	{
		"General"
		{
			"Tank Name"				"Leaper Tank"
			"Tank Enabled"				"1"
			"Tank Chance"				"75.2"
			"Spawn Enabled"				"1"
			"Menu Enabled"				"1"
			"Skin Color"				"255,255,0,255"
			"Glow Color"				"255,255,0"
		}
		"Enhancements"
		{
			"Extra Health"				"50" // Tank's base health + 50
		}
		"Jump Ability"
		{
			"Ability Enabled"			"2" // The Tank jumps periodically.
			"Ability Message"			"3" // Notify players when the Tank is jumping periodically.
			"Jump Height"				"300.0" // How high off the ground the Tank can jump.
			"Jump Interval"				"1.0" // How often the Tank jumps.
			"Jump Mode"				"0" // The Tank's jumping method.
		}
	}
}
```
```
"Mutant Tanks"
{
	"Plugin Settings"
	{
		"General"
		{
			"Type Range"				"1-11" // Only check for the first 11 Tank types. ("Tank #1" to "Tank #11")
		}
	}
	"Tank #13" // This will not be checked by the plugin.
	{
		"General"
		{
			"Tank Name"				"Invisible Tank"
			"Tank Enabled"				"1"
			"Tank Chance"				"38.2"
			"Spawn Enabled"				"1"
			"Menu Enabled"				"1"
			"Skin Color"				"255,255,255,255"
			"Glow Color"				"255,255,255"
			"Glow Enabled"				"0" // No glow outline.
		}
		"Immunities"
		{
			"Fire Immunity"				"1" // Immune to fire.
		}
		"Ghost Ability"
		{
			"Ability Enabled"			"2"
			"Ghost Fade Alpha"			"2"
			"Ghost Fade Delay"			"5.0"
			"Ghost Fade Limit"			"0"
			"Ghost Fade Rate"			"0.1"
		}
	}
	"Tank #10" // Checked by the plugin.
	{
		"General"
		{
			"Tank Enabled"				"1"
		}
		"Enhancements"
		{
			"Run Speed"				"1.5" // How fast the Tank moves.
		}
	}
}
```
</details>
</details>
<details>
	<summary>Question 2</summary>

2. Can you add more abilities or features?

- `Mutant Tanks` already uses a lot of files, so there's no room for anymore abilities or features as of `v8.80`.
</details>
<details>
	<summary>Question 3</summary>

3. How do I enable/disable the plugin in certain game modes?

You have 2 options:
- Enable/disable in certain game mode types. (You must add numbers up together in `Game Mode Types`.)
- Enable/disable in specific game modes. (You must specify the game modes in `Enabled Game Modes` and `Disabled Game Modes`.)

Here are some scenarios and their outcomes:

<details>
	<summary>Scenario 1</summary>

```
"Game Mode Types" "0" // The plugin is enabled in all game mode types.
"Enabled Game Modes" "" // The plugin is enabled in all game modes.
"Disabled Game Modes" "coop" // The plugin is disabled in "coop" mode.

Outcome: The plugin works in every game mode except "coop" mode.
```
</details>
<details>
	<summary>Scenario 2</summary>

```
"Game Mode Types" "1" // The plugin is enabled in every Campaign-based game mode.
"Enabled Game Modes" "coop" // The plugin is enabled in only "coop" mode.
"Disabled Game Modes" "" // The plugin is not disabled in any game modes.

Outcome: The plugin works only in "coop" mode.
```
</details>
<details>
	<summary>Scenario 3</summary>

```
"Game Mode Types" "5" // The plugin is enabled in every Campaign-based and Survival-based game mode.
"Enabled Game Modes" "coop,versus" // The plugin is enabled in only "coop" and "versus" mode.
"Disabled Game Modes" "coop" // The plugin is disabled in "coop" mode.

Outcome: The plugin works only in "coop" mode.
```
</details>
</details>
<details>
	<summary>Question 4</summary>

4. How come some Mutant Tanks aren't showing up?

It may be due to one or more of the following:
- The `Tank Enabled` setting for that Mutant Tank may be set to `0` or doesn't exists at all which defaults to `0`.
- The `Spawn Enabled` setting for that Mutant Tank may be set to `0`.
- You have created a new Mutant Tank and didn't raise the maximum value of `Type Range`.
- You have misspelled one of the settings.
- You are still using the `Tank Character` setting which is no longer used since `v8.16`.
- You didn't set up the Mutant Tank properly.
- You are missing quotation marks.
- You are missing curly braces.
- You have more than `500` Mutant Tanks in your config file.
- You didn't format your config file properly.
- The Mutant Tanks requires X human-controlled survivors around and there are none.
- The Mutant Tank needs to be in an open area to spawn and it's currently in a narrow place.
- The number of Mutant Tanks currently alive with the same type has reached or exceeded the limit set by the `Type Limit`.
- The Mutant Tank can only spawn on regular maps.
- The Mutant Tank can only spawn on finale maps.
</details>
<details>
	<summary>Question 5</summary>

5. How do I kill the Tanks depending on what abilities they have?

The following abilities require different strategies:
- Absorb Ability: The Mutant Tank takes way less damage. Conserve your ammo and maintain distance between you and the Mutant Tank.
- God Ability: The Mutant Tank will have god mode temporarily and will not take any damage at all until the effect ends. Maintain distance between you and the Mutant Tank.
- Bullet Immunity: Forget your guns. Just spam your grenade launcher at it, slash it with an axe or crowbar, or burn it to death.
- Explosive Immunity: Forget explosives and just focus on gunfire, melee weapons, and molotovs/gascans.
- Fire Immunity: No more barbecued Tanks. Just keep shooting
- Melee Immunity: No more Gordon Freeman players (immune to melee weapons including crowbar).
- Nullify Hit: The Mutant Tank can mark players as useless, which means as long as that player is nullified, they will not do any damage.
- Shield Ability: If set to be weak to explosives, wait for the Tank to throw propane tanks at you and then throw it back at the Tank. Then shoot the propane tank to deactivate the Tank's shield. If set to be weak to fire, wait for the Tank to throw gascans at you and then throw it back at the Tank. Then shoot the gascan to deactivate the Tank's shield. If set to be weak to bullets, just keep shooting the Tank. If set to be weak to melee hits, just keep slashing at the Tank.

Visit the [Wiki](https://github.com/Psykotikism/Mutant_Tanks/wiki) for more information on each ability's strengths and weaknesses.
</details>
<details>
	<summary>Question 6</summary>

6. How can I change the amount of Tanks that spawn on each finale wave?

Here's an example:
```
"Finale Waves" "1,2,3,4,5,6,7,8,9,10" // Spawn 2 Tanks on the 1st wave, 3 Tanks on the 2nd wave, 4 Tanks on the 3rd wave, etc.
```
</details>
<details>
	<summary>Question 7</summary>

7. How can I change the amount of Tanks that can spawn on finale maps?

Set the value in `Finale Amount`.
</details>
<details>
	<summary>Question 8</summary>

8. How can I decide whether to display each Tank's health?

Set the value in `Display Health`.
</details>
<details>
	<summary>Question 9</summary>

9. Why do some Tanks spawn with different props?

Each prop has X out of `100.0%` chance to appear on Mutant Tanks when they spawn. Configure the chances for each prop in the `Props Chance` setting.
</details>
<details>
	<summary>Question 10</summary>

10. Why are the Tanks spawning with more than the extra health given to them?

Since `v8.10`, extra health given to Tanks is now multiplied by the number of alive non-idle human survivors present when the Tank spawns.
</details>
<details>
	<summary>Question 11</summary>

11. How do I add more Mutant Tanks?
- Add a new entry in the config file.
- Raise the maximum value of the `Type Range` setting.

<details>
	<summary>Example</summary>

```
"Mutant Tanks"
{
	"Plugin Settings"
	{
		"General"
		{
			"Type Range"				"1-2" // The plugin will check for 2 entries when loading the config file.
		}
	}
	"Tank #2"
	{
		"General"
		{
			"Tank Enabled"				"1" // Tank #2 is enabled and can be chosen.
		}
	}
}
```
</details>
</details>
<details>
	<summary>Question 12</summary>

12. How do I filter out certain Mutant Tanks that I made without deleting them?

Enable/disable them with the `Tank Enabled` setting.

<details>
	<summary>Example</summary>

```
"Mutant Tanks"
{
	"Tank #1"
	{
		"General"
		{
			"Tank Enabled"				"1" // Tank #1 can be chosen.
			"Tank Chance"				"100.0" // Tank #1 has a chance to spawn.
		}
	}
	"Tank #2"
	{
		"General"
		{
			"Tank Enabled"				"0" // Tank #2 cannot be chosen.
			"Tank Chance"				"0.0" // Tank #2 has no chance to spawn but can still be spawned through the menu.
		}
	}
	"Tank #3"
	{
		"General"
		{
			"Tank Enabled"				"0" // Tank #3 cannot be chosen.
			"Tank Chance"				"0.0" // Tank #3 has no chance to spawn but can still be spawned through the menu.
		}
	}
	"Tank #4"
	{
		"General"
		{
			"Tank Enabled"				"1" // Tank #4 can be chosen.
			"Tank Chance"				"100.0" // Tank #4 has a chance to spawn.
		}
	}
}
```
</details>
</details>
<details>
	<summary>Question 13</summary>

13. Can I create temporary Tanks without removing or replacing them?

Yes, you can do that with custom configs.

<details>
	<summary>Example</summary>

```
// Settings for addons/sourcemod/data/mutant_tanks/mutant_tanks.cfg
"Mutant Tanks"
{
	"Plugin Settings"
	{
		"Custom"
		{
			"Enable Custom Configs"			"1" // Enable custom configs
			"Execute Config Types"			"1" // 1: Difficulty configs (easy, normal, hard, impossible)
		}
	}
	"Tank #1"
	{
		"General"
		{
			"Tank Name"				"Psyk0tik Tank"
			"Tank Enabled"				"1"
			"Tank Chance"				"2.53"
			"Spawn Enabled"				"1"
			"Menu Enabled"				"1"
			"Skin Color"				"0,170,255,255"
			"Glow Color"				"0,170,255"
		}
		"Enhancements"
		{
			"Extra Health"				"250"
		}
		"Immunities"
		{
			"Fire Immunity"				"1"
		}
	}
}

// Settings for addons/sourcemod/data/mutant_tanks/difficulty_configs/Impossible.cfg
"Mutant Tanks"
{
	"Tank #1"
	{
		"General"
		{
			"Tank Name"				"Idiot Tank"
			"Tank Enabled"				"1"
			"Tank Chance"				"1.0"
			"Spawn Enabled"				"1"
			"Menu Enabled"				"1"
			"Skin Color"				"1,1,1,255"
			"Glow Color"				"1,1,1"
		}
		"Enhancements"
		{
			"Extra Health"				"1"
		}
		"Immunities"
		{
			"Fire Immunity"				"0"
		}
	}
}

Output: When the current difficulty is Expert mode (impossible), the Idiot Tank will spawn instead of "Psyk0tik Tank" as long as custom configs is being used.

These are basically temporary Tanks that you can create for certain situations, like if there's 5 players on the server, the map is c1m1_hotel, or even if the day is Thursday, etc.
```
</details>
</details>
<details>
	<summary>Question 14</summary>

14. How can I move the Mutant Tanks category around on the admin menu?
- You have to open up `addons/sourcemod/configs/adminmenu_sorting.txt` and add the `MutantTanks` category.
- This also allows you to sort each item in the category.

<details>
	<summary>Example</summary>

```
"Menu"
{
	"PlayerCommands"
	{
		"item"		"sm_slay"
		"item"		"sm_slap"
		"item"		"sm_kick"
		"item"		"sm_ban"
		"item"		"sm_gag"
		"item"		"sm_burn"
		"item"		"sm_beacon"
		"item"		"sm_freeze"
		"item"		"sm_timebomb"
		"item"		"sm_firebomb"
		"item"		"sm_freezebomb"
	}

	"ServerCommands"
	{
		"item"		"sm_map"
		"item"		"sm_execcfg"
		"item"		"sm_reloadadmins"
	}

	"VotingCommands"
	{
		"item"		"sm_cancelvote"
		"item"		"sm_votemap"
		"item"		"sm_votekick"
		"item"		"sm_voteban"
	}

	"MutantTanks"
	{
		"item"		"sm_mt_tank"
		"item"		"sm_mt_smoker"
		"item"		"sm_mt_boomer"
		"item"		"sm_mt_hunter"
		"item"		"sm_mt_spitter"
		"item"		"sm_mt_jockey"
		"item"		"sm_mt_charger"
		"item"		"sm_mt_config"
		"item"		"sm_mt_info"
		"item"		"sm_mt_list"
		"item"		"sm_mt_reload"
		"item"		"sm_mt_version"
	}
}
```
</details>
</details>
<details>
	<summary>Question 15</summary>

15. How can I disable the `MutantTanks` category for some admins?

You can use the `mt_adminmenu` override to restrict the category to certain admin flags/groups.
</details>
<details>
	<summary>Question 16</summary>

16. Are there any developer/tester features available in the plugin?

Yes, there are forwards, natives, stocks, target filters for each special infected, and an admin command that allows developers/testers to spawn and test each Mutant Tank.

<details>
	<summary>Forwards</summary>

```
/**
 * Called every second to trigger a Mutant Tank's ability.
 * Use this forward for any passive abilities.
 *
 * @param tank			Client index of the Tank.
 **/
forward void MT_OnAbilityActivated(int tank);

/**
 * Called before the config file is read.
 * Use this forward to store the different formats of the ability's section name.
 *
 * @param list			List to store the first format.
 * @param list2			List to store the second format.
 * @param list3			List to store the third format.
 * @param list4			List to store the fourth format.
 **/
forward void MT_OnAbilityCheck(ArrayList list, ArrayList list2, ArrayList list3, ArrayList list4);

/**
 * Called when a human-controlled Mutant Tank presses a button.
 * Use this forward to trigger abilities manually.
 *
 * @param tank			Client index of the Tank.
 * @param button		Button pressed.
 **/
forward void MT_OnButtonPressed(int tank, int button);

/**
 * Called when a human-controlled Mutant Tank releases a button.
 * Use this forward to trigger abilities manually.
 *
 * @param tank			Client index of the Tank.
 * @param button		Button released.
 **/
forward void MT_OnButtonReleased(int tank, int button);

/**
 * Called when a Mutant Tank changes types.
 * Use this forward to trigger any features/abilities/settings when a Mutant Tank changes types.
 *
 * @param tank			Client index of the Tank.
 * @param oldType		The Tank's previous Mutant Tank type.
 * @param newType		The Tank's new Mutant Tank type.
 * @param revert		True if reverting to a normal Tank, false otherwise.
 **/
forward void MT_OnChangeType(int tank, int oldType, int newType, bool revert);

/**
 * Called when a Mutant Tank's abilities are combined.
 * Use this forward to trigger any combinations.
 *
 * @param tank			Client index of the Tank.
 * @param type			0 = Main/range abilities, 1 = Hit abilities, 2 = Rock throw abilities, 3 = Rock break abilities,
 * 					4 = Post-spawn abilities, 5 = Upon-death abilities, 6 = Upon-incap abilities
 * @param random		Random value to check against for chance to trigger combination.
 * @param combo			String containing the list of abilities to combine.
 * @param survivor		Client index of the survivor, if any.
 * @param weapon		Entity index of the weapon, if any.
 * @param classname		String containing the weapon classname, if any.
 **/
forward void MT_OnCombineAbilities(int tank, int type, const float random, const char[] combo, int survivor, int weapon, const char[] classname);

/**
 * Called when the config file is about to load.
 * Use this forward to set default values for settings for the plugin.
 *
 * @param mode			1 = Load general settings, 2 = 1 + load type settings, 3 = Load admin settings
 **/
forward void MT_OnConfigsLoad(int mode);

/**
 * Called when the config file is loaded.
 * Use this forward to load settings for the plugin.
 *
 * @param subsection		The subsection the config parser is currently on.
 * @param key			The key the config parser is currently on.
 * @param value			The value the config parser is currently on.
 * @param type			The Mutant Tank type the config parser is currently on. (Used for Mutant Tank-specific settings.)
 * @param admin			Client index of an admin. (Used for admin-specific settings.)
 * @param mode			1 = Load general settings, 2 = 1 + load type settings, 3 = Load admin settings
 * @param special		True if reading a special infected setting, false otherwise.
 * @param specsection		The special section the config parser is currently on.
 * @param specType		Special Infected type.
 **/
forward void MT_OnConfigsLoaded(const char[] subsection, const char[] key, const char[] value, int type, int admin, int mode, bool special, const char[] specsection, int specType);

/**
 * Called when the Tank is passed on to another player or bot.
 * Use this forward to copy over any stats for the Tank's new owner.
 *
 * @param oldTank		Client index of the previous owner.
 * @param newTank		Client index of the new owner.
 **/
forward void MT_OnCopyStats(int oldTank, int newTank);

/**
 * Called when a player uses the "sm_st_info" command.
 * Use this forward to add menu items.
 *
 * @param menu			Handle to the menu.
 **/
forward void MT_OnDisplayMenu(Menu menu);

/**
 * Called when an event hooked by the core plugin is fired.
 * Use this forward to trigger something on any of those events.
 *
 * @param event			Handle to the event.
 * @param name			String containing the name of the event.
 * @param dontBroadcast		True if event was not broadcast to clients, false otherwise.
 **/
forward void MT_OnEventFired(Event event, const char[] name, bool dontBroadcast);

/**
 * Called when a survivor is falling in a fatal zone.
 * Use this forward to check if the current map has death fall cameras (fatal falls).
 *
 * @param survivor		Client index of the survivor.
 *
 * @return			Plugin_Handled to prevent the death fall camera from triggering, Plugin_Continue to allow.
 **/
forward Action MT_OnFatalFalling(int survivor);

/**
 * Called when the core plugin is hooking/unhooking events.
 * Use this forward to hook/unhook events.
 *
 * @param hooked		True if event was hooked, false otherwise.
 **/
forward void MT_OnHookEvent(bool hooked);

/**
 * Called when a message is about to be logged.
 * Use this forward to intercept a message.
 *
 * @param type			Type of message being logged.
 * @param message		Buffer containing the message.
 *
 * @return			Plugin_Handled to prevent the message from being logged, Plugin_Continue to allow.
 **/
forward Action MT_OnLogMessage(int type, const char[] message);

/**
 * Called when an item from the "Mutant Tanks Information" menu is displayed.
 * Use this forward to translate an item. The menu callback will redraw the item after this forward is called if the buffer isn't empty.
 *
 * @param client		Client index of the player the item is being displayed to.
 * @param info			String containing the name of the item.
 * @param buffer		String to store the translated item.
 * @param size			Size of the buffer.
 **/
forward void MT_OnMenuItemDisplayed(int client, const char[] info, char[] buffer, int size);

/**
 * Called when a player selects an item from the "Mutant Tanks Information" menu.
 * Use this forward to do anything when an item is selected.
 *
 * @param client		Client index of the player selecting the item.
 * @param info			String containing the name of the item.
 **/
forward void MT_OnMenuItemSelected(int client, const char[] info);

/**
 * Called right before a player dies.
 * Use this forward to do anything before the player dies.
 *
 * @param victim		Client index of the dying player.
 * @param attacker		Client index of the killer.
 **/
forward void MT_OnPlayerEventKilled(int victim, int attacker);

/**
 * Called right before a player is hit by a bile bomb (vomit jar).
 * Use this forward to do anything before the player is hit.
 *
 * @param player		Client index of the hit player.
 * @param thrower		Client index of the survivor that threw the bile bomb (vomit jar).
 *
 * @return			Plugin_Handled to prevent the player from being hit, Plugin_Continue to allow.
 **/
forward Action MT_OnPlayerHitByVomitJar(int player, int thrower);

/**
 * Called right before a player is shoved by a survivor.
 * Use this forward to do anything before the player is shoved.
 * Note: Left 4 Dead 2 only calls this for special infected.
 *
 * @param player		Client index of the player.
 * @param survivor		Client index of the survivor.
 * @param direction		Direction of the shove.
 *
 * @return			Plugin_Handled to prevent the player from being shoved, Plugin_Continue to allow.
 **/
forward Action MT_OnPlayerShovedBySurvivor(int player, int survivor, const float direction[3]);

/**
 * Called before the config file is read.
 * Use this forward to officially register an ability's plugin.
 *
 * @param list			List to store plugin's name in.
 **/
forward void MT_OnPluginCheck(ArrayList list);

/**
 * Called when the core plugin is unloaded.
 * Use this forward to remove any modifications to Tanks or survivors.
 **/
forward void MT_OnPluginEnd();

/**
 * Called when the core plugin is updated.
 * Use this forward to reload abilities.
 * Requires "Updater": https://github.com/Teamkiller324/Updater
 **/
forward void MT_OnPluginUpdate();

/**
 * Called after a Mutant Tank spawns.
 * Use this forward for any post-spawn actions.
 * If you plan on using this to activate an ability, use MT_OnAbilityActivated() instead.
 *
 * @param tank			Client index of the Tank.
 **/
forward void MT_OnPostTankSpawn(int tank);

/**
 * Called when timers have been reset.
 * Use this forward for resetting repeating timers that use intervals set by config files.
 *
 * @param mode			0 = No client index required, 1 = Client index required
 * @param tank			Client index of a Tank.
 **/
forward void MT_OnResetTimers(int mode, int tank);

/**
 * Called when a survivor is rewarded or their reward ends.
 * Use this forward to reward survivors or to reset their rewards.
 *
 * @param survivor		Client index of the survivor.
 * @param tank			Client index of the Tank.
 * @param type			1 = Health, 2 = Damage boost, 4 = Speed boost, 8 = Ammo, 16 = Item, 32 = God mode, 64 = Health and ammo refill, 128 = Respawn,
 * 					255 = All eight rewards, 256-2147483647 = Reserved for third-party plugins
 * @param priority		0 = Killer, 1 = Assistant who did most damage, 2 = Teammate who helped, 3 = Assistant killer
 * @param duration		The duration of the reward.
 * @param apply			True if the reward is given, false otherwise.
 *
 * @return			Plugin_Handled to prevent giving or ending rewards, Plugin_Continue to allow.
 **/
forward Action MT_OnRewardSurvivor(int survivor, int tank, int &type, int priority, float &duration, bool apply);

/**
 * Called when a Mutant Tank's rock breaks.
 * Use this forward for any after-effects.
 *
 * @param tank			Client index of the Tank.
 * @param rock			Entity index of the rock.
 **/
forward void MT_OnRockBreak(int tank, int rock);

/**
 * Called when a Mutant Tank throws a rock.
 * Use this forward for any throwing abilities.
 *
 * @param tank			Client index of the Tank.
 * @param rock			Entity index of the rock.
 **/
forward void MT_OnRockThrow(int tank, int rock);

/**
 * Called when all settings are cached.
 * Use this forward to cache settings for each player.
 *
 * @param tank			Client index of the Tank.
 * @param apply			True if player is a Tank and has access to the Mutant Tank type, and needs settings to be applied, false otherwise.
 * @param type			Mutant Tank type, 0 otherwise.
 **/
forward void MT_OnSettingsCached(int tank, bool apply, int type);

/**
 * Called when a Mutant Tank type has been chosen.
 * Use this forward to check or change the chosen type.
 *
 * @param type			Type chosen.
 * @param tank			Client index of the Tank if the type chosen is being applied directly, 0 otherwise.
 *
 * @return			Plugin_Handled to choose another type, Plugin_Stop to prevent the Tank from mutating,
 * 					Plugin_Changed to change the chosen type, Plugin_Continue to allow.
 */
forward Action MT_OnTypeChosen(int &type, int tank);
```
</details>
<details>
	<summary>Natives</summary>

<details>
	<summary>Core Plugin</summary>

```
/**
 * Returns if a certain Mutant Tank type can spawn.
 *
 * @param type			Mutant Tank type.
 * @param specType		Special Infected type.
 *
 * @return			True if the type can spawn, false otherwise.
 * @error			Type is 0 or less.
 **/
native bool MT_CanTypeSpawn(int type, int specType);

/**
 * Deafens a player.
 *
 * @param player		Client index of the player.
 *
 * @error			Invalid client index, client is not in-game, or client is dead.
 **/
native void MT_DeafenPlayer(int player);

/**
 * Detonates a Tank rock on the next frame.
 *
 * @param rock			Entity index of the rock.
 *
 * @error			Invalid entity index.
 **/
native void MT_DetonateTankRock(int rock);

/**
 * Returns if a certain survivor has a reward type active.
 *
 * @param survivor		Client index of the survivor.
 * @param type			1 = Health, 2 = Damage boost, 4 = Speed boost, 8 = Ammo, 16 = Item, 32 = God mode, 64 = Health and ammo refill,
 * 					128 = Respawn, 255 = All eight rewards, 256-2147483647 = Reserved for third-party plugins
 *
 * @return			True if the survivor has the reward type active, false otherwise.
 * @error			Invalid client index, client is not in-game, or type is 0 or less.
 **/
native bool MT_DoesSurvivorHaveRewardType(int survivor, int type);

/**
 * Returns if a certain Mutant Tank type requires human-controlled survivors to be present to be effective.
 *
 * @param type			Mutant Tank type.
 * @param tank			Client index of the Tank if the type chosen is being applied directly, 0 otherwise.
 *
 * @return			True if the type requires human-controlled survivors to be present, false otherwise.
 * @error			Type is 0 or less.
 **/
native bool MT_DoesTypeRequireHumans(int type, int tank);

/**
 * Returns the current access flags set by the core plugin.
 *
 * @param mode			1 = Global flags, 2 = Type-specific flags, 3 = Global admin flags, 4 = Type-specific admin flags
 * @param type			Mutant Tank type. (Optional)
 * @param admin			Client index of an admin. (Optional)
 *
 * @return			The current access flags.
 * @error			Invalid client index, client is not in-game, client is a bot, or type is 0 or less.
 **/
native int MT_GetAccessFlags(int mode, int type = 0, int admin = -1);

/**
 * Returns the value of a combination setting based on a position.
 *
 * @param tank			Client index of the Tank.
 * @param type			1 = Chance, 2 = Cooldown, 3 = Damage, 4 = Delay, 5 = Duration, 6 = Interval, 7 = Min radius, 8 = Max radius, 9 = Range, 10 = Range chance,
 * 					11 = Range cooldown, 12 = Death range, 13 = Death range chance, 14 = Rock chance, 15 = Rock cooldown, 16 = Speed
 * @param pos			The position in the setting's array to retrieve the value from. (0-9)
 *
 * @return			The value stored in the setting.
 * @error			Invalid client index or client is not in-game.
 **/
native float MT_GetCombinationSetting(int tank, int type, int pos);

/**
 * Returns the colors set in the config file.
 *
 * @param buffer		Buffer to store the colors in.
 * @param size			Size of the buffer.
 * @param value			Value set in the config file.
 *
 * @error			Empty value or buffer is too small.
 **/
native void MT_GetConfigColors(char[] buffer, int size, const char[] value);

/**
 * Returns the current finale wave.
 *
 * @return			The current finale wave.
 **/
native int MT_GetCurrentFinaleWave();

/**
 * Returns a Mutant Tank's glow outline range.
 *
 * @param tank			Client index of the Tank.
 * @param mode			True if looking for max range, false otherwise.
 *
 * @return			The glow outline range of the Tank.
 * @error			Invalid client index or client is not in-game.
 **/
native int MT_GetGlowRange(int tank, bool mode);

/**
 * Returns a Mutant Tank's glow outline type.
 *
 * @param tank			Client index of the Tank.
 *
 * @return			The glow outline type of the Tank.
 * @error			Invalid client index or client is not in-game.
 **/
native int MT_GetGlowType(int tank);

/**
 * Returns the current immunity flags set by the core plugin.
 *
 * @param mode			1 = Global flags, 2 = Type-specific flags, 3 = Global admin flags, 4 = Type-specific admin flags
 * @param type			Mutant Tank type. (Optional)
 * @param admin			Client index of an admin. (Optional)
 *
 * @return			The current immunity flags.
 * @error			Invalid client index, client is not in-game, client is a bot, or type is 0 or less.
 **/
native int MT_GetImmunityFlags(int mode, int type = 0, int admin = -1);

/**
 * Returns the maximum value of the "Type Range" setting.
 *
 * @return			The maximum value of the "Type Range" setting.
 **/
native int MT_GetMaxType();

/**
 * Returns the minimum value of the "Type Range" setting.
 *
 * @return			The minimum value of the "Type Range" setting.
 **/
native int MT_GetMinType();

/**
 * Returns the RGBA colors given to a Mutant Tank's props.
 *
 * @param tank			Client index of the Tank.
 * @param type			1 = Light color, 2 = Oxygen tank color, 3 = Oxygen tank flames color, 4 = Rock color,
 * 					5 = Tire color, 6 = Propane tank color, 7 = Flashlight color, 8 = Crown color
 * @param red			Red color reference.
 * @param green			Green color reference.
 * @param blue			Blue color reference.
 * @param alpha			Alpha color reference.
 *
 * @error			Invalid client index, client is not in-game, or type is less than 1 or greater than 8.
 **/
native void MT_GetPropColors(int tank, int type, int &red, int &green, int &blue, int &alpha);

/**
 * Returns the recorded type of a Mutant Tank.
 *
 * @param tank			Client index of the Tank.
 * @param type			Mutant Tank type. (Optional)
 *
 * @return			The Tank's recorded Mutant Tank type.
 * @error			Invalid client index or client is not in-game.
 **/
native int MT_GetRecordedTankType(int tank, int type = 0);

/**
 * Returns a Mutant Tank's run speed.
 *
 * @param tank			Client index of the Tank.
 *
 * @return			The run speed of the Tank.
 * @error			Invalid client index or client is not in-game.
 **/
native float MT_GetRunSpeed(int tank);

/**
 * Returns the scaled damage based on difficulty.
 *
 * @param damage		Base damage to scale.
 *
 * @return			The scaled damage based on difficulty.
 **/
native float MT_GetScaledDamage(float damage);

/**
 * Returns a Mutant Tank's spawn type.
 *
 * @param tank			Client index of the Tank.
 * @param type			Mutant Tank type.
 * @param specType		Special Infected type.
 *
 * @return			The spawn type of the Tank.
 * 					0 = Normal, 1 = Boss, 2 = Randomized, 3 = Transformation, 4 = Combined abilities
 * @error			Invalid client index, client is not in-game, or client is human.
 **/
native int MT_GetSpawnType(int tank, int type = 0, int specType = 0);

/**
 * Returns the RGB colors given to a Mutant Tank.
 *
 * @param tank			Client index of the Tank.
 * @param type			1 = Skin color, 2 = Glow outline color
 * @param red			Red color reference.
 * @param green			Green color reference.
 * @param blue			Blue color reference.
 * @param alpha			Alpha color reference.
 *
 * @error			Invalid client index, client is not in-game, or type is less than 1 or greater than 2.
 **/
native void MT_GetTankColors(int tank, int type, int &red, int &green, int &blue, int &alpha);

/**
 * Returns the custom name given to a Mutant Tank.
 *
 * @param tank			Client index of the Tank.
 * @param buffer		Buffer to store the custom name in.
 *
 * @error			Invalid client index or client is not in-game.
 **/
native void MT_GetTankName(int tank, char[] buffer);

/**
 * Returns the type of a Mutant Tank.
 *
 * @param tank			Client index of the Tank.
 * @param type			Recorded Mutant Tank type. (Optional)
 *
 * @return			The Tank's Mutant Tank type.
 * @error			Invalid client index or client is not in-game.
 **/
native int MT_GetTankType(int tank, int type = 0);

/**
 * Returns if a human player has access to a Mutant Tank type.
 *
 * @param admin			Client index of the admin.
 *
 * @return			True if the human player has access, false otherwise.
 * @error			Invalid client index, client is not in-game, or client is a bot.
 **/
native bool MT_HasAdminAccess(int admin);

/**
 * Returns if a certain Mutant Tank type has a chance of spawning.
 *
 * @param type			Mutant Tank type.
 * @param tank			Client index of the Tank.
 *
 * @return			True if the type has a chance of spawning, false otherwise.
 * @error			Type is 0 or less.
 **/
native bool MT_HasChanceToSpawn(int type, int tank);

/**
 * Hooks/unhooks any entity to/from the core plugin's SetTransmit callback.
 *
 * @param entity		Entity index of the entity.
 * @param mode			True if hooking entity, false otherwise.
 *
 * @error			Invalid entity index.
 **/
native void MT_HideEntity(int entity, bool mode);

/**
 * Returns if a human survivor is immune to a Mutant Tank's attacks.
 *
 * @param survivor		Client index of the survivor.
 * @param tank			Client index of the Tank.
 *
 * @return			True if the human survivor is immune, false otherwise.
 * @error			Invalid survivor index, survivor is not in-game, survivor is dead, survivor is a bot, survivor is idle,
 * 					invalid Tank index, or Tank is not in-game.
 **/
native bool MT_IsAdminImmune(int survivor, int tank);

/**
 * Returns if the core plugin is enabled.
 *
 * @return			True if core plugin is enabled, false otherwise.
 **/
native bool MT_IsCorePluginEnabled();

/**
 * Returns if a custom Tank is allowed to be a Mutant Tank.
 *
 * @param tank			Client index of the Tank.
 *
 * @return			True if the custom Tank is allowed to be a Mutant Tank, false otherwise.
 * @error			Invalid client index, client is not in-game, or client is dead.
 **/
native bool MT_IsCustomTankSupported(int tank);

/**
 * Returns if a certain Mutant Tank type is only available on finale maps.
 *
 * @param type			Mutant Tank type.
 * @param tank			Client index of the Tank.
 *
 * @return			True if the type is available, false otherwise.
 * @error			Type is 0 or less.
 **/
native bool MT_IsFinaleType(int type, int tank);

/**
 * Returns if a Mutant Tank type has a glow outline.
 *
 * @param tank			Client index of the Tank.
 *
 * @return			True if the Tank has a glow outline, false otherwise.
 * @error			Invalid client index or client is not in-game.
 **/
native bool MT_IsGlowEnabled(int tank);

/**
 * Returns if a Mutant Tank type's glow outline is flashing.
 *
 * @param tank			Client index of the Tank.
 *
 * @return			True if the Tank's glow outline is flashing, false otherwise.
 * @error			Invalid client index or client is not in-game.
 **/
native bool MT_IsGlowFlashing(int tank);

/**
 * Returns if a certain Mutant Tank type is only available on non-finale maps.
 *
 * @param type			Mutant Tank type.
 * @param tank			Client index of the Tank.
 *
 * @return			True if the type is available, false otherwise.
 * @error			Type is 0 or less.
 **/
native bool MT_IsNonFinaleType(int type, int tank);

/**
 * Returns if a Tank is idle.
 *
 * @param tank			Client index of the Tank.
 * @param type			Idle mode of the Tank. 0 = Both, 1 = Idle (waiting for survivors), 2 = Bugged (no behavior)
 *
 * @return			True if the Tank is idle, false otherwise.
 * @error			Invalid client index, client is not in-game, client is dead, or type is less than 0 or greater than 2.
 **/
native bool MT_IsTankIdle(int tank, int type = 0);

/**
 * Returns if a Tank is allowed to be a Mutant Tank.
 *
 * @param tank			Client index of the Tank.
 * @param flags			Checks to run.
 * 					MT_CHECK_INDEX = client index, MT_CHECK_CONNECTED = connection, MT_CHECK_INGAME = in-game status,
 * 					MT_CHECK_ALIVE = life state, MT_CHECK_INKICKQUEUE = kick status, MT_CHECK_FAKECLIENT = bot check
 * 					Default: MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_ALIVE
 *
 * @return			True if the Tank is allowed to be a Mutant Tank, false otherwise.
 * @error			Invalid client index, client is not in-game, or client is dead.
 **/
native bool MT_IsTankSupported(int tank, int flags = MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_ALIVE);

/**
 * Returns if a certain Mutant Tank type is enabled.
 *
 * @param type			Mutant Tank type.
 * @param tank			Client index of the Tank.
 *
 * @return			True if the type is enabled, false otherwise.
 * @error			Type is 0 or less.
 **/
native bool MT_IsTypeEnabled(int type, int tank);

/**
 * Logs a message.
 *
 * @param type			Type of message to be logged.
 * @param message		Buffer containing the message.
 * @param ...			Variable number of format parameters.
 **/
native void MT_LogMessage(int type = MT_LOG_CUSTOM, const char[] message, any ...);

/**
 * Respawns a survivor.
 *
 * @param survivor		Client index of the survivor.
 *
 * @error			Invalid client index, client is not in-game, or client is dead.
 **/
native void MT_RespawnSurvivor(int survivor);

/**
 * Sets a Tank's Mutant Tank type.
 *
 * @param tank			Client index of the Tank.
 * @param type			Mutant Tank type.
 * @param mode			True if the Tank should transform physically into the new Mutant Tank type, false otherwise.
 *
 * @error			Invalid client index, client is not in-game, client is dead, or type is 0 or less.
 **/
native void MT_SetTankType(int tank, int type, bool mode);

/**
 * Shoves a player toward a certain direction.
 *
 * @param player		Client index of the player.
 * @param survivor		Client index of the survivor.
 * @param direction		Direction of the shove.
 *
 * @error			Invalid client index, client is not in-game, or client is dead.
 **/
native void MT_ShoveBySurvivor(int player, int survivor, float direction[3]);

/**
 * Spawns a Tank with the specified Mutant Tank type.
 *
 * @param tank			Client index of the Tank.
 * @param type			Mutant Tank type.
 *
 * @error			Invalid client index, client is not in-game, or type is 0 or less.
 **/
native void MT_SpawnTank(int tank, int type);

/**
 * Staggers a player from a certain direction.
 *
 * @param player		Client index of the player.
 * @param pusher		Client index of the pusher.
 * @param direction		Direction of the stagger.
 *
 * @error			Invalid client index, client is not in-game, or client is dead.
 **/
native void MT_StaggerPlayer(int player, int pusher, float direction[3]);

/**
 * Gets or sets a Tank's max health.
 *
 * @param tank			Client index of the Tank.
 * @param mode			1 = Get the Tank's max health, 2 = Get the Tank's stored max health,
 * 					3 = Set the Tank's max health without storing it, 4 = Set the Tank's max health and store it
 * @param newHealth		The Tank's new max health.
 **/
native int MT_TankMaxHealth(int tank, int mode, int newHealth = 0);

/**
 * Removes the vomit effect on a player.
 *
 * @param player		Client index of the player.
 *
 * @error			Invalid client index, client is not in-game, or client is dead.
 **/
native void MT_UnvomitPlayer(int player);

/**
 * Sets the vomit effect on a player.
 *
 * @param player		Client index of the player.
 * @param boomer		Client index of the Boomer.
 *
 * @error			Invalid client index, client is not in-game, or client is dead.
 **/
native void MT_VomitPlayer(int player);
```
</details>
<details>
	<summary>Clone Ability</summary>

```
/**
 * Returns if the clone can use abilities.
 *
 * @param tank			Client index of the Tank.
 *
 * @return			True if clone can use abilities, false otherwise.
 * @error			Invalid client index.
 **/
native bool MT_IsCloneSupported(int tank);

/**
 * Returns if a Tank is a clone.
 *
 * @param tank			Client index of the Tank.
 *
 * @return			True if the Tank is a clone, false otherwise.
 * @error			Invalid client index.
 **/
native bool MT_IsTankClone(int tank);
```
</details>
</details>
<details>
	<summary>Stocks</summary>

```
stock void MT_LoadPlugin(Handle plugin = null)
{
	char sFilename[64];
	GetPluginFilename(plugin, sFilename, sizeof sFilename);
	ServerCommand("sm plugins load %s", sFilename);
}

stock void MT_PrintToChat(int client, const char[] message, any ...)
{
	if (!bIsValidClient(client, MT_CHECK_INDEX))
	{
		ThrowError("Invalid client index %i", client);
	}

	if (!bIsValidClient(client, MT_CHECK_INGAME))
	{
		ThrowError("Client %i is not in game", client);
	}

	char sBuffer[1024], sMessage[1024];
	SetGlobalTransTarget(client);
	FormatEx(sMessage, sizeof sMessage, "\x01%s", message);
	VFormat(sBuffer, sizeof sBuffer, sMessage, 3);
	MT_ReplaceChatPlaceholders(sBuffer, sizeof sBuffer, false);
	PrintToChat(client, sBuffer);
}

stock void MT_PrintToChatAll(const char[] message, any ...)
{
	char sBuffer[1024];
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsValidClient(iPlayer, MT_CHECK_INGAME|MT_CHECK_FAKECLIENT))
		{
			SetGlobalTransTarget(iPlayer);
			VFormat(sBuffer, sizeof sBuffer, message, 2);
			MT_PrintToChat(iPlayer, sBuffer);
		}
	}
}

stock void MT_PrintToConsole(int client, const char[] message, any ...)
{
	char sBuffer[1024];
	SetGlobalTransTarget(client);
	VFormat(sBuffer, sizeof sBuffer, message, 3);
	MT_ReplaceChatPlaceholders(sBuffer, sizeof sBuffer, true);
	PrintToConsole(client, sBuffer);
}

stock void MT_PrintToServer(const char[] message, any ...)
{
	char sBuffer[1024];
	SetGlobalTransTarget(LANG_SERVER);
	VFormat(sBuffer, sizeof sBuffer, message, 2);
	MT_ReplaceChatPlaceholders(sBuffer, sizeof sBuffer, true);
	PrintToServer(sBuffer);
}

stock void MT_ReplaceChatPlaceholders(char[] buffer, int size, bool empty)
{
	ReplaceString(buffer, size, "{default}", (empty ? "" : "\x01"));
	ReplaceString(buffer, size, "{mint}", (empty ? "" : "\x03"));
	ReplaceString(buffer, size, "{yellow}", (empty ? "" : "\x04"));
	ReplaceString(buffer, size, "{olive}", (empty ? "" : "\x05"));
	ReplaceString(buffer, size, "{percent}", "%%");

	if (empty)
	{
		ReplaceString(buffer, size, "\x01", "");
		ReplaceString(buffer, size, "\x03", "");
		ReplaceString(buffer, size, "\x04", "");
		ReplaceString(buffer, size, "\x05", "");
	}
}

stock void MT_ReloadPlugin(Handle plugin = null)
{
	char sFilename[64];
	GetPluginFilename(plugin, sFilename, sizeof sFilename);
	ServerCommand("sm plugins reload %s", sFilename);
}

stock void MT_ReplyToCommand(int client, const char[] message, any ...)
{
	char sBuffer[1024];
	SetGlobalTransTarget(client);
	VFormat(sBuffer, sizeof sBuffer, message, 3);

	if (GetCmdReplySource() == SM_REPLY_TO_CONSOLE)
	{
		MT_ReplaceChatPlaceholders(sBuffer, sizeof sBuffer, true);

		switch (client == 0)
		{
			case true: PrintToServer(sBuffer);
			case false: PrintToConsole(client, sBuffer);
		}
	}
	else
	{
		MT_PrintToChat(client, sBuffer);
	}
}

stock void MT_TE_SetupParticleAttachment(int particle, int attachment, int entity, bool follow = false)
{
	static bool bSecondGame = false;
	static EngineVersion evEngine = Engine_Unknown;
	if (evEngine == Engine_Unknown)
	{
		evEngine = GetEngineVersion();
		bSecondGame = (evEngine == Engine_Left4Dead2);
	}

	TE_Start("EffectDispatch");

	static float flDummy[3] = {0.0, 0.0, 0.0};
	TE_WriteFloat((bSecondGame ? "m_vOrigin.x" : "m_vOrigin[0]"), flDummy[0]);
	TE_WriteFloat((bSecondGame ? "m_vOrigin.y" : "m_vOrigin[1]"), flDummy[1]);
	TE_WriteFloat((bSecondGame ? "m_vOrigin.z" : "m_vOrigin[2]"), flDummy[2]);
	TE_WriteFloat((bSecondGame ? "m_vStart.x" : "m_vStart[0]"), flDummy[0]);
	TE_WriteFloat((bSecondGame ? "m_vStart.y" : "m_vStart[1]"), flDummy[1]);
	TE_WriteFloat((bSecondGame ? "m_vStart.z" : "m_vStart[2]"), flDummy[2]);

	static int iEffect = INVALID_STRING_INDEX;
	if (iEffect < 0)
	{
		iEffect = MT_FindStringIndex(FindStringTable("EffectDispatch"), "ParticleEffect");
		if (iEffect == INVALID_STRING_INDEX)
		{
			return;
		}
	}

	TE_WriteNum("m_iEffectName", iEffect);
	TE_WriteNum("m_nHitBox", particle);
	TE_WriteNum("entindex", entity);
	TE_WriteNum("m_nAttachmentIndex", attachment);
	TE_WriteNum("m_fFlags", 1);
	TE_WriteVector("m_vAngles", flDummy);
	TE_WriteFloat("m_flMagnitude", 0.0);
	TE_WriteFloat("m_flScale", 1.0);
	TE_WriteFloat("m_flRadius", 0.0);

	switch (bSecondGame)
	{
		case true: TE_WriteNum("m_nDamageType", (follow ? 5 : 4));
		case false: TE_WriteNum("m_nDamageType", (follow ? 4 : 3));
	}
}

stock void MT_TE_SetupStopAllParticles(int entity)
{
	static bool bSecondGame = false;
	static EngineVersion evEngine = Engine_Unknown;
	if (evEngine == Engine_Unknown)
	{
		evEngine = GetEngineVersion();
		bSecondGame = (evEngine == Engine_Left4Dead2);
	}

	TE_Start("EffectDispatch");

	static float flDummy[3] = {0.0, 0.0, 0.0};
	TE_WriteFloat((bSecondGame ? "m_vOrigin.x" : "m_vOrigin[0]"), flDummy[0]);
	TE_WriteFloat((bSecondGame ? "m_vOrigin.y" : "m_vOrigin[1]"), flDummy[1]);
	TE_WriteFloat((bSecondGame ? "m_vOrigin.z" : "m_vOrigin[2]"), flDummy[2]);
	TE_WriteFloat((bSecondGame ? "m_vStart.x" : "m_vStart[0]"), flDummy[0]);
	TE_WriteFloat((bSecondGame ? "m_vStart.y" : "m_vStart[1]"), flDummy[1]);
	TE_WriteFloat((bSecondGame ? "m_vStart.z" : "m_vStart[2]"), flDummy[2]);

	static int iEffect = INVALID_STRING_INDEX;
	if (iEffect < 0)
	{
		iEffect = MT_FindStringIndex(FindStringTable("EffectDispatch"), "ParticleEffectStop");
		if (iEffect == INVALID_STRING_INDEX)
		{
			return;
		}
	}

	TE_WriteNum("m_iEffectName", iEffect);
	TE_WriteNum("m_nHitBox", 0);
	TE_WriteNum("entindex", entity);
	TE_WriteNum("m_nAttachmentIndex", 0);
	TE_WriteNum("m_fFlags", 1);
	TE_WriteVector("m_vAngles", flDummy);
	TE_WriteFloat("m_flMagnitude", 0.0);
	TE_WriteFloat("m_flScale", 0.0);
	TE_WriteFloat("m_flRadius", 0.0);
	TE_WriteNum("m_nDamageType", 0);
}

stock void MT_TeleportPlayerAhead(int player, const float origin[3], const float angles[3], const float velocity[3], const float direction[3], const float distance)
{
	float flPos[3];
	flPos[0] = origin[0] + (direction[0] * distance);
	flPos[1] = origin[1] + (direction[1] * distance);
	flPos[2] = origin[2];

	TeleportEntity(player, flPos, angles, velocity);
	vFixPlayerPosition(player, false);
}

stock void MT_UnloadPlugin(Handle plugin = null)
{
	char sFilename[64];
	GetPluginFilename(plugin, sFilename, sizeof sFilename);
	ServerCommand("sm plugins unload %s", sFilename);
}

stock bool MT_FileExists(const char[] folder, const char[] filename, const char[] path, char[] output, int size, bool use_valve_fs = false, const char[] valve_path_id = "GAME")
{
	if (FileExists(path, use_valve_fs, valve_path_id))
	{
		char sDirectory[PLATFORM_MAX_PATH], sOutput[PLATFORM_MAX_PATH];
		BuildPath(Path_SM, sDirectory, sizeof sDirectory, folder);
		vGetMatchingFilename(sDirectory, filename, sOutput, sizeof sOutput);
		if (!StrEqual(filename, sOutput))
		{
			char sTemp[PLATFORM_MAX_PATH];
			FormatEx(sTemp, sizeof sTemp, "%s%s", sDirectory, sOutput);
			strcopy(output, size, sTemp);
		}

		return true;
	}

	return false;
}

stock bool MT_TE_CreateParticle(float startPos[3] = {0.0, 0.0, 0.0}, float endPos[3] = {0.0, 0.0, 0.0}, int particle = -1, int entity = 0, float delay = 0.0, bool all = true, char name[64] = "", int attachment = 0, float angles[3] = {0.0, 0.0, 0.0}, int flags = 0, int damageType = 0, float magnitude = 0.0, float scale = 1.0, float radius = 0.0)
{
	static bool bSecondGame = false;
	static EngineVersion evEngine = Engine_Unknown;
	if (evEngine == Engine_Unknown)
	{
		evEngine = GetEngineVersion();
		bSecondGame = (evEngine == Engine_Left4Dead2);
	}

	TE_Start("EffectDispatch");

	TE_WriteFloat((bSecondGame ? "m_vOrigin.x" : "m_vOrigin[0]"), startPos[0]);
	TE_WriteFloat((bSecondGame ? "m_vOrigin.y" : "m_vOrigin[1]"), startPos[1]);
	TE_WriteFloat((bSecondGame ? "m_vOrigin.z" : "m_vOrigin[2]"), startPos[2]);
	TE_WriteFloat((bSecondGame ? "m_vStart.x" : "m_vStart[0]"), endPos[0]);
	TE_WriteFloat((bSecondGame ? "m_vStart.y" : "m_vStart[1]"), endPos[1]);
	TE_WriteFloat((bSecondGame ? "m_vStart.z" : "m_vStart[2]"), endPos[2]);

	static int iEffect = INVALID_STRING_INDEX;
	if (iEffect < 0)
	{
		iEffect = MT_FindStringIndex(FindStringTable("EffectDispatch"), "ParticleEffect");
		if (iEffect == INVALID_STRING_INDEX)
		{
			return false;
		}
	}

	TE_WriteNum("m_iEffectName", iEffect);

	if (particle < 0)
	{
		static int iParticleString = INVALID_STRING_INDEX;
		iParticleString = MT_FindStringIndex(iEffect, name);
		if (iParticleString == INVALID_STRING_INDEX)
		{
			return false;
		}

		TE_WriteNum("m_nHitBox", iParticleString);
	}
	else
	{
		TE_WriteNum("m_nHitBox", particle);
	}

	TE_WriteNum("entindex", entity);
	TE_WriteNum("m_nAttachmentIndex", attachment);
	TE_WriteVector("m_vAngles", angles);
	TE_WriteNum("m_fFlags", flags);
	TE_WriteFloat("m_flMagnitude", magnitude);
	TE_WriteFloat("m_flScale", scale);
	TE_WriteFloat("m_flRadius", radius);
	TE_WriteNum("m_nDamageType", damageType);

	if (all)
	{
		TE_SendToAll(delay);
	}

	return true;
}

stock float MT_GetRandomFloat(float min, float max)
{
	return (GetURandomFloat() * (max - min)) + min;
}

stock int MT_AddCommasToFloat(float number, char[] output, int size)
{
	int iPos = 0, iPos2 = 0, iSize = 0;
	if (number < 0.0)
	{
		output[iPos++] = '-';
		number = -number;
	}

	char sTemp[18], sSet[2][18];
	FormatEx(sTemp, sizeof sTemp, "%.2f", number);
	ExplodeString(sTemp, ".", sSet, sizeof sSet, sizeof sSet[]);

	iSize = strlen(sSet[0]);
	if (iSize <= 3)
	{
		iPos += strcopy(output[iPos], size, sTemp);
	}
	else
	{
		while (iPos2 < iSize && iPos < size)
		{
			output[iPos++] = sSet[0][iPos2++];

			if ((iSize - iPos2) && !((iSize - iPos2) % 3))
			{
				output[iPos++] = ',';
			}
		}

		output[iPos] = '\0';
		Format(output, size, "%s.%s", output, sSet[1]);
	}

	return iPos;
}

stock int MT_AddCommasToInt(int number, char[] output, int size)
{
	int iPos = 0, iPos2 = 0, iSize = 0;
	if (number < 0)
	{
		output[iPos++] = '-';
		number = (number ^ (number >> 31)) - (number >> 31);
	}

	char sTemp[15];
	iSize = IntToString(number, sTemp, sizeof sTemp);
	if (iSize <= 3)
	{
		iPos += strcopy(output[iPos], size, sTemp);
	}
	else
	{
		while (iPos2 < iSize && iPos < size)
		{
			output[iPos++] = sTemp[iPos2++];

			if ((iSize - iPos2) && !((iSize - iPos2) % 3))
			{
				output[iPos++] = ',';
			}
		}

		output[iPos] = '\0';
	}

	return iPos;
}

stock int MT_FindStringIndex(int index, const char[] search)
{
	char sBuffer[1024];
	int iStrings = GetStringTableNumStrings(index);
	for (int iPos = 0; iPos < iStrings; iPos++)
	{
		ReadStringTable(index, iPos, sBuffer, sizeof sBuffer);

		if (StrEqual(sBuffer, search))
		{
			return iPos;
		}
	}

	return INVALID_STRING_INDEX;
}

stock int MT_GetParticleIndex(const char[] particlename)
{
	static int iTable = INVALID_STRING_TABLE;
	if (iTable == INVALID_STRING_TABLE)
	{
		iTable = FindStringTable("ParticleEffectNames");
		if (iTable == INVALID_STRING_TABLE)
		{
			return INVALID_STRING_TABLE;
		}
	}

	int iParticleString = MT_FindStringIndex(iTable, particlename);
	if (iParticleString == INVALID_STRING_INDEX)
	{
		iParticleString = iPrecacheParticle(particlename);
	}

	return iParticleString;
}

stock int MT_GetRandomInt(int min, int max)
{
	return RoundToNearest(GetURandomFloat() * float(max - min)) + min;
}
```
</details>
<details>
	<summary>Target Filters</summary>

```
@smokers
@boomers
@hunters
@spitters
@jockeys
@chargers
@tanks
@special
@infected
@mutants
@mtanks
@psytanks
@msmokers
@psysmokers
@mboomers
@psyboomers
@mhunters
@psyhunters
@mspitters
@psyspitters
@mjockeys
@psyjockeys
@mchargers
@psychargers
```
</details>
<details>
	<summary>Commands</summary>

```
// Requires "z" (Root) flag.
sm_tank - Spawn a Mutant Tank.
sm_mt_tank - Spawn a Mutant Tank.

Valid inputs:

1. sm_tank <type 1*-500*> <amount: 1-32> <0: spawn on crosshair|1: spawn automatically> <0: not blind|1: blind> *The minimum and maximum values are determined by "Type Range". (The lowest value you can set is "1" and the highest value you can set is "500" though.)
2. sm_tank <type name*> <amount: 1-32> <0: spawn on crosshair|1: spawn automatically> <0: not blind|1: blind> *The plugin will attempt to match the name with any of the Mutant Tank types' names. (Partial names are acceptable. If more than 1 match is found, a random match is chosen. If 0 matches are found, the command cancels the request.)

The command has 4 functions.

If you are not a Tank:

1. When facing a non-Tank entity, a Mutant Tank will spawn with the chosen type.
2. When facing a Tank, it will switch to the chosen type.

If you are a Tank:

1. When holding down the +speed (default: LSHIFT) button, a Mutant Tank will spawn into the chosen type.
2. When not holding down the +speed (default: LSHIFT) button, you will transform into the chosen type.
```
</details>
</details>
</details>

### Configuration Formatting
<details>
	<summary>Click to expand!</summary>

<details>
	<summary>Question 1</summary>

1. How many config formats are there?

At the moment, there are 4 different formats.
</details>
<details>
	<summary>Question 2</summary>

2. Do I need to edit my current config file from version `v8.57` and below?

No, all plugins still read the original format properly.
</details>
<details>
	<summary>Question 3</summary>

3. Which config format should I use?

Whichever one you want. You are free to combine all of them as well, it doesn't matter. For consistency and to avoid confusion, this file and any other file with config examples will use the original format.

<details>
	<summary>Example</summary>

```
// Original format
"Mutant Tanks"
{
	"Plugin Settings"
	{
		"Game Modes"
		{
			"Game Mode Types"			"0"
		}
	}
}

// Custom format
mutant_tanks // 3rd format
{
	Settings // 4th format
	{
		GameModes // 2nd format
		{
			"Game Mode Types"			0 // original format
		}
	}
}
```
</details>
</details>
<details>
	<summary>Question 4</summary>

4. Is it possible to configure more than one type in one section?

Yes, you can either apply global settings for all types to use or specify certain types to use them.

<details>
	<summary>Example</summary>

```
"Mutant Tanks"
{
	// Applies to every type.
	"All"
	{
		"Health"
		{
			"Extra Health"				"1000"
		}
	}
	// Applies to types 1 and 10.
	"1,10"
	{
		"Health"
		{
			"Extra Health"				"1000"
		}
	}
	// Applies to types 11 through 20.
	"11-20"
	{
		"Health"
		{
			"Extra Health"				"1000"
		}
	}
	// Applies to types 21 through 30 and types 31 through 40.
	"21-30,31-40"
	{
		"Health"
		{
			"Extra Health"				"1000"
		}
	}
}
```
</details>
</details>
<details>
	<summary>Question 5</summary>

5. Is it possible to configure more than one ability in one section?

Yes, you can either apply global settings for all abilities to use or specify certain abilities to use them.

<details>
	<summary>Example</summary>

```
"Mutant Tanks"
{
	"Tank #1"
	{
		// Applies to every ability.
		"All"
		{
			"Ability Enabled"			"1"
		}
		// Applies to Absorb and Acid abilities.
		"Absorb,Acid"
		{
			"Ability Enabled"			"1"
		}
	}
}
```
</details>
</details>
</details>

### Administration System
<details>
	<summary>Click to expand!</summary>

<details>
	<summary>Question 1</summary>

1. How does the system work?

The administration system is designed for the usage and effectiveness of each Mutant Tank type. Basically, it controls and determines what kind of Mutant Tanks players can use or be immune from.
</details>
<details>
	<summary>Question 2</summary>

2. Why create an entirely new administration system instead of using SourceMod's own system?

At first, using SM's own system was the goal, but that system has certain limitations that I wanted to get rid of for this project. For example, in SM's system, assigning multiple flags to an override command requires admins to have all of those flags. In this system, admins only need one of those flags, which makes the system flexible for filtering multiple admin flags.

<details>
	<summary>Example</summary>

```
// SM's system
"sm_tank"			"abc" // Admins need all three flags to use the command.

// MT's system
"Access Flags"			"abc" // Admins only need one of these flags to access a Mutant Tank type.
```
</details>
</details>
<details>
	<summary>Question 3</summary>

3. What are the admin flags used for?

The flags are used for two things:
- Accessibility - What Mutant Tank types admins can access.
- Immunity - What Mutant Tank types admins are immune to.
</details>
<details>
	<summary>Question 4</summary>

4. What other features does the system have?

Currently, the system allows admins to each have a favorite/custom/personalized Mutant Tank type.

Each custom admin setting will override its corresponding Mutant Tank type-specific setting or general setting. This is a powerful feature because each admin can have his/her own custom-made Mutant Tank type without tampering with the Mutant Tank type settings or general settings.

<details>
	<summary>Example</summary>

```
"Mutant Tanks"
{
	"STEAM_0:1:23456789"
	{
		"General"
		{
			"Tank Name"				"Awesome Player" // Admin-controlled Tanks will have this name.
		}
	}
	"Tank #1"
	{
		"General"
		{
			"Tank Name"				"Awesome AI" // AI Tanks will have this name.
		}
	}
}
```
</details>
</details>
<details>
	<summary>Question 5</summary>

5. How does the override feature work?

It will sound complicated but here is the simplest way to explain it:

<details>
	<summary>Ability Overrides</summary>

```
If a player's ability flags have one of the access flags required for an ability or vice-versa, the player will have access to the ability.
If a player's ability flags have one of the immunity flags required for an ability or vice-versa, the player will have immunity from the ability.

OR

If a player's type flags have one of the access flags required for an ability or vice-versa, the player will have access to the ability.
If a player's type flags have one of the immunity flags required for an ability or vice-versa, the player will have immunity from the ability.

OR

If a player's general MT flags have one of the access flags required for an ability or vice-versa, the player will have access to the ability.
If a player's general MT flags have one of the immunity flags required for an ability or vice-versa, the player will have immunity from the ability.

OR

If a player's SM flags have one of the access flags required for an ability or vice-versa, the player will have access to the ability.
If a player's SM flags have one of the immunity flags required for an ability or vice-versa, the player will have immunity from the ability.

Note: If all 4 of these return false, the player will not have access to nor immunity from that ability.
```
</details>
<details>
	<summary>Type Overrides</summary>

```
If a player's ability flags have one of the access flags required for a type or vice-versa, the player will have access to the ability of the type.
If a player's ability flags have one of the immunity flags required for a type or vice-versa, the player will have immunity from the ability of the type.

OR

If a player's type flags have one of the access flags required for a type or vice-versa, the player will have access to the type.
If a player's type flags have one of the immunity flags required for a type or vice-versa, the player will have immunity from the type.

OR

If a player's general MT flags have one of the access flags required for a type or vice-versa, the player will have access to the type.
If a player's general MT flags have one of the immunity flags required for a type or vice-versa, the player will have immunity from the type.

OR

If a player's SM flags have one of the access flags required for a type or vice-versa, the player will have access to the type.
If a player's SM flags have one of the immunity flags required for a type or vice-versa, the player will have immunity from the type.

Note: If all 4 of these return false, the player will not have access to nor immunity from that type.
```
</details>
<details>
	<summary>Global Overrides</summary>

```
If a player's ability flags have one of the access flags required globally or vice-versa, the player will have access to all abilities that require those flags.
If a player's ability flags have one of the immunity flags required globally or vice-versa, the player will have immunity from all abilities that require those flags.

OR

If a player's type flags have one of the access flags required globally or vice-versa, the player will have access to all types that require those flags.
If a player's type flags have one of the immunity flags required globally or vice-versa, the player will have immunity from all types that require those flags.

OR

If a player's general MT flags have one of the access flags required globally or vice-versa, the player will have access to all types and abilities that require those flags.
If a player's general MT flags have one of the immunity flags required globally or vice-versa, the player will have immunity from all types and abilities that require those flags.

OR

If a player's SM flags have one of the access flags required globally or vice-versa, the player will have access to all types and abilities that require those flags.
If a player's SM flags have one of the immunity flags required globally or vice-versa, the player will have immunity from all types and abilities that require those flags.

Note: If all 4 of these return false, the player will not have access to nor immunity from anything.
```
</details>
</details>
<details>
	<summary>Question 6</summary>

6. What is the `sm_mt_dev` command for?

The command allows the developer (`Psyk0tik`) to access certain features of the project on your server. These features include:
- Access to all Mutant Tanks. (Allows the developer to see what Mutant Tanks your config has.)
- Immunity from all Mutant Tanks. (Allows the developer to test each Mutant Tank without having to deal with each ability's effects.)
- Ability to spawn Mutant Tanks. (Allows the developer to spawn each Mutant Tank for testing.)
- Check which abilities are installed. (Allows the developer to check which abilities to test for.)

In short, this command does not give the developer access to other features or plugins, thus avoiding the potential to cause trouble on your server. Disable the command if you are not confident with trusting the developer. This command was added to help server owners give the developer temporary access in case the developer needs to help server owners debug problems.
</details>
</details>

### Human Support
<details>
	<summary>Click to expand!</summary>

<details>
	<summary>Question 1</summary>

1. How do I enable human support?

Set `Human Support` to `1` or `2`.
</details>
<details>
	<summary>Question 2</summary>

2. Can players use the abilities automatically/manually?

Yes, just set `Human Ability` to 1 or 2 for EACH ability.

<details>
	<summary>Example</summary>

```
"Mutant Tanks"
{
	"Tank #1"
	{
		"Fast Ability"
		{
			"Human Ability"				"1"
		}
	}
}
```
</details>
</details>
<details>
	<summary>Question 3</summary>

3. How can players use the abilities manually?

There are 4 buttons that players can use when they spawn as Mutant Tanks.
```
+use (default: E) - Main ability
+reload (default: R) - Sub/range ability
+zoom (default: Mouse3/Scroll wheel) - Special ability
+duck (default: CTRL) - Upon-death ability
```

Whatever each button activates is entirely up to your configuration settings.
</details>
<details>
	<summary>Question 4</summary>

4. How do I change the buttons or add extra buttons?

Edit lines `104-107` of the `mutant_tanks.inc` file and recompile each ability plugin.
</details>
<details>
	<summary>Question 5</summary>

5. What happens if a Mutant Tank has multiple abilities that are all activated by the same button?

All related abilities may or may not activate at the same time, depending on your configuration settings. It is recommended to not stack many abilities for human-controlled Mutant Tanks.
</details>
<details>
	<summary>Question 6</summary>

6. How do I limit the usage of abilities for each player?

Set the `Human Ammo` setting for each ability to whatever value you want.

<details>
	<summary>Example</summary>

```
"Mutant Tanks"
{
	"Tank #1"
	{
		"Fast Ability"
		{
			"Human Ammo"				"5"
		}
	}
}
```
</details>
</details>
<details>
	<summary>Question 7</summary>

7. Can I add a cooldown to the usage of abilities for each player?

Yes, just set the `Human Cooldown` setting for each ability to whatever value you want.

<details>
	<summary>Example</summary>

```
"Mutant Tanks"
{
	"Tank #1"
	{
		"Fast Ability"
		{
			"Human Cooldown"			"30"
		}
	}
}
```
</details>
</details>
<details>
	<summary>Question 8</summary>

8. What is the `Human Duration` setting for in some of the abilities?

That setting is a special duration for players, but they only apply if the `Human Mode` setting is set to `0`.

Furthermore, there are some duration settings for abilities that will also affect players. Read the `INFORMATION.md` file for more details.
</details>
<details>
	<summary>Question 9</summary>

9. What is the `Human Mode` setting for in some of the abilities?

That setting is a special mode setting for players, which can determine how some abilities are activated. Read the `INFORMATION.md` file for more details.
</details>
<details>
	<summary>Question 10</summary>

10. Is there any way players can view information about this feature in-game?

Yes, use the `sm_mt_ability`/`sm_mt_ability2` commands.

The commands will each provide a menu that players can use to display certain information in chat.

The information displayed in chat will be more detailed and accurate when the player is playing as a Mutant Tank.
</details>
<details>
	<summary>Question 11</summary>

11. Is there any way players can change their current Mutant Tank type in the middle of a fight?

Yes, players can use the `sm_mutanttank` command if the `Spawn Mode` setting under the `Human Support` section under the `Plugin Settings` section is set to `0`. There will be a cooldown though to prevent abuse.
</details>
<details>
	<summary>Question 12</summary>

12. Is there any way to exempt admins from the cooldown mentioned in question `#11`?

Yes, assign admins the `mt_adminversus` override.

<details>
	<summary>Example</summary>

```
Overrides
{
	"mt_adminversus"		"z" // All admins with the "z" (Root) flag are exempted from cooldowns.
}
```
</details>
</details>
</details>

### Configuration
<details>
	<summary>Click to expand!</summary>

<details>
	<summary>Question 1</summary>

1. How do I enable the custom configurations features?

Set `Enable Custom Configs` to `1`.
</details>
<details>
	<summary>Question 2</summary>

2. How do I tell the plugin to only create certain custom config files?

Set the values in `Create Config Types`.

<details>
	<summary>Examples</summary>

```
"Create Config Types" "7" // Creates the folders and config files for each difficulty, map, and game mode.
"Create Config Types" "8" // Creates the folder and config files for each day.
"Create Config Types" "31" // Creates the folders and config files for each difficulty, map, game mode, day, and player count.
"Create Config Types" "255" // Creates the folders and config files for each difficulty, map, game mode, day, player (survivor/infected/all) count, and finale stage.
```
</details>
</details>
<details>
	<summary>Question 3</summary>

3. How do I tell the plugin to only execute certain custom config files?

Set the values in `Execute Config Types`.

<details>
	<summary>Examples</summary>

```
"Execute Config Types" "7" // Executes the config file for the current difficulty, map, and game mode.
"Execute Config Types" "8" // Executes the config file for the current day.
"Execute Config Types" "31" // Executes the config file for the current difficulty, map, game mode, day, and player count.
"Execute Config Types" "255" // Executes the config file for the current difficulty, map, game mode, day, player (survivor/infected/all) count, and finale stage.
```
</details>
</details>
</details>

## Credits
<details>
	<summary>Click to expand!</summary>

**Machine** - For the [[L4D2] Super Tanks](https://forums.alliedmods.net/showthread.php?t=165858) plugin.

**NgBUCKWANGS** - For the mapname.cfg code in his [[L4D2] ABM](https://forums.alliedmods.net/showthread.php?t=291562) plugin.

**Spirit_12** - For the L4D signatures for the gamedata file.

**honorcode23** - For the [[L4D & L4D2] New Custom Commands](https://forums.alliedmods.net/showthread.php?t=133475) plugin.

**panxiaohai** - For the [[L4D & L4D2] We Can Not Survive Alone](https://forums.alliedmods.net/showthread.php?t=167389), [[L4D & L4D2] Melee Weapon Tank](https://forums.alliedmods.net/showthread.php?t=166356), [[L4D & L4D2] Tank's Power](https://forums.alliedmods.net/showthread.php?t=134537), and [[L4D & L4D2] Automatic Robot](https://forums.alliedmods.net/showthread.php?t=130177) plugins.

**strontiumdog** - For the [[ANY] Evil Admin: Mirror Damage](https://forums.alliedmods.net/showthread.php?t=79321), [[ANY] Evil Admin: Pimp Slap](https://forums.alliedmods.net/showthread.php?t=79322), [[ANY] Evil Admin: Rocket](https://forums.alliedmods.net/showthread.php?t=79617), and [Evil Admin: Vision](https://forums.alliedmods.net/showthread.php?t=79324) plugins.

**Hipster** - For the [[ANY] Admin Smite](https://forums.alliedmods.net/showthread.php?t=118534) plugin.

**Marcus101RR** - For the code to set a player's weapon's ammo.

**AtomicStryker** - For the [[L4D & L4D2] SM Respawn Command](https://forums.alliedmods.net/showthread.php?t=96249) and [[L4D & L4D2] Boomer Splash Damage](https://forums.alliedmods.net/showthread.php?t=98794) plugins.

**ivailosp and V10** - For the [[L4D] Away](https://forums.alliedmods.net/showthread.php?t=85537) and [[L4D2] Away](https://forums.alliedmods.net/showthread.php?t=222590) plugins.

**mi123645** - For the [[L4D(2)] 4+ Survivor AFK Fix](https://forums.alliedmods.net/showthread.php?t=132409) plugin.

**Chanz** - For the [[ANY] Infinite-Jumping](https://forums.alliedmods.net/showthread.php?t=132391) plugin.

**Farbror Godis** - For the [[ANY] Curse](https://forums.alliedmods.net/showthread.php?t=280146) plugin.

**GoD-Tony** - For the [Toggle Weapon Sounds](https://forums.alliedmods.net/showthread.php?t=183478) and [Updater](https://forums.alliedmods.net/showthread.php?t=169095) plugins.

**Teamkiller324** - For the [Updater](https://github.com/Teamkiller324/Updater) plugin.

**Phil25** - For the [[TF2] Roll the Dice Revamped (RTD)](https://forums.alliedmods.net/showthread.php?t=278579) plugin.

**Chaosxk** - For the [[ANY] Spin my screen](https://forums.alliedmods.net/showthread.php?t=283120) plugin.

**ztar** - For the [[L4D2] LAST BOSS](https://forums.alliedmods.net/showthread.php?t=129013?t=129013) plugin.

**IxAvnoMonvAxI** - For the [[L4D2] Last Boss Extended](https://forums.alliedmods.net/showpost.php?p=1463486&postcount=2) plugin.

**Uncle Jessie** - For the `Tremor Tank` in his [Last Boss Extended revision](https://forums.alliedmods.net/showpost.php?p=2570108&postcount=73).

**Drixevel** - For the [[ANY] Force Active Weapon](https://forums.alliedmods.net/showthread.php?t=293645) plugin.

**pRED** - For the [[ANY] SM Super Commands](https://forums.alliedmods.net/showthread.php?t=57448) plugin.

**sheo** - For the [[L4D2] Fix Frozen Tanks](https://forums.alliedmods.net/showthread.php?t=239809) plugin.

**nico-op** - For the [[L4D/L4D2] Infected Health Gauge (Tank & Witch & Special)](https://forums.alliedmods.net/showthread.php?t=125747) plugin.

**Ernecio** - For the [[L4D1 AND L4D2] Tank's Laser Attack](https://forums.alliedmods.net/showthread.php?t=320215) and [[L4D1 & L4D2] Improved Flying Tank](https://forums.alliedmods.net/showthread.php?t=325719) plugins.

**Luckylock** - For the [[L4D & L4D2] Tank Rock Lag Compensation](https://forums.alliedmods.net/showthread.php?t=315345) plugin.

**raoulduke** - For the [[L4D] Survival Event Timer](https://forums.alliedmods.net/showthread.php?t=92175) plugin.

**Pelipoika** - For the [[TF2] Rainbow Glow](https://forums.alliedmods.net/showthread.php?t=287533) plugin.

**cravenge** - For the [[L4D/L4D2] Vigilant Tank Behavior](https://forums.alliedmods.net/showthread.php?t=334690) and [[L4D/L4D2] MultiTanks - Improved](https://forums.alliedmods.net/showthread.php?t=303729) plugins.

**Erreur 500** - For the [[ANY] Stuck](https://forums.alliedmods.net/showthread.php?t=243151) plugin.

**Xutax_Kamay** - For the [[ANY] Hit Registration Fix Plugin (bullet displacement by 1 tick)](https://forums.alliedmods.net/showthread.php?t=315405) plugin.

**Carl Sagan** - For the [[L4D2] Tank Rush 2](https://forums.alliedmods.net/showthread.php?t=234840) plugin.

**Silvers (Silvershot)** - For his plugins which make good references, helping with gamedata signatures, and helping to optimize/fix various parts of the code.

**epz/epzminion** - For helping with gamedata signatures, offsets, addresses, and invaluable input.

**Lux/LuxLuma** - For helping to optimize/fix various parts of the code, the code for detecting thirdperson view, and for the [Left4Fix](https://github.com/LuxLuma/Left-4-fix) and [[L4D/L4D2]WeaponHandling_API](https://forums.alliedmods.net/showthread.php?t=319947) plugins.

**Forgetest** - For helping with gamedata offsets.

**sorallll** - For the [[L4D2]Skip Tank Taunt](https://forums.alliedmods.net/showthread.php?t=336707) plugin.

**Milo|** - For the [Extended Map Configs](https://forums.alliedmods.net/showthread.php?t=85551) and [Dailyconfig](https://forums.alliedmods.net/showthread.php?t=84720) plugins.

**exvel** - For the [Colors](https://forums.alliedmods.net/showthread.php?t=96831) include.

**Impact** - For the [AutoExecConfig](https://forums.alliedmods.net/showthread.php?t=204254) include.

**hmmmmm (SlidyBat)** - For showing how to pick a random character out of a dynamic string.

**KasperH/Ladis** - For Hungarian translations, reporting issues, suggesting ideas, and overall support.

**Blueberry/Kleiner** - For Russian translations and suggesting ideas.

**yuzumi** - For Simplified Chinese translations, reporting issues, and suggesting ideas.

**Mi.Cura, 3aljiyavslgazana** - For reporting issues, suggesting ideas, testing features, and overall support.

**emsit** - For reporting issues, helping with parts of the code, and suggesting ideas.

**ReCreator, SilentBr, Neptunia, Zytheus, huwong, Tank Rush, Tonblader, TheStarRocker, Maku, Shadowart, moschinovac, saberQAQ, Shao, xcd222, PVNDV, SpannerV2** - For reporting issues and suggesting ideas.

**Princess LadyRain, Nekrob, fig101, BloodyBlade, user2000, MedicDTI, ben12398, AK978, ricksfishin, Voevoda, ur5efj, What, moekai, weffer, AlexAlcala, ddd123, GL_INS, Slaven555, Neki93, kot4404, KadabraZz, Krufftys Killers, thewintersoldier97, Balloons, George Rex, swofleswof, bedildewo** - For reporting issues.

**Electr000999, foquaxticity, foxhound27, sxslmk, FatalOE71, zaviier, RDiver, BHaType, HarryPotter, jeremyvillanueva, DonProof, XXrevoltadoXX, XYZC, JustMadMan, DARG367, zonbarbar, Unfellowed** - For suggesting ideas.

**Marttt** - For helping with many things and the pull requests.

**Dragokas** - For reporting issues, suggesting ideas, and providing fixes.

**login101** - For providing some source code for the `Lightning` ability.

**Angelace113** - For the default colors (before `v8.12`), testing each Tank type, suggesting ideas, helping with converting plugins to use enum structs (`v8.66`), helping to set up the wiki pages, and overall support.

**Sipow** - For the default colors (before `v8.12`), suggesting ideas, and overall support.

**Oliver, FusionFlarez** - For helping to test the `Reward` system, `Combination` feature, and overall support.

**SourceMod Team** - For continually updating/improving SourceMod.
</details>

## Third-Party Revisions Notice
If you would like to share your own revisions of this plugin, please rename the files so that there is no confusion for users.

## Final Words
Enjoy all my hard work and have fun with it!
