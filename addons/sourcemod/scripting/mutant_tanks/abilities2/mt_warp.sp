/**
 * Mutant Tanks: a L4D/L4D2 SourceMod Plugin
 * Copyright (C) 2023  Alfred "Psyk0tik" Llagas
 *
 * This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
 **/

#define MT_WARP_COMPILE_METHOD 0 // 0: packaged, 1: standalone

#if !defined MT_ABILITIES_MAIN2
	#if MT_WARP_COMPILE_METHOD == 1
		#include <sourcemod>
		#include <mutant_tanks>
	#else
		#error This file must be inside "scripting/mutant_tanks/abilities2" while compiling "mt_abilities2.sp" to include its content.
	#endif
public Plugin myinfo =
{
	name = "[MT] Warp Ability",
	author = MT_AUTHOR,
	description = "The Mutant Tank warps to survivors and warps survivors to random teammates.",
	version = MT_VERSION,
	url = MT_URL
};

bool g_bDedicated, g_bLateLoad;

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	EngineVersion evEngine = GetEngineVersion();
	if (evEngine != Engine_Left4Dead && evEngine != Engine_Left4Dead2)
	{
		strcopy(error, err_max, "\"[MT] Warp Ability\" only supports Left 4 Dead 1 & 2.");

		return APLRes_SilentFailure;
	}

	g_bDedicated = IsDedicatedServer();
	g_bLateLoad = late;

	return APLRes_Success;
}

#define MT_GAMEDATA "mutant_tanks"

#define PARTICLE_ELECTRICITY "electrical_arc_01_system"

#define SOUND_ELECTRICITY "ambient/energy/zap5.wav"
#define SOUND_ELECTRICITY2 "ambient/energy/zap7.wav"
#else
	#if MT_WARP_COMPILE_METHOD == 1
		#error This file must be compiled as a standalone plugin.
	#endif
#endif

#define MT_WARP_SECTION "warpability"
#define MT_WARP_SECTION2 "warp ability"
#define MT_WARP_SECTION3 "warp_ability"
#define MT_WARP_SECTION4 "warp"

#define MT_MENU_WARP "Warp Ability"

enum struct esWarpGeneral
{
	Handle g_hSDKGetLastKnownArea;

	int g_iAttributeFlagsOffset;
}

esWarpGeneral g_esWarpGeneral;

enum struct esWarpPlayer
{
	bool g_bActivated;
	bool g_bAffected;
	bool g_bFailed;
	bool g_bNoAmmo;

	float g_flCloseAreasOnly;
	float g_flOpenAreasOnly;
	float g_flWarpChance;
	float g_flWarpInterval;
	float g_flWarpRange;
	float g_flWarpRangeChance;
	float g_flWarpRockChance;

	int g_iAccessFlags;
	int g_iAmmoCount;
	int g_iAmmoCount2;
	int g_iComboAbility;
	int g_iCooldown;
	int g_iCooldown2;
	int g_iHumanAbility;
	int g_iHumanAmmo;
	int g_iHumanCooldown;
	int g_iHumanDuration;
	int g_iHumanMode;
	int g_iHumanRangeCooldown;
	int g_iHumanRockCooldown;
	int g_iImmunityFlags;
	int g_iInfectedType;
	int g_iOwner;
	int g_iRangeCooldown;
	int g_iRequiresHumans;
	int g_iRockCooldown;
	int g_iTankType;
	int g_iTankTypeRecorded;
	int g_iWarpAbility;
	int g_iWarpCooldown;
	int g_iWarpDuration;
	int g_iWarpEffect;
	int g_iWarpHit;
	int g_iWarpHitMode;
	int g_iWarpMessage;
	int g_iWarpMode;
	int g_iWarpRangeCooldown;
	int g_iWarpRockBreak;
	int g_iWarpRockCooldown;
	int g_iWarpSight;
}

esWarpPlayer g_esWarpPlayer[MAXPLAYERS + 1];

enum struct esWarpTeammate
{
	float g_flCloseAreasOnly;
	float g_flOpenAreasOnly;
	float g_flWarpChance;
	float g_flWarpInterval;
	float g_flWarpRange;
	float g_flWarpRangeChance;
	float g_flWarpRockChance;

	int g_iComboAbility;
	int g_iHumanAbility;
	int g_iHumanAmmo;
	int g_iHumanCooldown;
	int g_iHumanDuration;
	int g_iHumanMode;
	int g_iHumanRangeCooldown;
	int g_iHumanRockCooldown;
	int g_iRequiresHumans;
	int g_iWarpAbility;
	int g_iWarpCooldown;
	int g_iWarpDuration;
	int g_iWarpEffect;
	int g_iWarpHit;
	int g_iWarpHitMode;
	int g_iWarpMessage;
	int g_iWarpMode;
	int g_iWarpRangeCooldown;
	int g_iWarpRockBreak;
	int g_iWarpRockCooldown;
	int g_iWarpSight;
}

esWarpTeammate g_esWarpTeammate[MAXPLAYERS + 1];

enum struct esWarpAbility
{
	float g_flCloseAreasOnly;
	float g_flOpenAreasOnly;
	float g_flWarpChance;
	float g_flWarpInterval;
	float g_flWarpRange;
	float g_flWarpRangeChance;
	float g_flWarpRockChance;

	int g_iAccessFlags;
	int g_iComboAbility;
	int g_iComboPosition;
	int g_iHumanAbility;
	int g_iHumanAmmo;
	int g_iHumanCooldown;
	int g_iHumanDuration;
	int g_iHumanMode;
	int g_iHumanRangeCooldown;
	int g_iHumanRockCooldown;
	int g_iImmunityFlags;
	int g_iRequiresHumans;
	int g_iWarpAbility;
	int g_iWarpCooldown;
	int g_iWarpDuration;
	int g_iWarpEffect;
	int g_iWarpHit;
	int g_iWarpHitMode;
	int g_iWarpMessage;
	int g_iWarpMode;
	int g_iWarpRangeCooldown;
	int g_iWarpRockBreak;
	int g_iWarpRockCooldown;
	int g_iWarpSight;
}

esWarpAbility g_esWarpAbility[MT_MAXTYPES + 1];

enum struct esWarpSpecial
{
	float g_flCloseAreasOnly;
	float g_flOpenAreasOnly;
	float g_flWarpChance;
	float g_flWarpInterval;
	float g_flWarpRange;
	float g_flWarpRangeChance;
	float g_flWarpRockChance;

	int g_iComboAbility;
	int g_iHumanAbility;
	int g_iHumanAmmo;
	int g_iHumanCooldown;
	int g_iHumanDuration;
	int g_iHumanMode;
	int g_iHumanRangeCooldown;
	int g_iHumanRockCooldown;
	int g_iRequiresHumans;
	int g_iWarpAbility;
	int g_iWarpCooldown;
	int g_iWarpDuration;
	int g_iWarpEffect;
	int g_iWarpHit;
	int g_iWarpHitMode;
	int g_iWarpMessage;
	int g_iWarpMode;
	int g_iWarpRangeCooldown;
	int g_iWarpRockBreak;
	int g_iWarpRockCooldown;
	int g_iWarpSight;
}

esWarpSpecial g_esWarpSpecial[MT_MAXTYPES + 1];

enum struct esWarpCache
{
	float g_flCloseAreasOnly;
	float g_flOpenAreasOnly;
	float g_flWarpChance;
	float g_flWarpInterval;
	float g_flWarpRange;
	float g_flWarpRangeChance;
	float g_flWarpRockChance;

	int g_iComboAbility;
	int g_iHumanAbility;
	int g_iHumanAmmo;
	int g_iHumanCooldown;
	int g_iHumanDuration;
	int g_iHumanMode;
	int g_iHumanRangeCooldown;
	int g_iHumanRockCooldown;
	int g_iRequiresHumans;
	int g_iWarpAbility;
	int g_iWarpCooldown;
	int g_iWarpDuration;
	int g_iWarpEffect;
	int g_iWarpHit;
	int g_iWarpHitMode;
	int g_iWarpMessage;
	int g_iWarpMode;
	int g_iWarpRangeCooldown;
	int g_iWarpRockBreak;
	int g_iWarpRockCooldown;
	int g_iWarpSight;
}

esWarpCache g_esWarpCache[MAXPLAYERS + 1];

#if defined MT_ABILITIES_MAIN2
void vWarpAllPluginsLoaded(GameData gdMutantTanks)
#else
public void OnAllPluginsLoaded()
#endif
{
#if !defined MT_ABILITIES_MAIN2
	GameData gdMutantTanks = new GameData(MT_GAMEDATA);
	if (gdMutantTanks == null)
	{
		SetFailState("Unable to load the \"%s\" gamedata file.", MT_GAMEDATA);
	}
#endif
	g_esWarpGeneral.g_iAttributeFlagsOffset = gdMutantTanks.GetOffset("WitchLocomotion::IsAreaTraversable::m_attributeFlags");
	if (g_esWarpGeneral.g_iAttributeFlagsOffset == -1)
	{
#if defined MT_ABILITIES_MAIN2
		delete gdMutantTanks;

		LogError("%s Failed to load offset: WitchLocomotion::IsAreaTraversable::m_attributeFlags", MT_TAG);
#else
		SetFailState("Failed to load offset: WitchLocomotion::IsAreaTraversable::m_attributeFlags");
#endif
	}

	StartPrepSDKCall(SDKCall_Player);
	if (!PrepSDKCall_SetFromConf(gdMutantTanks, SDKConf_Virtual, "CTerrorPlayer::GetLastKnownArea"))
	{
		delete gdMutantTanks;
#if defined MT_ABILITIES_MAIN2
		LogError("%s Failed to load offset: CTerrorPlayer::GetLastKnownArea", MT_TAG);
#else
		SetFailState("Failed to load offset: CTerrorPlayer::GetLastKnownArea");
#endif
	}
	else
	{
		PrepSDKCall_SetReturnInfo(SDKType_PlainOldData, SDKPass_Plain);
		g_esWarpGeneral.g_hSDKGetLastKnownArea = EndPrepSDKCall();
		if (g_esWarpGeneral.g_hSDKGetLastKnownArea == null)
		{
#if defined MT_ABILITIES_MAIN2
			LogError("%s Your \"CTerrorPlayer::GetLastKnownArea\" offsets are outdated.", MT_TAG);
#else
			SetFailState("Your \"CTerrorPlayer::GetLastKnownArea\" offsets are outdated.");
#endif
		}
	}
#if !defined MT_ABILITIES_MAIN2
	delete gdMutantTanks;
#endif
}

#if !defined MT_ABILITIES_MAIN2
public void OnPluginStart()
{
	LoadTranslations("common.phrases");
	LoadTranslations("mutant_tanks.phrases");
	LoadTranslations("mutant_tanks_names.phrases");

	RegConsoleCmd("sm_mt_warp", cmdWarpInfo, "View information about the Warp ability.");

	if (g_bLateLoad)
	{
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			if (bIsValidClient(iPlayer, MT_CHECK_INGAME))
			{
				OnClientPutInServer(iPlayer);
			}
		}

		g_bLateLoad = false;
	}
}
#endif

#if defined MT_ABILITIES_MAIN2
void vWarpMapStart()
#else
public void OnMapStart()
#endif
{
	PrecacheSound(SOUND_ELECTRICITY, true);
	PrecacheSound(SOUND_ELECTRICITY2, true);

	vWarpReset();
}

#if defined MT_ABILITIES_MAIN2
void vWarpClientPutInServer(int client)
#else
public void OnClientPutInServer(int client)
#endif
{
	SDKHook(client, SDKHook_OnTakeDamage, OnWarpTakeDamage);
	vRemoveWarp(client);
}

#if defined MT_ABILITIES_MAIN2
void vWarpClientDisconnect_Post(int client)
#else
public void OnClientDisconnect_Post(int client)
#endif
{
	vRemoveWarp(client);
}

#if defined MT_ABILITIES_MAIN2
void vWarpMapEnd()
#else
public void OnMapEnd()
#endif
{
	vWarpReset();
}

#if !defined MT_ABILITIES_MAIN2
Action cmdWarpInfo(int client, int args)
{
	client = iGetListenServerHost(client, g_bDedicated);

	if (!MT_IsCorePluginEnabled())
	{
		MT_ReplyToCommand(client, "%s %t", MT_TAG5, "PluginDisabled");

		return Plugin_Handled;
	}

	if (!bIsValidClient(client, MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_FAKECLIENT))
	{
		MT_ReplyToCommand(client, "%s %t", MT_TAG, "Command is in-game only");

		return Plugin_Handled;
	}

	switch (IsVoteInProgress())
	{
		case true: MT_ReplyToCommand(client, "%s %t", MT_TAG2, "Vote in Progress");
		case false: vWarpMenu(client, MT_WARP_SECTION4, 0);
	}

	return Plugin_Handled;
}
#endif

void vWarpMenu(int client, const char[] name, int item)
{
	if (StrContains(MT_WARP_SECTION4, name, false) == -1)
	{
		return;
	}

	Menu mAbilityMenu = new Menu(iWarpMenuHandler, MENU_ACTIONS_DEFAULT|MenuAction_Display|MenuAction_DisplayItem);
	mAbilityMenu.SetTitle("Warp Ability Information");
	mAbilityMenu.AddItem("Status", "Status");
	mAbilityMenu.AddItem("Ammunition", "Ammunition");
	mAbilityMenu.AddItem("Buttons", "Buttons");
	mAbilityMenu.AddItem("Button Mode", "Button Mode");
	mAbilityMenu.AddItem("Cooldown", "Cooldown");
	mAbilityMenu.AddItem("Details", "Details");
	mAbilityMenu.AddItem("Duration", "Duration");
	mAbilityMenu.AddItem("Human Support", "Human Support");
	mAbilityMenu.AddItem("Range Cooldown", "Range Cooldown");
	mAbilityMenu.AddItem("Rock Cooldown", "Rock Cooldown");
	mAbilityMenu.DisplayAt(client, item, MENU_TIME_FOREVER);
}

int iWarpMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
	switch (action)
	{
		case MenuAction_End: delete menu;
		case MenuAction_Select:
		{
			switch (param2)
			{
				case 0: MT_PrintToChat(param1, "%s %t", MT_TAG3, (g_esWarpCache[param1].g_iWarpAbility == 0) ? "AbilityStatus1" : "AbilityStatus2");
				case 1:
				{
					MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityAmmo", (g_esWarpCache[param1].g_iHumanAmmo - g_esWarpPlayer[param1].g_iAmmoCount), g_esWarpCache[param1].g_iHumanAmmo);
					MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityAmmo2", (g_esWarpCache[param1].g_iHumanAmmo - g_esWarpPlayer[param1].g_iAmmoCount2), g_esWarpCache[param1].g_iHumanAmmo);
				}
				case 2:
				{
					MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityButtons");
					MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityButtons2");
				}
				case 3: MT_PrintToChat(param1, "%s %t", MT_TAG3, (g_esWarpCache[param1].g_iHumanMode == 0) ? "AbilityButtonMode1" : "AbilityButtonMode2");
				case 4: MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityCooldown", ((g_esWarpCache[param1].g_iHumanAbility == 1) ? g_esWarpCache[param1].g_iHumanCooldown : g_esWarpCache[param1].g_iWarpCooldown));
				case 5: MT_PrintToChat(param1, "%s %t", MT_TAG3, "WarpDetails");
				case 6: MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityDuration2", ((g_esWarpCache[param1].g_iHumanAbility == 1) ? g_esWarpCache[param1].g_iHumanDuration : g_esWarpCache[param1].g_iWarpDuration));
				case 7: MT_PrintToChat(param1, "%s %t", MT_TAG3, (g_esWarpCache[param1].g_iHumanAbility == 0) ? "AbilityHumanSupport1" : "AbilityHumanSupport2");
				case 8: MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityRangeCooldown", ((g_esWarpCache[param1].g_iHumanAbility == 1) ? g_esWarpCache[param1].g_iHumanRangeCooldown : g_esWarpCache[param1].g_iWarpRangeCooldown));
				case 9: MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityRockCooldown", ((g_esWarpCache[param1].g_iHumanAbility == 1) ? g_esWarpCache[param1].g_iHumanRockCooldown : g_esWarpCache[param1].g_iWarpRockCooldown));
			}

			if (bIsValidClient(param1, MT_CHECK_INGAME))
			{
				vWarpMenu(param1, MT_WARP_SECTION4, menu.Selection);
			}
		}
		case MenuAction_Display:
		{
			char sMenuTitle[PLATFORM_MAX_PATH];
			Panel pWarp = view_as<Panel>(param2);
			FormatEx(sMenuTitle, sizeof sMenuTitle, "%T", "WarpMenu", param1);
			pWarp.SetTitle(sMenuTitle);
		}
		case MenuAction_DisplayItem:
		{
			if (param2 >= 0)
			{
				char sMenuOption[PLATFORM_MAX_PATH];

				switch (param2)
				{
					case 0: FormatEx(sMenuOption, sizeof sMenuOption, "%T", "Status", param1);
					case 1: FormatEx(sMenuOption, sizeof sMenuOption, "%T", "Ammunition", param1);
					case 2: FormatEx(sMenuOption, sizeof sMenuOption, "%T", "Buttons", param1);
					case 3: FormatEx(sMenuOption, sizeof sMenuOption, "%T", "ButtonMode", param1);
					case 4: FormatEx(sMenuOption, sizeof sMenuOption, "%T", "Cooldown", param1);
					case 5: FormatEx(sMenuOption, sizeof sMenuOption, "%T", "Details", param1);
					case 6: FormatEx(sMenuOption, sizeof sMenuOption, "%T", "Duration", param1);
					case 7: FormatEx(sMenuOption, sizeof sMenuOption, "%T", "HumanSupport", param1);
					case 8: FormatEx(sMenuOption, sizeof sMenuOption, "%T", "RangeCooldown", param1);
					case 9: FormatEx(sMenuOption, sizeof sMenuOption, "%T", "RockCooldown", param1);
				}

				return RedrawMenuItem(sMenuOption);
			}
		}
	}

	return 0;
}

#if defined MT_ABILITIES_MAIN2
void vWarpDisplayMenu(Menu menu)
#else
public void MT_OnDisplayMenu(Menu menu)
#endif
{
	menu.AddItem(MT_MENU_WARP, MT_MENU_WARP);
}

#if defined MT_ABILITIES_MAIN2
void vWarpMenuItemSelected(int client, const char[] info)
#else
public void MT_OnMenuItemSelected(int client, const char[] info)
#endif
{
	if (StrEqual(info, MT_MENU_WARP, false))
	{
		vWarpMenu(client, MT_WARP_SECTION4, 0);
	}
}

#if defined MT_ABILITIES_MAIN2
void vWarpMenuItemDisplayed(int client, const char[] info, char[] buffer, int size)
#else
public void MT_OnMenuItemDisplayed(int client, const char[] info, char[] buffer, int size)
#endif
{
	if (StrEqual(info, MT_MENU_WARP, false))
	{
		FormatEx(buffer, size, "%T", "WarpMenu2", client);
	}
}

Action OnWarpTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype)
{
	if (MT_IsCorePluginEnabled() && bIsValidClient(victim, MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_ALIVE) && damage > 0.0)
	{
		char sClassname[32];
		if (bIsValidEntity(inflictor))
		{
			GetEntityClassname(inflictor, sClassname, sizeof sClassname);
		}

		if (MT_IsTankSupported(attacker) && MT_IsCustomTankSupported(attacker) && (g_esWarpCache[attacker].g_iWarpHitMode == 0 || g_esWarpCache[attacker].g_iWarpHitMode == 1) && bIsSurvivor(victim) && g_esWarpCache[attacker].g_iComboAbility == 0)
		{
			if ((!MT_HasAdminAccess(attacker) && !bHasAdminAccess(attacker, g_esWarpAbility[g_esWarpPlayer[attacker].g_iTankTypeRecorded].g_iAccessFlags, g_esWarpPlayer[attacker].g_iAccessFlags)) || MT_IsAdminImmune(victim, attacker) || bIsAdminImmune(victim, g_esWarpPlayer[attacker].g_iTankType, g_esWarpAbility[g_esWarpPlayer[attacker].g_iTankTypeRecorded].g_iImmunityFlags, g_esWarpPlayer[victim].g_iImmunityFlags))
			{
				return Plugin_Continue;
			}

			bool bCaught = bIsSurvivorCaught(victim);
			if ((bIsSpecialInfected(attacker) && (bCaught || (!bCaught && (damagetype & DMG_CLUB)) || (bIsSpitter(attacker) && StrEqual(sClassname, "insect_swarm")))) || StrEqual(sClassname[7], "tank_claw") || StrEqual(sClassname, "tank_rock"))
			{
				vWarpHit(victim, attacker, GetRandomFloat(0.1, 100.0), g_esWarpCache[attacker].g_flWarpChance, g_esWarpCache[attacker].g_iWarpHit, MT_MESSAGE_MELEE, MT_ATTACK_CLAW);
			}
		}
		else if (MT_IsTankSupported(victim) && MT_IsCustomTankSupported(victim) && (g_esWarpCache[victim].g_iWarpHitMode == 0 || g_esWarpCache[victim].g_iWarpHitMode == 2) && bIsSurvivor(attacker) && g_esWarpCache[victim].g_iComboAbility == 0)
		{
			if ((!MT_HasAdminAccess(victim) && !bHasAdminAccess(victim, g_esWarpAbility[g_esWarpPlayer[victim].g_iTankTypeRecorded].g_iAccessFlags, g_esWarpPlayer[victim].g_iAccessFlags)) || MT_IsAdminImmune(attacker, victim) || bIsAdminImmune(attacker, g_esWarpPlayer[victim].g_iTankType, g_esWarpAbility[g_esWarpPlayer[victim].g_iTankTypeRecorded].g_iImmunityFlags, g_esWarpPlayer[attacker].g_iImmunityFlags))
			{
				return Plugin_Continue;
			}

			if (StrEqual(sClassname[7], "melee"))
			{
				vWarpHit(attacker, victim, GetRandomFloat(0.1, 100.0), g_esWarpCache[victim].g_flWarpChance, g_esWarpCache[victim].g_iWarpHit, MT_MESSAGE_MELEE, MT_ATTACK_MELEE);
			}
		}
	}

	return Plugin_Continue;
}

#if defined MT_ABILITIES_MAIN2
void vWarpPluginCheck(ArrayList list)
#else
public void MT_OnPluginCheck(ArrayList list)
#endif
{
	list.PushString(MT_MENU_WARP);
}

#if defined MT_ABILITIES_MAIN2
void vWarpAbilityCheck(ArrayList list, ArrayList list2, ArrayList list3, ArrayList list4)
#else
public void MT_OnAbilityCheck(ArrayList list, ArrayList list2, ArrayList list3, ArrayList list4)
#endif
{
	list.PushString(MT_WARP_SECTION);
	list2.PushString(MT_WARP_SECTION2);
	list3.PushString(MT_WARP_SECTION3);
	list4.PushString(MT_WARP_SECTION4);
}

#if defined MT_ABILITIES_MAIN2
void vWarpCombineAbilities(int tank, int type, const float random, const char[] combo, int survivor, int weapon, const char[] classname)
#else
public void MT_OnCombineAbilities(int tank, int type, const float random, const char[] combo, int survivor, int weapon, const char[] classname)
#endif
{
	if (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esWarpCache[tank].g_iHumanAbility != 2)
	{
		g_esWarpAbility[g_esWarpPlayer[tank].g_iTankTypeRecorded].g_iComboPosition = -1;

		return;
	}

	g_esWarpAbility[g_esWarpPlayer[tank].g_iTankTypeRecorded].g_iComboPosition = -1;

	char sCombo[320], sSet[4][32];
	FormatEx(sCombo, sizeof sCombo, ",%s,", combo);
	FormatEx(sSet[0], sizeof sSet[], ",%s,", MT_WARP_SECTION);
	FormatEx(sSet[1], sizeof sSet[], ",%s,", MT_WARP_SECTION2);
	FormatEx(sSet[2], sizeof sSet[], ",%s,", MT_WARP_SECTION3);
	FormatEx(sSet[3], sizeof sSet[], ",%s,", MT_WARP_SECTION4);
	if (g_esWarpCache[tank].g_iComboAbility == 1 && (StrContains(sCombo, sSet[0], false) != -1 || StrContains(sCombo, sSet[1], false) != -1 || StrContains(sCombo, sSet[2], false) != -1 || StrContains(sCombo, sSet[3], false) != -1))
	{
		char sAbilities[320], sSubset[10][32];
		strcopy(sAbilities, sizeof sAbilities, combo);
		ExplodeString(sAbilities, ",", sSubset, sizeof sSubset, sizeof sSubset[]);

		float flChance = 0.0, flDelay = 0.0;
		for (int iPos = 0; iPos < (sizeof sSubset); iPos++)
		{
			if (StrEqual(sSubset[iPos], MT_WARP_SECTION, false) || StrEqual(sSubset[iPos], MT_WARP_SECTION2, false) || StrEqual(sSubset[iPos], MT_WARP_SECTION3, false) || StrEqual(sSubset[iPos], MT_WARP_SECTION4, false))
			{
				g_esWarpAbility[g_esWarpPlayer[tank].g_iTankTypeRecorded].g_iComboPosition = iPos;
				flDelay = MT_GetCombinationSetting(tank, 4, iPos);

				switch (type)
				{
					case MT_COMBO_MAINRANGE:
					{
						if (g_esWarpCache[tank].g_iWarpAbility == 1 || g_esWarpCache[tank].g_iWarpAbility == 3)
						{
							switch (flDelay)
							{
								case 0.0: vWarpAbility(tank, true, random, iPos);
								default:
								{
									DataPack dpCombo;
									CreateDataTimer(flDelay, tTimerWarpCombo, dpCombo, TIMER_FLAG_NO_MAPCHANGE);
									dpCombo.WriteCell(GetClientUserId(tank));
									dpCombo.WriteFloat(random);
									dpCombo.WriteCell(iPos);
								}
							}
						}

						if (g_esWarpCache[tank].g_iWarpAbility == 2 || g_esWarpCache[tank].g_iWarpAbility == 3)
						{
							switch (flDelay)
							{
								case 0.0: vWarpAbility(tank, false, .pos = iPos);
								default:
								{
									DataPack dpCombo;
									CreateDataTimer(flDelay, tTimerWarpCombo2, dpCombo, TIMER_FLAG_NO_MAPCHANGE);
									dpCombo.WriteCell(GetClientUserId(tank));
									dpCombo.WriteCell(iPos);
								}
							}
						}
					}
					case MT_COMBO_MELEEHIT:
					{
						flChance = MT_GetCombinationSetting(tank, 1, iPos);

						switch (flDelay)
						{
							case 0.0:
							{
								if ((g_esWarpCache[tank].g_iWarpHitMode == 0 || g_esWarpCache[tank].g_iWarpHitMode == 1) && (StrEqual(classname[7], "tank_claw") || StrEqual(classname, "tank_rock")))
								{
									vWarpHit(survivor, tank, random, flChance, g_esWarpCache[tank].g_iWarpHit, MT_MESSAGE_MELEE, MT_ATTACK_CLAW, iPos);
								}
								else if ((g_esWarpCache[tank].g_iWarpHitMode == 0 || g_esWarpCache[tank].g_iWarpHitMode == 2) && StrEqual(classname[7], "melee"))
								{
									vWarpHit(survivor, tank, random, flChance, g_esWarpCache[tank].g_iWarpHit, MT_MESSAGE_MELEE, MT_ATTACK_MELEE, iPos);
								}
							}
							default:
							{
								DataPack dpCombo;
								CreateDataTimer(flDelay, tTimerWarpCombo3, dpCombo, TIMER_FLAG_NO_MAPCHANGE);
								dpCombo.WriteCell(GetClientUserId(survivor));
								dpCombo.WriteCell(GetClientUserId(tank));
								dpCombo.WriteFloat(random);
								dpCombo.WriteFloat(flChance);
								dpCombo.WriteCell(iPos);
								dpCombo.WriteString(classname);
							}
						}
					}
					case MT_COMBO_ROCKBREAK:
					{
						if (g_esWarpCache[tank].g_iWarpRockBreak == 1 && bIsValidEntity(weapon))
						{
							vWarpRockBreak2(tank, weapon, random, iPos);
						}
					}
				}

				break;
			}
		}
	}
}

#if defined MT_ABILITIES_MAIN2
void vWarpConfigsLoad(int mode)
#else
public void MT_OnConfigsLoad(int mode)
#endif
{
	switch (mode)
	{
		case 1:
		{
			for (int iIndex = MT_GetMinType(); iIndex <= MT_GetMaxType(); iIndex++)
			{
				g_esWarpAbility[iIndex].g_iAccessFlags = 0;
				g_esWarpAbility[iIndex].g_iImmunityFlags = 0;
				g_esWarpAbility[iIndex].g_flCloseAreasOnly = 0.0;
				g_esWarpAbility[iIndex].g_iComboAbility = 0;
				g_esWarpAbility[iIndex].g_iComboPosition = -1;
				g_esWarpAbility[iIndex].g_iHumanAbility = 0;
				g_esWarpAbility[iIndex].g_iHumanAmmo = 5;
				g_esWarpAbility[iIndex].g_iHumanCooldown = 0;
				g_esWarpAbility[iIndex].g_iHumanDuration = 5;
				g_esWarpAbility[iIndex].g_iHumanMode = 1;
				g_esWarpAbility[iIndex].g_iHumanRangeCooldown = 0;
				g_esWarpAbility[iIndex].g_iHumanRockCooldown = 0;
				g_esWarpAbility[iIndex].g_flOpenAreasOnly = 0.0;
				g_esWarpAbility[iIndex].g_iRequiresHumans = 0;
				g_esWarpAbility[iIndex].g_iWarpAbility = 0;
				g_esWarpAbility[iIndex].g_iWarpEffect = 0;
				g_esWarpAbility[iIndex].g_iWarpMessage = 0;
				g_esWarpAbility[iIndex].g_flWarpChance = 33.3;
				g_esWarpAbility[iIndex].g_iWarpCooldown = 0;
				g_esWarpAbility[iIndex].g_iWarpDuration = 0;
				g_esWarpAbility[iIndex].g_iWarpHit = 0;
				g_esWarpAbility[iIndex].g_iWarpHitMode = 0;
				g_esWarpAbility[iIndex].g_flWarpInterval = 5.0;
				g_esWarpAbility[iIndex].g_iWarpMode = 0;
				g_esWarpAbility[iIndex].g_flWarpRange = 150.0;
				g_esWarpAbility[iIndex].g_flWarpRangeChance = 15.0;
				g_esWarpAbility[iIndex].g_iWarpRangeCooldown = 0;
				g_esWarpAbility[iIndex].g_iWarpRockBreak = 0;
				g_esWarpAbility[iIndex].g_flWarpRockChance = 33.3;
				g_esWarpAbility[iIndex].g_iWarpRockCooldown = 0;
				g_esWarpAbility[iIndex].g_iWarpSight = 0;

				g_esWarpSpecial[iIndex].g_flCloseAreasOnly = -1.0;
				g_esWarpSpecial[iIndex].g_iComboAbility = -1;
				g_esWarpSpecial[iIndex].g_iHumanAbility = -1;
				g_esWarpSpecial[iIndex].g_iHumanAmmo = -1;
				g_esWarpSpecial[iIndex].g_iHumanCooldown = -1;
				g_esWarpSpecial[iIndex].g_iHumanDuration = -1;
				g_esWarpSpecial[iIndex].g_iHumanMode = -1;
				g_esWarpSpecial[iIndex].g_iHumanRangeCooldown = -1;
				g_esWarpSpecial[iIndex].g_iHumanRockCooldown = -1;
				g_esWarpSpecial[iIndex].g_flOpenAreasOnly = -1.0;
				g_esWarpSpecial[iIndex].g_iRequiresHumans = -1;
				g_esWarpSpecial[iIndex].g_iWarpAbility = -1;
				g_esWarpSpecial[iIndex].g_iWarpEffect = -1;
				g_esWarpSpecial[iIndex].g_iWarpMessage = -1;
				g_esWarpSpecial[iIndex].g_flWarpChance = -1.0;
				g_esWarpSpecial[iIndex].g_iWarpCooldown = -1;
				g_esWarpSpecial[iIndex].g_iWarpDuration = -1;
				g_esWarpSpecial[iIndex].g_iWarpHit = -1;
				g_esWarpSpecial[iIndex].g_iWarpHitMode = -1;
				g_esWarpSpecial[iIndex].g_flWarpInterval = -1.0;
				g_esWarpSpecial[iIndex].g_iWarpMode = -1;
				g_esWarpSpecial[iIndex].g_flWarpRange = -1.0;
				g_esWarpSpecial[iIndex].g_flWarpRangeChance = -1.0;
				g_esWarpSpecial[iIndex].g_iWarpRangeCooldown = -1;
				g_esWarpSpecial[iIndex].g_iWarpRockBreak = -1;
				g_esWarpSpecial[iIndex].g_flWarpRockChance = -1.0;
				g_esWarpSpecial[iIndex].g_iWarpRockCooldown = -1;
				g_esWarpSpecial[iIndex].g_iWarpSight = -1;
			}
		}
		case 3:
		{
			for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
			{
				g_esWarpPlayer[iPlayer].g_iAccessFlags = -1;
				g_esWarpPlayer[iPlayer].g_iImmunityFlags = -1;
				g_esWarpPlayer[iPlayer].g_flCloseAreasOnly = -1.0;
				g_esWarpPlayer[iPlayer].g_iComboAbility = -1;
				g_esWarpPlayer[iPlayer].g_iHumanAbility = -1;
				g_esWarpPlayer[iPlayer].g_iHumanAmmo = -1;
				g_esWarpPlayer[iPlayer].g_iHumanCooldown = -1;
				g_esWarpPlayer[iPlayer].g_iHumanDuration = -1;
				g_esWarpPlayer[iPlayer].g_iHumanMode = -1;
				g_esWarpPlayer[iPlayer].g_iHumanRangeCooldown = -1;
				g_esWarpPlayer[iPlayer].g_iHumanRockCooldown = -1;
				g_esWarpPlayer[iPlayer].g_flOpenAreasOnly = -1.0;
				g_esWarpPlayer[iPlayer].g_iRequiresHumans = -1;
				g_esWarpPlayer[iPlayer].g_iWarpAbility = -1;
				g_esWarpPlayer[iPlayer].g_iWarpEffect = -1;
				g_esWarpPlayer[iPlayer].g_iWarpMessage = -1;
				g_esWarpPlayer[iPlayer].g_flWarpChance = -1.0;
				g_esWarpPlayer[iPlayer].g_iWarpCooldown = -1;
				g_esWarpPlayer[iPlayer].g_iWarpDuration = -1;
				g_esWarpPlayer[iPlayer].g_iWarpHit = -1;
				g_esWarpPlayer[iPlayer].g_iWarpHitMode = -1;
				g_esWarpPlayer[iPlayer].g_flWarpInterval = -1.0;
				g_esWarpPlayer[iPlayer].g_iWarpMode = -1;
				g_esWarpPlayer[iPlayer].g_flWarpRange = -1.0;
				g_esWarpPlayer[iPlayer].g_flWarpRangeChance = -1.0;
				g_esWarpPlayer[iPlayer].g_iWarpRangeCooldown = -1;
				g_esWarpPlayer[iPlayer].g_iWarpRockBreak = -1;
				g_esWarpPlayer[iPlayer].g_flWarpRockChance = -1.0;
				g_esWarpPlayer[iPlayer].g_iWarpRockCooldown = -1;
				g_esWarpPlayer[iPlayer].g_iWarpSight = -1;

				g_esWarpTeammate[iPlayer].g_flCloseAreasOnly = -1.0;
				g_esWarpTeammate[iPlayer].g_iComboAbility = -1;
				g_esWarpTeammate[iPlayer].g_iHumanAbility = -1;
				g_esWarpTeammate[iPlayer].g_iHumanAmmo = -1;
				g_esWarpTeammate[iPlayer].g_iHumanCooldown = -1;
				g_esWarpTeammate[iPlayer].g_iHumanDuration = -1;
				g_esWarpTeammate[iPlayer].g_iHumanMode = -1;
				g_esWarpTeammate[iPlayer].g_iHumanRangeCooldown = -1;
				g_esWarpTeammate[iPlayer].g_iHumanRockCooldown = -1;
				g_esWarpTeammate[iPlayer].g_flOpenAreasOnly = -1.0;
				g_esWarpTeammate[iPlayer].g_iRequiresHumans = -1;
				g_esWarpTeammate[iPlayer].g_iWarpAbility = -1;
				g_esWarpTeammate[iPlayer].g_iWarpEffect = -1;
				g_esWarpTeammate[iPlayer].g_iWarpMessage = -1;
				g_esWarpTeammate[iPlayer].g_flWarpChance = -1.0;
				g_esWarpTeammate[iPlayer].g_iWarpCooldown = -1;
				g_esWarpTeammate[iPlayer].g_iWarpDuration = -1;
				g_esWarpTeammate[iPlayer].g_iWarpHit = -1;
				g_esWarpTeammate[iPlayer].g_iWarpHitMode = -1;
				g_esWarpTeammate[iPlayer].g_flWarpInterval = -1.0;
				g_esWarpTeammate[iPlayer].g_iWarpMode = -1;
				g_esWarpTeammate[iPlayer].g_flWarpRange = -1.0;
				g_esWarpTeammate[iPlayer].g_flWarpRangeChance = -1.0;
				g_esWarpTeammate[iPlayer].g_iWarpRangeCooldown = -1;
				g_esWarpTeammate[iPlayer].g_iWarpRockBreak = -1;
				g_esWarpTeammate[iPlayer].g_flWarpRockChance = -1.0;
				g_esWarpTeammate[iPlayer].g_iWarpRockCooldown = -1;
				g_esWarpTeammate[iPlayer].g_iWarpSight = -1;
			}
		}
	}
}

#if defined MT_ABILITIES_MAIN2
void vWarpConfigsLoaded(const char[] subsection, const char[] key, const char[] value, int type, int admin, int mode, bool special, const char[] specsection)
#else
public void MT_OnConfigsLoaded(const char[] subsection, const char[] key, const char[] value, int type, int admin, int mode, bool special, const char[] specsection)
#endif
{
	if ((mode == -1 || mode == 3) && bIsValidClient(admin))
	{
		if (special && specsection[0] != '\0')
		{
			g_esWarpTeammate[admin].g_flCloseAreasOnly = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "CloseAreasOnly", "Close Areas Only", "Close_Areas_Only", "closeareas", g_esWarpTeammate[admin].g_flCloseAreasOnly, value, -1.0, 99999.0);
			g_esWarpTeammate[admin].g_iComboAbility = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "ComboAbility", "Combo Ability", "Combo_Ability", "combo", g_esWarpTeammate[admin].g_iComboAbility, value, -1, 1);
			g_esWarpTeammate[admin].g_iHumanAbility = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanAbility", "Human Ability", "Human_Ability", "human", g_esWarpTeammate[admin].g_iHumanAbility, value, -1, 2);
			g_esWarpTeammate[admin].g_iHumanAmmo = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanAmmo", "Human Ammo", "Human_Ammo", "hammo", g_esWarpTeammate[admin].g_iHumanAmmo, value, -1, 99999);
			g_esWarpTeammate[admin].g_iHumanCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanCooldown", "Human Cooldown", "Human_Cooldown", "hcooldown", g_esWarpTeammate[admin].g_iHumanCooldown, value, -1, 99999);
			g_esWarpTeammate[admin].g_iHumanDuration = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanDuration", "Human Duration", "Human_Duration", "hduration", g_esWarpTeammate[admin].g_iHumanDuration, value, -1, 99999);
			g_esWarpTeammate[admin].g_iHumanMode = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanMode", "Human Mode", "Human_Mode", "hmode", g_esWarpTeammate[admin].g_iHumanMode, value, -1, 1);
			g_esWarpTeammate[admin].g_iHumanRangeCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanRangeCooldown", "Human Range Cooldown", "Human_Range_Cooldown", "hrangecooldown", g_esWarpTeammate[admin].g_iHumanRangeCooldown, value, -1, 99999);
			g_esWarpTeammate[admin].g_iHumanRockCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanRockCooldown", "Human Rock Cooldown", "Human_Rock_Cooldown", "hrockcooldown", g_esWarpTeammate[admin].g_iHumanRockCooldown, value, -1, 99999);
			g_esWarpTeammate[admin].g_flOpenAreasOnly = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "OpenAreasOnly", "Open Areas Only", "Open_Areas_Only", "openareas", g_esWarpTeammate[admin].g_flOpenAreasOnly, value, -1.0, 99999.0);
			g_esWarpTeammate[admin].g_iRequiresHumans = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "RequiresHumans", "Requires Humans", "Requires_Humans", "hrequire", g_esWarpTeammate[admin].g_iRequiresHumans, value, -1, 32);
			g_esWarpTeammate[admin].g_iWarpAbility = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AbilityEnabled", "Ability Enabled", "Ability_Enabled", "aenabled", g_esWarpTeammate[admin].g_iWarpAbility, value, -1, 3);
			g_esWarpTeammate[admin].g_iWarpEffect = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AbilityEffect", "Ability Effect", "Ability_Effect", "effect", g_esWarpTeammate[admin].g_iWarpEffect, value, -1, 7);
			g_esWarpTeammate[admin].g_iWarpMessage = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AbilityMessage", "Ability Message", "Ability_Message", "message", g_esWarpTeammate[admin].g_iWarpMessage, value, -1, 7);
			g_esWarpTeammate[admin].g_iWarpSight = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AbilitySight", "Ability Sight", "Ability_Sight", "sight", g_esWarpTeammate[admin].g_iWarpSight, value, -1, 5);
			g_esWarpTeammate[admin].g_flWarpChance = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpChance", "Warp Chance", "Warp_Chance", "chance", g_esWarpTeammate[admin].g_flWarpChance, value, -1.0, 100.0);
			g_esWarpTeammate[admin].g_iWarpCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpCooldown", "Warp Cooldown", "Warp_Cooldown", "cooldown", g_esWarpTeammate[admin].g_iWarpCooldown, value, -1, 99999);
			g_esWarpTeammate[admin].g_iWarpDuration = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpDuration", "Warp Duration", "Warp_Duration", "duration", g_esWarpTeammate[admin].g_iWarpDuration, value, -1, 99999);
			g_esWarpTeammate[admin].g_iWarpHit = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpHit", "Warp Hit", "Warp_Hit", "hit", g_esWarpTeammate[admin].g_iWarpHit, value, -1, 1);
			g_esWarpTeammate[admin].g_iWarpHitMode = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpHitMode", "Warp Hit Mode", "Warp_Hit_Mode", "hitmode", g_esWarpTeammate[admin].g_iWarpHitMode, value, -1, 2);
			g_esWarpTeammate[admin].g_flWarpInterval = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpInterval", "Warp Interval", "Warp_Interval", "interval", g_esWarpTeammate[admin].g_flWarpInterval, value, -1.0, 99999.0);
			g_esWarpTeammate[admin].g_iWarpMode = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpMode", "Warp Mode", "Warp_Mode", "mode", g_esWarpTeammate[admin].g_iWarpMode, value, -1, 3);
			g_esWarpTeammate[admin].g_flWarpRange = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRange", "Warp Range", "Warp_Range", "range", g_esWarpTeammate[admin].g_flWarpRange, value, -1.0, 99999.0);
			g_esWarpTeammate[admin].g_flWarpRangeChance = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRangeChance", "Warp Range Chance", "Warp_Range_Chance", "rangechance", g_esWarpTeammate[admin].g_flWarpRangeChance, value, -1.0, 100.0);
			g_esWarpTeammate[admin].g_iWarpRangeCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRangeCooldown", "Warp Range Cooldown", "Warp_Range_Cooldown", "rangecooldown", g_esWarpTeammate[admin].g_iWarpRangeCooldown, value, -1, 99999);
			g_esWarpTeammate[admin].g_iWarpRockBreak = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRockBreak", "Warp Rock Break", "Warp_Rock_Break", "rock", g_esWarpTeammate[admin].g_iWarpRockBreak, value, -1, 1);
			g_esWarpTeammate[admin].g_flWarpRockChance = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRockChance", "Warp Rock Chance", "Warp_Rock_Chance", "rockchance", g_esWarpTeammate[admin].g_flWarpRockChance, value, -1.0, 100.0);
			g_esWarpTeammate[admin].g_iWarpRockCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRockCooldown", "Warp Rock Cooldown", "Warp_Rock_Cooldown", "rockcooldown", g_esWarpTeammate[admin].g_iWarpRockCooldown, value, -1, 99999);
		}
		else
		{
			g_esWarpPlayer[admin].g_flCloseAreasOnly = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "CloseAreasOnly", "Close Areas Only", "Close_Areas_Only", "closeareas", g_esWarpPlayer[admin].g_flCloseAreasOnly, value, -1.0, 99999.0);
			g_esWarpPlayer[admin].g_iComboAbility = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "ComboAbility", "Combo Ability", "Combo_Ability", "combo", g_esWarpPlayer[admin].g_iComboAbility, value, -1, 1);
			g_esWarpPlayer[admin].g_iHumanAbility = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanAbility", "Human Ability", "Human_Ability", "human", g_esWarpPlayer[admin].g_iHumanAbility, value, -1, 2);
			g_esWarpPlayer[admin].g_iHumanAmmo = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanAmmo", "Human Ammo", "Human_Ammo", "hammo", g_esWarpPlayer[admin].g_iHumanAmmo, value, -1, 99999);
			g_esWarpPlayer[admin].g_iHumanCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanCooldown", "Human Cooldown", "Human_Cooldown", "hcooldown", g_esWarpPlayer[admin].g_iHumanCooldown, value, -1, 99999);
			g_esWarpPlayer[admin].g_iHumanDuration = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanDuration", "Human Duration", "Human_Duration", "hduration", g_esWarpPlayer[admin].g_iHumanDuration, value, -1, 99999);
			g_esWarpPlayer[admin].g_iHumanMode = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanMode", "Human Mode", "Human_Mode", "hmode", g_esWarpPlayer[admin].g_iHumanMode, value, -1, 1);
			g_esWarpPlayer[admin].g_iHumanRangeCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanRangeCooldown", "Human Range Cooldown", "Human_Range_Cooldown", "hrangecooldown", g_esWarpPlayer[admin].g_iHumanRangeCooldown, value, -1, 99999);
			g_esWarpPlayer[admin].g_iHumanRockCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanRockCooldown", "Human Rock Cooldown", "Human_Rock_Cooldown", "hrockcooldown", g_esWarpPlayer[admin].g_iHumanRockCooldown, value, -1, 99999);
			g_esWarpPlayer[admin].g_flOpenAreasOnly = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "OpenAreasOnly", "Open Areas Only", "Open_Areas_Only", "openareas", g_esWarpPlayer[admin].g_flOpenAreasOnly, value, -1.0, 99999.0);
			g_esWarpPlayer[admin].g_iRequiresHumans = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "RequiresHumans", "Requires Humans", "Requires_Humans", "hrequire", g_esWarpPlayer[admin].g_iRequiresHumans, value, -1, 32);
			g_esWarpPlayer[admin].g_iWarpAbility = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AbilityEnabled", "Ability Enabled", "Ability_Enabled", "aenabled", g_esWarpPlayer[admin].g_iWarpAbility, value, -1, 3);
			g_esWarpPlayer[admin].g_iWarpEffect = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AbilityEffect", "Ability Effect", "Ability_Effect", "effect", g_esWarpPlayer[admin].g_iWarpEffect, value, -1, 7);
			g_esWarpPlayer[admin].g_iWarpMessage = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AbilityMessage", "Ability Message", "Ability_Message", "message", g_esWarpPlayer[admin].g_iWarpMessage, value, -1, 7);
			g_esWarpPlayer[admin].g_iWarpSight = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AbilitySight", "Ability Sight", "Ability_Sight", "sight", g_esWarpPlayer[admin].g_iWarpSight, value, -1, 5);
			g_esWarpPlayer[admin].g_flWarpChance = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpChance", "Warp Chance", "Warp_Chance", "chance", g_esWarpPlayer[admin].g_flWarpChance, value, -1.0, 100.0);
			g_esWarpPlayer[admin].g_iWarpCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpCooldown", "Warp Cooldown", "Warp_Cooldown", "cooldown", g_esWarpPlayer[admin].g_iWarpCooldown, value, -1, 99999);
			g_esWarpPlayer[admin].g_iWarpDuration = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpDuration", "Warp Duration", "Warp_Duration", "duration", g_esWarpPlayer[admin].g_iWarpDuration, value, -1, 99999);
			g_esWarpPlayer[admin].g_iWarpHit = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpHit", "Warp Hit", "Warp_Hit", "hit", g_esWarpPlayer[admin].g_iWarpHit, value, -1, 1);
			g_esWarpPlayer[admin].g_iWarpHitMode = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpHitMode", "Warp Hit Mode", "Warp_Hit_Mode", "hitmode", g_esWarpPlayer[admin].g_iWarpHitMode, value, -1, 2);
			g_esWarpPlayer[admin].g_flWarpInterval = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpInterval", "Warp Interval", "Warp_Interval", "interval", g_esWarpPlayer[admin].g_flWarpInterval, value, -1.0, 99999.0);
			g_esWarpPlayer[admin].g_iWarpMode = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpMode", "Warp Mode", "Warp_Mode", "mode", g_esWarpPlayer[admin].g_iWarpMode, value, -1, 3);
			g_esWarpPlayer[admin].g_flWarpRange = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRange", "Warp Range", "Warp_Range", "range", g_esWarpPlayer[admin].g_flWarpRange, value, -1.0, 99999.0);
			g_esWarpPlayer[admin].g_flWarpRangeChance = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRangeChance", "Warp Range Chance", "Warp_Range_Chance", "rangechance", g_esWarpPlayer[admin].g_flWarpRangeChance, value, -1.0, 100.0);
			g_esWarpPlayer[admin].g_iWarpRangeCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRangeCooldown", "Warp Range Cooldown", "Warp_Range_Cooldown", "rangecooldown", g_esWarpPlayer[admin].g_iWarpRangeCooldown, value, -1, 99999);
			g_esWarpPlayer[admin].g_iWarpRockBreak = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRockBreak", "Warp Rock Break", "Warp_Rock_Break", "rock", g_esWarpPlayer[admin].g_iWarpRockBreak, value, -1, 1);
			g_esWarpPlayer[admin].g_flWarpRockChance = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRockChance", "Warp Rock Chance", "Warp_Rock_Chance", "rockchance", g_esWarpPlayer[admin].g_flWarpRockChance, value, -1.0, 100.0);
			g_esWarpPlayer[admin].g_iWarpRockCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRockCooldown", "Warp Rock Cooldown", "Warp_Rock_Cooldown", "rockcooldown", g_esWarpPlayer[admin].g_iWarpRockCooldown, value, -1, 99999);
			g_esWarpPlayer[admin].g_iAccessFlags = iGetAdminFlagsValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AccessFlags", "Access Flags", "Access_Flags", "access", value);
			g_esWarpPlayer[admin].g_iImmunityFlags = iGetAdminFlagsValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "ImmunityFlags", "Immunity Flags", "Immunity_Flags", "immunity", value);
		}
	}

	if (mode < 3 && type > 0)
	{
		if (special && specsection[0] != '\0')
		{
			g_esWarpSpecial[type].g_flCloseAreasOnly = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "CloseAreasOnly", "Close Areas Only", "Close_Areas_Only", "closeareas", g_esWarpSpecial[type].g_flCloseAreasOnly, value, -1.0, 99999.0);
			g_esWarpSpecial[type].g_iComboAbility = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "ComboAbility", "Combo Ability", "Combo_Ability", "combo", g_esWarpSpecial[type].g_iComboAbility, value, -1, 1);
			g_esWarpSpecial[type].g_iHumanAbility = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanAbility", "Human Ability", "Human_Ability", "human", g_esWarpSpecial[type].g_iHumanAbility, value, -1, 2);
			g_esWarpSpecial[type].g_iHumanAmmo = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanAmmo", "Human Ammo", "Human_Ammo", "hammo", g_esWarpSpecial[type].g_iHumanAmmo, value, -1, 99999);
			g_esWarpSpecial[type].g_iHumanCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanCooldown", "Human Cooldown", "Human_Cooldown", "hcooldown", g_esWarpSpecial[type].g_iHumanCooldown, value, -1, 99999);
			g_esWarpSpecial[type].g_iHumanDuration = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanDuration", "Human Duration", "Human_Duration", "hduration", g_esWarpSpecial[type].g_iHumanDuration, value, -1, 99999);
			g_esWarpSpecial[type].g_iHumanMode = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanMode", "Human Mode", "Human_Mode", "hmode", g_esWarpSpecial[type].g_iHumanMode, value, -1, 1);
			g_esWarpSpecial[type].g_iHumanRangeCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanRangeCooldown", "Human Range Cooldown", "Human_Range_Cooldown", "hrangecooldown", g_esWarpSpecial[type].g_iHumanRangeCooldown, value, -1, 99999);
			g_esWarpSpecial[type].g_iHumanRockCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanRockCooldown", "Human Rock Cooldown", "Human_Rock_Cooldown", "hrockcooldown", g_esWarpSpecial[type].g_iHumanRockCooldown, value, -1, 99999);
			g_esWarpSpecial[type].g_flOpenAreasOnly = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "OpenAreasOnly", "Open Areas Only", "Open_Areas_Only", "openareas", g_esWarpSpecial[type].g_flOpenAreasOnly, value, -1.0, 99999.0);
			g_esWarpSpecial[type].g_iRequiresHumans = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "RequiresHumans", "Requires Humans", "Requires_Humans", "hrequire", g_esWarpSpecial[type].g_iRequiresHumans, value, -1, 32);
			g_esWarpSpecial[type].g_iWarpAbility = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AbilityEnabled", "Ability Enabled", "Ability_Enabled", "aenabled", g_esWarpSpecial[type].g_iWarpAbility, value, -1, 3);
			g_esWarpSpecial[type].g_iWarpEffect = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AbilityEffect", "Ability Effect", "Ability_Effect", "effect", g_esWarpSpecial[type].g_iWarpEffect, value, -1, 7);
			g_esWarpSpecial[type].g_iWarpMessage = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AbilityMessage", "Ability Message", "Ability_Message", "message", g_esWarpSpecial[type].g_iWarpMessage, value, -1, 7);
			g_esWarpSpecial[type].g_iWarpSight = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AbilitySight", "Ability Sight", "Ability_Sight", "sight", g_esWarpSpecial[type].g_iWarpSight, value, -1, 5);
			g_esWarpSpecial[type].g_flWarpChance = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpChance", "Warp Chance", "Warp_Chance", "chance", g_esWarpSpecial[type].g_flWarpChance, value, -1.0, 100.0);
			g_esWarpSpecial[type].g_iWarpCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpCooldown", "Warp Cooldown", "Warp_Cooldown", "cooldown", g_esWarpSpecial[type].g_iWarpCooldown, value, -1, 99999);
			g_esWarpSpecial[type].g_iWarpDuration = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpDuration", "Warp Duration", "Warp_Duration", "duration", g_esWarpSpecial[type].g_iWarpDuration, value, -1, 99999);
			g_esWarpSpecial[type].g_iWarpHit = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpHit", "Warp Hit", "Warp_Hit", "hit", g_esWarpSpecial[type].g_iWarpHit, value, -1, 1);
			g_esWarpSpecial[type].g_iWarpHitMode = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpHitMode", "Warp Hit Mode", "Warp_Hit_Mode", "hitmode", g_esWarpSpecial[type].g_iWarpHitMode, value, -1, 2);
			g_esWarpSpecial[type].g_flWarpInterval = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpInterval", "Warp Interval", "Warp_Interval", "interval", g_esWarpSpecial[type].g_flWarpInterval, value, -1.0, 99999.0);
			g_esWarpSpecial[type].g_iWarpMode = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpMode", "Warp Mode", "Warp_Mode", "mode", g_esWarpSpecial[type].g_iWarpMode, value, -1, 3);
			g_esWarpSpecial[type].g_flWarpRange = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRange", "Warp Range", "Warp_Range", "range", g_esWarpSpecial[type].g_flWarpRange, value, -1.0, 99999.0);
			g_esWarpSpecial[type].g_flWarpRangeChance = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRangeChance", "Warp Range Chance", "Warp_Range_Chance", "rangechance", g_esWarpSpecial[type].g_flWarpRangeChance, value, -1.0, 100.0);
			g_esWarpSpecial[type].g_iWarpRangeCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRangeCooldown", "Warp Range Cooldown", "Warp_Range_Cooldown", "rangecooldown", g_esWarpSpecial[type].g_iWarpRangeCooldown, value, -1, 99999);
			g_esWarpSpecial[type].g_iWarpRockBreak = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRockBreak", "Warp Rock Break", "Warp_Rock_Break", "rock", g_esWarpSpecial[type].g_iWarpRockBreak, value, -1, 1);
			g_esWarpSpecial[type].g_flWarpRockChance = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRockChance", "Warp Rock Chance", "Warp_Rock_Chance", "rockchance", g_esWarpSpecial[type].g_flWarpRockChance, value, -1.0, 100.0);
			g_esWarpSpecial[type].g_iWarpRockCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRockCooldown", "Warp Rock Cooldown", "Warp_Rock_Cooldown", "rockcooldown", g_esWarpSpecial[type].g_iWarpRockCooldown, value, -1, 99999);
		}
		else
		{
			g_esWarpAbility[type].g_flCloseAreasOnly = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "CloseAreasOnly", "Close Areas Only", "Close_Areas_Only", "closeareas", g_esWarpAbility[type].g_flCloseAreasOnly, value, -1.0, 99999.0);
			g_esWarpAbility[type].g_iComboAbility = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "ComboAbility", "Combo Ability", "Combo_Ability", "combo", g_esWarpAbility[type].g_iComboAbility, value, -1, 1);
			g_esWarpAbility[type].g_iHumanAbility = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanAbility", "Human Ability", "Human_Ability", "human", g_esWarpAbility[type].g_iHumanAbility, value, -1, 2);
			g_esWarpAbility[type].g_iHumanAmmo = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanAmmo", "Human Ammo", "Human_Ammo", "hammo", g_esWarpAbility[type].g_iHumanAmmo, value, -1, 99999);
			g_esWarpAbility[type].g_iHumanCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanCooldown", "Human Cooldown", "Human_Cooldown", "hcooldown", g_esWarpAbility[type].g_iHumanCooldown, value, -1, 99999);
			g_esWarpAbility[type].g_iHumanDuration = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanDuration", "Human Duration", "Human_Duration", "hduration", g_esWarpAbility[type].g_iHumanDuration, value, -1, 99999);
			g_esWarpAbility[type].g_iHumanMode = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanMode", "Human Mode", "Human_Mode", "hmode", g_esWarpAbility[type].g_iHumanMode, value, -1, 1);
			g_esWarpAbility[type].g_iHumanRangeCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanRangeCooldown", "Human Range Cooldown", "Human_Range_Cooldown", "hrangecooldown", g_esWarpAbility[type].g_iHumanRangeCooldown, value, -1, 99999);
			g_esWarpAbility[type].g_iHumanRockCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "HumanRockCooldown", "Human Rock Cooldown", "Human_Rock_Cooldown", "hrockcooldown", g_esWarpAbility[type].g_iHumanRockCooldown, value, -1, 99999);
			g_esWarpAbility[type].g_flOpenAreasOnly = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "OpenAreasOnly", "Open Areas Only", "Open_Areas_Only", "openareas", g_esWarpAbility[type].g_flOpenAreasOnly, value, -1.0, 99999.0);
			g_esWarpAbility[type].g_iRequiresHumans = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "RequiresHumans", "Requires Humans", "Requires_Humans", "hrequire", g_esWarpAbility[type].g_iRequiresHumans, value, -1, 32);
			g_esWarpAbility[type].g_iWarpAbility = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AbilityEnabled", "Ability Enabled", "Ability_Enabled", "aenabled", g_esWarpAbility[type].g_iWarpAbility, value, -1, 3);
			g_esWarpAbility[type].g_iWarpEffect = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AbilityEffect", "Ability Effect", "Ability_Effect", "effect", g_esWarpAbility[type].g_iWarpEffect, value, -1, 7);
			g_esWarpAbility[type].g_iWarpMessage = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AbilityMessage", "Ability Message", "Ability_Message", "message", g_esWarpAbility[type].g_iWarpMessage, value, -1, 7);
			g_esWarpAbility[type].g_iWarpSight = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AbilitySight", "Ability Sight", "Ability_Sight", "sight", g_esWarpAbility[type].g_iWarpSight, value, -1, 5);
			g_esWarpAbility[type].g_flWarpChance = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpChance", "Warp Chance", "Warp_Chance", "chance", g_esWarpAbility[type].g_flWarpChance, value, -1.0, 100.0);
			g_esWarpAbility[type].g_iWarpCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpCooldown", "Warp Cooldown", "Warp_Cooldown", "cooldown", g_esWarpAbility[type].g_iWarpCooldown, value, -1, 99999);
			g_esWarpAbility[type].g_iWarpDuration = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpDuration", "Warp Duration", "Warp_Duration", "duration", g_esWarpAbility[type].g_iWarpDuration, value, -1, 99999);
			g_esWarpAbility[type].g_iWarpHit = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpHit", "Warp Hit", "Warp_Hit", "hit", g_esWarpAbility[type].g_iWarpHit, value, -1, 1);
			g_esWarpAbility[type].g_iWarpHitMode = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpHitMode", "Warp Hit Mode", "Warp_Hit_Mode", "hitmode", g_esWarpAbility[type].g_iWarpHitMode, value, -1, 2);
			g_esWarpAbility[type].g_flWarpInterval = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpInterval", "Warp Interval", "Warp_Interval", "interval", g_esWarpAbility[type].g_flWarpInterval, value, -1.0, 99999.0);
			g_esWarpAbility[type].g_iWarpMode = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpMode", "Warp Mode", "Warp_Mode", "mode", g_esWarpAbility[type].g_iWarpMode, value, -1, 3);
			g_esWarpAbility[type].g_flWarpRange = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRange", "Warp Range", "Warp_Range", "range", g_esWarpAbility[type].g_flWarpRange, value, -1.0, 99999.0);
			g_esWarpAbility[type].g_flWarpRangeChance = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRangeChance", "Warp Range Chance", "Warp_Range_Chance", "rangechance", g_esWarpAbility[type].g_flWarpRangeChance, value, -1.0, 100.0);
			g_esWarpAbility[type].g_iWarpRangeCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRangeCooldown", "Warp Range Cooldown", "Warp_Range_Cooldown", "rangecooldown", g_esWarpAbility[type].g_iWarpRangeCooldown, value, -1, 99999);
			g_esWarpAbility[type].g_iWarpRockBreak = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRockBreak", "Warp Rock Break", "Warp_Rock_Break", "rock", g_esWarpAbility[type].g_iWarpRockBreak, value, -1, 1);
			g_esWarpAbility[type].g_flWarpRockChance = flGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRockChance", "Warp Rock Chance", "Warp_Rock_Chance", "rockchance", g_esWarpAbility[type].g_flWarpRockChance, value, -1.0, 100.0);
			g_esWarpAbility[type].g_iWarpRockCooldown = iGetKeyValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "WarpRockCooldown", "Warp Rock Cooldown", "Warp_Rock_Cooldown", "rockcooldown", g_esWarpAbility[type].g_iWarpRockCooldown, value, -1, 99999);
			g_esWarpAbility[type].g_iAccessFlags = iGetAdminFlagsValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "AccessFlags", "Access Flags", "Access_Flags", "access", value);
			g_esWarpAbility[type].g_iImmunityFlags = iGetAdminFlagsValue(subsection, MT_WARP_SECTION, MT_WARP_SECTION2, MT_WARP_SECTION3, MT_WARP_SECTION4, key, "ImmunityFlags", "Immunity Flags", "Immunity_Flags", "immunity", value);
		}
	}
}

#if defined MT_ABILITIES_MAIN2
void vWarpSettingsCached(int tank, bool apply, int type)
#else
public void MT_OnSettingsCached(int tank, bool apply, int type)
#endif
{
	bool bHuman = bIsValidClient(tank, MT_CHECK_FAKECLIENT);
	g_esWarpPlayer[tank].g_iInfectedType = iGetInfectedType(tank);
	g_esWarpPlayer[tank].g_iTankTypeRecorded = apply ? MT_GetRecordedTankType(tank, type) : 0;
	g_esWarpPlayer[tank].g_iTankType = apply ? type : 0;
	int iType = g_esWarpPlayer[tank].g_iTankTypeRecorded;

	if (bIsSpecialInfected(tank, MT_CHECK_INDEX|MT_CHECK_INGAME))
	{
		g_esWarpCache[tank].g_flCloseAreasOnly = flGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_flCloseAreasOnly, g_esWarpPlayer[tank].g_flCloseAreasOnly, g_esWarpSpecial[iType].g_flCloseAreasOnly, g_esWarpAbility[iType].g_flCloseAreasOnly, 1);
		g_esWarpCache[tank].g_iComboAbility = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iComboAbility, g_esWarpPlayer[tank].g_iComboAbility, g_esWarpSpecial[iType].g_iComboAbility, g_esWarpAbility[iType].g_iComboAbility, 1);
		g_esWarpCache[tank].g_flWarpChance = flGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_flWarpChance, g_esWarpPlayer[tank].g_flWarpChance, g_esWarpSpecial[iType].g_flWarpChance, g_esWarpAbility[iType].g_flWarpChance, 1);
		g_esWarpCache[tank].g_flWarpInterval = flGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_flWarpInterval, g_esWarpPlayer[tank].g_flWarpInterval, g_esWarpSpecial[iType].g_flWarpInterval, g_esWarpAbility[iType].g_flWarpInterval, 1);
		g_esWarpCache[tank].g_flWarpRange = flGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_flWarpRange, g_esWarpPlayer[tank].g_flWarpRange, g_esWarpSpecial[iType].g_flWarpRange, g_esWarpAbility[iType].g_flWarpRange, 1);
		g_esWarpCache[tank].g_flWarpRangeChance = flGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_flWarpRangeChance, g_esWarpPlayer[tank].g_flWarpRangeChance, g_esWarpSpecial[iType].g_flWarpRangeChance, g_esWarpAbility[iType].g_flWarpRangeChance, 1);
		g_esWarpCache[tank].g_flWarpRockChance = flGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_flWarpRockChance, g_esWarpPlayer[tank].g_flWarpRockChance, g_esWarpSpecial[iType].g_flWarpRockChance, g_esWarpAbility[iType].g_flWarpRockChance, 1);
		g_esWarpCache[tank].g_iHumanAbility = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iHumanAbility, g_esWarpPlayer[tank].g_iHumanAbility, g_esWarpSpecial[iType].g_iHumanAbility, g_esWarpAbility[iType].g_iHumanAbility, 1);
		g_esWarpCache[tank].g_iHumanAmmo = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iHumanAmmo, g_esWarpPlayer[tank].g_iHumanAmmo, g_esWarpSpecial[iType].g_iHumanAmmo, g_esWarpAbility[iType].g_iHumanAmmo, 1);
		g_esWarpCache[tank].g_iHumanCooldown = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iHumanCooldown, g_esWarpPlayer[tank].g_iHumanCooldown, g_esWarpSpecial[iType].g_iHumanCooldown, g_esWarpAbility[iType].g_iHumanCooldown, 1);
		g_esWarpCache[tank].g_iHumanDuration = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iHumanDuration, g_esWarpPlayer[tank].g_iHumanDuration, g_esWarpSpecial[iType].g_iHumanDuration, g_esWarpAbility[iType].g_iHumanDuration, 1);
		g_esWarpCache[tank].g_iHumanMode = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iHumanMode, g_esWarpPlayer[tank].g_iHumanMode, g_esWarpSpecial[iType].g_iHumanMode, g_esWarpAbility[iType].g_iHumanMode, 1);
		g_esWarpCache[tank].g_iHumanRangeCooldown = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iHumanRangeCooldown, g_esWarpPlayer[tank].g_iHumanRangeCooldown, g_esWarpSpecial[iType].g_iHumanRangeCooldown, g_esWarpAbility[iType].g_iHumanRangeCooldown, 1);
		g_esWarpCache[tank].g_iHumanRockCooldown = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iHumanRockCooldown, g_esWarpPlayer[tank].g_iHumanRockCooldown, g_esWarpSpecial[iType].g_iHumanRockCooldown, g_esWarpAbility[iType].g_iHumanRockCooldown, 1);
		g_esWarpCache[tank].g_flOpenAreasOnly = flGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_flOpenAreasOnly, g_esWarpPlayer[tank].g_flOpenAreasOnly, g_esWarpSpecial[iType].g_flOpenAreasOnly, g_esWarpAbility[iType].g_flOpenAreasOnly, 1);
		g_esWarpCache[tank].g_iRequiresHumans = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iRequiresHumans, g_esWarpPlayer[tank].g_iRequiresHumans, g_esWarpSpecial[iType].g_iRequiresHumans, g_esWarpAbility[iType].g_iRequiresHumans, 1);
		g_esWarpCache[tank].g_iWarpAbility = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iWarpAbility, g_esWarpPlayer[tank].g_iWarpAbility, g_esWarpSpecial[iType].g_iWarpAbility, g_esWarpAbility[iType].g_iWarpAbility, 1);
		g_esWarpCache[tank].g_iWarpCooldown = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iWarpCooldown, g_esWarpPlayer[tank].g_iWarpCooldown, g_esWarpSpecial[iType].g_iWarpCooldown, g_esWarpAbility[iType].g_iWarpCooldown, 1);
		g_esWarpCache[tank].g_iWarpDuration = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iWarpDuration, g_esWarpPlayer[tank].g_iWarpDuration, g_esWarpSpecial[iType].g_iWarpDuration, g_esWarpAbility[iType].g_iWarpDuration, 1);
		g_esWarpCache[tank].g_iWarpEffect = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iWarpEffect, g_esWarpPlayer[tank].g_iWarpEffect, g_esWarpSpecial[iType].g_iWarpEffect, g_esWarpAbility[iType].g_iWarpEffect, 1);
		g_esWarpCache[tank].g_iWarpHit = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iWarpHit, g_esWarpPlayer[tank].g_iWarpHit, g_esWarpSpecial[iType].g_iWarpHit, g_esWarpAbility[iType].g_iWarpHit, 1);
		g_esWarpCache[tank].g_iWarpHitMode = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iWarpHitMode, g_esWarpPlayer[tank].g_iWarpHitMode, g_esWarpSpecial[iType].g_iWarpHitMode, g_esWarpAbility[iType].g_iWarpHitMode, 1);
		g_esWarpCache[tank].g_iWarpMessage = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iWarpMessage, g_esWarpPlayer[tank].g_iWarpMessage, g_esWarpSpecial[iType].g_iWarpMessage, g_esWarpAbility[iType].g_iWarpMessage, 1);
		g_esWarpCache[tank].g_iWarpMode = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iWarpMode, g_esWarpPlayer[tank].g_iWarpMode, g_esWarpSpecial[iType].g_iWarpMode, g_esWarpAbility[iType].g_iWarpMode, 1);
		g_esWarpCache[tank].g_iWarpRangeCooldown = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iWarpRangeCooldown, g_esWarpPlayer[tank].g_iWarpRangeCooldown, g_esWarpSpecial[iType].g_iWarpRangeCooldown, g_esWarpAbility[iType].g_iWarpRangeCooldown, 1);
		g_esWarpCache[tank].g_iWarpSight = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iWarpSight, g_esWarpPlayer[tank].g_iWarpSight, g_esWarpSpecial[iType].g_iWarpSight, g_esWarpAbility[iType].g_iWarpSight, 1);
		g_esWarpCache[tank].g_iWarpRockBreak = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iWarpRockBreak, g_esWarpPlayer[tank].g_iWarpRockBreak, g_esWarpSpecial[iType].g_iWarpRockBreak, g_esWarpAbility[iType].g_iWarpRockBreak, 1);
		g_esWarpCache[tank].g_iWarpRockCooldown = iGetSubSettingValue(apply, bHuman, g_esWarpTeammate[tank].g_iWarpRockCooldown, g_esWarpPlayer[tank].g_iWarpRockCooldown, g_esWarpSpecial[iType].g_iWarpRockCooldown, g_esWarpAbility[iType].g_iWarpRockCooldown, 1);
	}
	else
	{
		g_esWarpCache[tank].g_flCloseAreasOnly = flGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_flCloseAreasOnly, g_esWarpAbility[iType].g_flCloseAreasOnly, 1);
		g_esWarpCache[tank].g_iComboAbility = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iComboAbility, g_esWarpAbility[iType].g_iComboAbility, 1);
		g_esWarpCache[tank].g_flWarpChance = flGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_flWarpChance, g_esWarpAbility[iType].g_flWarpChance, 1);
		g_esWarpCache[tank].g_flWarpInterval = flGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_flWarpInterval, g_esWarpAbility[iType].g_flWarpInterval, 1);
		g_esWarpCache[tank].g_flWarpRange = flGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_flWarpRange, g_esWarpAbility[iType].g_flWarpRange, 1);
		g_esWarpCache[tank].g_flWarpRangeChance = flGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_flWarpRangeChance, g_esWarpAbility[iType].g_flWarpRangeChance, 1);
		g_esWarpCache[tank].g_flWarpRockChance = flGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_flWarpRockChance, g_esWarpAbility[iType].g_flWarpRockChance, 1);
		g_esWarpCache[tank].g_iHumanAbility = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iHumanAbility, g_esWarpAbility[iType].g_iHumanAbility, 1);
		g_esWarpCache[tank].g_iHumanAmmo = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iHumanAmmo, g_esWarpAbility[iType].g_iHumanAmmo, 1);
		g_esWarpCache[tank].g_iHumanCooldown = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iHumanCooldown, g_esWarpAbility[iType].g_iHumanCooldown, 1);
		g_esWarpCache[tank].g_iHumanDuration = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iHumanDuration, g_esWarpAbility[iType].g_iHumanDuration, 1);
		g_esWarpCache[tank].g_iHumanMode = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iHumanMode, g_esWarpAbility[iType].g_iHumanMode, 1);
		g_esWarpCache[tank].g_iHumanRangeCooldown = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iHumanRangeCooldown, g_esWarpAbility[iType].g_iHumanRangeCooldown, 1);
		g_esWarpCache[tank].g_iHumanRockCooldown = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iHumanRockCooldown, g_esWarpAbility[iType].g_iHumanRockCooldown, 1);
		g_esWarpCache[tank].g_flOpenAreasOnly = flGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_flOpenAreasOnly, g_esWarpAbility[iType].g_flOpenAreasOnly, 1);
		g_esWarpCache[tank].g_iRequiresHumans = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iRequiresHumans, g_esWarpAbility[iType].g_iRequiresHumans, 1);
		g_esWarpCache[tank].g_iWarpAbility = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iWarpAbility, g_esWarpAbility[iType].g_iWarpAbility, 1);
		g_esWarpCache[tank].g_iWarpCooldown = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iWarpCooldown, g_esWarpAbility[iType].g_iWarpCooldown, 1);
		g_esWarpCache[tank].g_iWarpDuration = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iWarpDuration, g_esWarpAbility[iType].g_iWarpDuration, 1);
		g_esWarpCache[tank].g_iWarpEffect = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iWarpEffect, g_esWarpAbility[iType].g_iWarpEffect, 1);
		g_esWarpCache[tank].g_iWarpHit = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iWarpHit, g_esWarpAbility[iType].g_iWarpHit, 1);
		g_esWarpCache[tank].g_iWarpHitMode = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iWarpHitMode, g_esWarpAbility[iType].g_iWarpHitMode, 1);
		g_esWarpCache[tank].g_iWarpMessage = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iWarpMessage, g_esWarpAbility[iType].g_iWarpMessage, 1);
		g_esWarpCache[tank].g_iWarpMode = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iWarpMode, g_esWarpAbility[iType].g_iWarpMode, 1);
		g_esWarpCache[tank].g_iWarpRangeCooldown = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iWarpRangeCooldown, g_esWarpAbility[iType].g_iWarpRangeCooldown, 1);
		g_esWarpCache[tank].g_iWarpSight = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iWarpSight, g_esWarpAbility[iType].g_iWarpSight, 1);
		g_esWarpCache[tank].g_iWarpRockBreak = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iWarpRockBreak, g_esWarpAbility[iType].g_iWarpRockBreak, 1);
		g_esWarpCache[tank].g_iWarpRockCooldown = iGetSettingValue(apply, bHuman, g_esWarpPlayer[tank].g_iWarpRockCooldown, g_esWarpAbility[iType].g_iWarpRockCooldown, 1);
	}
}

#if defined MT_ABILITIES_MAIN2
void vWarpCopyStats(int oldTank, int newTank)
#else
public void MT_OnCopyStats(int oldTank, int newTank)
#endif
{
	vWarpCopyStats2(oldTank, newTank);

	if (oldTank != newTank)
	{
		vRemoveWarp(oldTank);
	}
}

#if !defined MT_ABILITIES_MAIN2
public void MT_OnPluginUpdate()
{
	MT_ReloadPlugin(null);
}
#endif

#if defined MT_ABILITIES_MAIN2
void vWarpEventFired(Event event, const char[] name)
#else
public void MT_OnEventFired(Event event, const char[] name, bool dontBroadcast)
#endif
{
	if (StrEqual(name, "bot_player_replace"))
	{
		int iBotId = event.GetInt("bot"), iBot = GetClientOfUserId(iBotId),
			iTankId = event.GetInt("player"), iTank = GetClientOfUserId(iTankId);
		if (bIsValidClient(iBot) && bIsInfected(iTank))
		{
			vWarpCopyStats2(iBot, iTank);
			vRemoveWarp(iBot);
		}
	}
	else if (StrEqual(name, "mission_lost") || StrEqual(name, "round_start") || StrEqual(name, "round_end"))
	{
		vWarpReset();
	}
	else if (StrEqual(name, "player_bot_replace"))
	{
		int iTankId = event.GetInt("player"), iTank = GetClientOfUserId(iTankId),
			iBotId = event.GetInt("bot"), iBot = GetClientOfUserId(iBotId);
		if (bIsValidClient(iTank) && bIsInfected(iBot))
		{
			vWarpCopyStats2(iTank, iBot);
			vRemoveWarp(iTank);
		}
	}
	else if (StrEqual(name, "player_death") || StrEqual(name, "player_spawn"))
	{
		int iTankId = event.GetInt("userid"), iTank = GetClientOfUserId(iTankId);
		if (MT_IsTankSupported(iTank, MT_CHECK_INDEX|MT_CHECK_INGAME))
		{
			vWarpRange(iTank);
			vRemoveWarp(iTank);
		}
	}
	else if (StrEqual(name, "player_now_it"))
	{
		bool bExploded = event.GetBool("exploded");
		int iSurvivorId = event.GetInt("userid"), iSurvivor = GetClientOfUserId(iSurvivorId),
			iBoomerId = event.GetInt("attacker"), iBoomer = GetClientOfUserId(iBoomerId);
		if (bIsBoomer(iBoomer) && bIsSurvivor(iSurvivor) && !bExploded)
		{
			vWarpHit(iSurvivor, iBoomer, GetRandomFloat(0.1, 100.0), g_esWarpCache[iBoomer].g_flWarpChance, g_esWarpCache[iBoomer].g_iWarpHit, MT_MESSAGE_RANGE, MT_ATTACK_RANGE);
		}
	}
}

#if defined MT_ABILITIES_MAIN2
void vWarpPlayerEventKilled(int victim)
#else
public void MT_OnPlayerEventKilled(int victim, int attacker)
#endif
{
	if (MT_IsTankSupported(victim, MT_CHECK_INDEX|MT_CHECK_INGAME))
	{
		bool bTeleport = false;
		float flOrigin[3], flAngles[3];
		int iTeammate = 0;
		for (iTeammate = 1; iTeammate <= MaxClients; iTeammate++)
		{
			if (bIsSurvivor(iTeammate, MT_CHECK_INGAME|MT_CHECK_ALIVE) && !bIsSurvivorDisabled(iTeammate) && !g_esWarpPlayer[iTeammate].g_bAffected)
			{
				bTeleport = true;

				GetClientAbsOrigin(iTeammate, flOrigin);
				GetClientEyeAngles(iTeammate, flAngles);

				break;
			}
		}

		if (bTeleport)
		{
			for (int iSurvivor = 1; iSurvivor <= MaxClients; iSurvivor++)
			{
				if (bIsSurvivor(iSurvivor, MT_CHECK_INGAME|MT_CHECK_ALIVE) && g_esWarpPlayer[iSurvivor].g_bAffected && g_esWarpPlayer[iSurvivor].g_iOwner == victim && iSurvivor != iTeammate)
				{
					g_esWarpPlayer[iSurvivor].g_bAffected = false;
					g_esWarpPlayer[iSurvivor].g_iOwner = -1;

					TeleportEntity(iSurvivor, flOrigin, flAngles, view_as<float>({0.0, 0.0, 0.0}));
					vFixPlayerPosition(iSurvivor);
				}
			}
		}
	}
}

#if defined MT_ABILITIES_MAIN2
void vWarpAbilityActivated(int tank)
#else
public void MT_OnAbilityActivated(int tank)
#endif
{
	if (MT_IsTankSupported(tank, MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_FAKECLIENT) && ((!MT_HasAdminAccess(tank) && !bHasAdminAccess(tank, g_esWarpAbility[g_esWarpPlayer[tank].g_iTankTypeRecorded].g_iAccessFlags, g_esWarpPlayer[tank].g_iAccessFlags)) || g_esWarpCache[tank].g_iHumanAbility == 0))
	{
		return;
	}

	if (MT_IsTankSupported(tank) && (!bIsInfected(tank, MT_CHECK_FAKECLIENT) || g_esWarpCache[tank].g_iHumanAbility != 1) && MT_IsCustomTankSupported(tank) && g_esWarpCache[tank].g_iWarpAbility > 0 && g_esWarpCache[tank].g_iComboAbility == 0)
	{
		vWarpAbility(tank, false);
		vWarpAbility(tank, true, GetRandomFloat(0.1, 100.0));
	}
}

#if defined MT_ABILITIES_MAIN2
void vWarpButtonPressed(int tank, int button)
#else
public void MT_OnButtonPressed(int tank, int button)
#endif
{
	if (MT_IsTankSupported(tank, MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_ALIVE|MT_CHECK_FAKECLIENT) && MT_IsCustomTankSupported(tank))
	{
		if (bIsAreaNarrow(tank, g_esWarpCache[tank].g_flOpenAreasOnly) || bIsAreaWide(tank, g_esWarpCache[tank].g_flCloseAreasOnly) || MT_DoesTypeRequireHumans(g_esWarpPlayer[tank].g_iTankType, tank) || (g_esWarpCache[tank].g_iRequiresHumans > 0 && iGetHumanCount() < g_esWarpCache[tank].g_iRequiresHumans) || (!MT_HasAdminAccess(tank) && !bHasAdminAccess(tank, g_esWarpAbility[g_esWarpPlayer[tank].g_iTankTypeRecorded].g_iAccessFlags, g_esWarpPlayer[tank].g_iAccessFlags)))
		{
			return;
		}

		int iTime = GetTime();
		if ((button & MT_MAIN_KEY) && (g_esWarpCache[tank].g_iWarpAbility == 2 || g_esWarpCache[tank].g_iWarpAbility == 3) && g_esWarpCache[tank].g_iHumanAbility == 1)
		{
			bool bRecharging = g_esWarpPlayer[tank].g_iCooldown != -1 && g_esWarpPlayer[tank].g_iCooldown >= iTime;

			switch (g_esWarpCache[tank].g_iHumanMode)
			{
				case 0:
				{
					if (!g_esWarpPlayer[tank].g_bActivated && !bRecharging)
					{
						vWarpAbility(tank, false);
					}
					else if (g_esWarpPlayer[tank].g_bActivated)
					{
						MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpHuman4");
					}
					else if (bRecharging)
					{
						MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpHuman5", (g_esWarpPlayer[tank].g_iCooldown - iTime));
					}
				}
				case 1:
				{
					if (g_esWarpPlayer[tank].g_iAmmoCount < g_esWarpCache[tank].g_iHumanAmmo && g_esWarpCache[tank].g_iHumanAmmo > 0)
					{
						if (!g_esWarpPlayer[tank].g_bActivated && !bRecharging)
						{
							g_esWarpPlayer[tank].g_bActivated = true;
							g_esWarpPlayer[tank].g_iAmmoCount++;

							vWarp(tank);
							MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpHuman", g_esWarpPlayer[tank].g_iAmmoCount, g_esWarpCache[tank].g_iHumanAmmo);
						}
						else if (g_esWarpPlayer[tank].g_bActivated)
						{
							MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpHuman4");
						}
						else if (bRecharging)
						{
							MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpHuman5", (g_esWarpPlayer[tank].g_iCooldown - iTime));
						}
					}
					else
					{
						MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpAmmo");
					}
				}
			}
		}

		if ((button & MT_SUB_KEY) && (g_esWarpCache[tank].g_iWarpAbility == 1 || g_esWarpCache[tank].g_iWarpAbility == 3) && g_esWarpCache[tank].g_iHumanAbility == 1)
		{
			switch (g_esWarpPlayer[tank].g_iRangeCooldown == -1 || g_esWarpPlayer[tank].g_iRangeCooldown <= iTime)
			{
				case true: vWarpAbility(tank, true, GetRandomFloat(0.1, 100.0));
				case false: MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpHuman6", (g_esWarpPlayer[tank].g_iRangeCooldown - iTime));
			}
		}
	}
}

#if defined MT_ABILITIES_MAIN2
void vWarpButtonReleased(int tank, int button)
#else
public void MT_OnButtonReleased(int tank, int button)
#endif
{
	if (MT_IsTankSupported(tank, MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_ALIVE|MT_CHECK_FAKECLIENT) && g_esWarpCache[tank].g_iHumanAbility == 1)
	{
		if ((button & MT_MAIN_KEY) && g_esWarpCache[tank].g_iHumanMode == 1 && g_esWarpPlayer[tank].g_bActivated && (g_esWarpPlayer[tank].g_iCooldown == -1 || g_esWarpPlayer[tank].g_iCooldown <= GetTime()))
		{
			vWarpReset2(tank);
		}
	}
}

#if defined MT_ABILITIES_MAIN2
void vWarpChangeType(int tank, int oldType)
#else
public void MT_OnChangeType(int tank, int oldType, int newType, bool revert)
#endif
{
	if (oldType <= 0)
	{
		return;
	}

	vRemoveWarp(tank);
}

#if defined MT_ABILITIES_MAIN2
void vWarpPostTankSpawn(int tank)
#else
public void MT_OnPostTankSpawn(int tank)
#endif
{
	vWarpRange(tank);
}

#if defined MT_ABILITIES_MAIN2
void vWarpRockBreak(int tank, int rock)
#else
public void MT_OnRockBreak(int tank, int rock)
#endif
{
	if (bIsAreaNarrow(tank, g_esWarpCache[tank].g_flOpenAreasOnly) || bIsAreaWide(tank, g_esWarpCache[tank].g_flCloseAreasOnly) || MT_DoesTypeRequireHumans(g_esWarpPlayer[tank].g_iTankType, tank) || (g_esWarpCache[tank].g_iRequiresHumans > 0 && iGetHumanCount() < g_esWarpCache[tank].g_iRequiresHumans) || (MT_IsTankSupported(tank, MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_FAKECLIENT) && ((!MT_HasAdminAccess(tank) && !bHasAdminAccess(tank, g_esWarpAbility[g_esWarpPlayer[tank].g_iTankTypeRecorded].g_iAccessFlags, g_esWarpPlayer[tank].g_iAccessFlags)) || g_esWarpCache[tank].g_iHumanAbility == 0)))
	{
		return;
	}

	if (MT_IsTankSupported(tank) && MT_IsCustomTankSupported(tank) && g_esWarpCache[tank].g_iWarpRockBreak == 1 && g_esWarpCache[tank].g_iComboAbility == 0)
	{
		vWarpRockBreak2(tank, rock, GetRandomFloat(0.1, 100.0));
	}
}

void vWarp(int tank, int pos = -1)
{
	int iTime = GetTime();
	if ((g_esWarpPlayer[tank].g_iCooldown != -1 && g_esWarpPlayer[tank].g_iCooldown >= iTime) || bIsAreaNarrow(tank, g_esWarpCache[tank].g_flOpenAreasOnly) || bIsAreaWide(tank, g_esWarpCache[tank].g_flCloseAreasOnly) || MT_DoesTypeRequireHumans(g_esWarpPlayer[tank].g_iTankType, tank) || (g_esWarpCache[tank].g_iRequiresHumans > 0 && iGetHumanCount() < g_esWarpCache[tank].g_iRequiresHumans) || (!MT_HasAdminAccess(tank) && !bHasAdminAccess(tank, g_esWarpAbility[g_esWarpPlayer[tank].g_iTankTypeRecorded].g_iAccessFlags, g_esWarpPlayer[tank].g_iAccessFlags)))
	{
		return;
	}

	float flInterval = (pos != -1) ? MT_GetCombinationSetting(tank, 6, pos) : g_esWarpCache[tank].g_flWarpInterval;
	if (flInterval > 0.0)
	{
		DataPack dpWarp;
		CreateDataTimer(flInterval, tTimerWarp, dpWarp, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
		dpWarp.WriteCell(GetClientUserId(tank));
		dpWarp.WriteCell(g_esWarpPlayer[tank].g_iTankType);
		dpWarp.WriteCell(iTime);
		dpWarp.WriteCell(pos);
	}
}

void vWarp2(int tank, int other)
{
	if (bIsAreaNarrow(tank, g_esWarpCache[tank].g_flOpenAreasOnly) || bIsAreaWide(tank, g_esWarpCache[tank].g_flCloseAreasOnly) || MT_DoesTypeRequireHumans(g_esWarpPlayer[tank].g_iTankType, tank) || (g_esWarpCache[tank].g_iRequiresHumans > 0 && iGetHumanCount() < g_esWarpCache[tank].g_iRequiresHumans) || (!MT_HasAdminAccess(tank) && !bHasAdminAccess(tank, g_esWarpAbility[g_esWarpPlayer[tank].g_iTankTypeRecorded].g_iAccessFlags, g_esWarpPlayer[tank].g_iAccessFlags)))
	{
		return;
	}

	float flTankOrigin[3], flTankAngles[3];
	GetClientAbsOrigin(tank, flTankOrigin);
	GetClientAbsAngles(tank, flTankAngles);

	float flOtherOrigin[3], flOtherAngles[3];
	GetClientAbsOrigin(other, flOtherOrigin);
	GetClientAbsAngles(other, flOtherAngles);

	float flTempOrigin[3], flTempAngles[3];
	vCopyVector(flOtherOrigin, flTempOrigin);
	vCopyVector(flOtherAngles, flTempAngles);
	flTempOrigin[0] += (50.0 * (Cosine(DegToRad(flTempAngles[1]))));
	flTempOrigin[1] += (50.0 * (Sine(DegToRad(flTempAngles[1]))));
	flTempOrigin[2] += 5.0;

	float flMin[3], flMax[3];
	GetClientMins(tank, flMin);
	GetClientMaxs(tank, flMax);
	if (bIsPlayerStuck(.min = flMin, .max = flMax, .pos = flTempOrigin))
	{
		return;
	}

	int iVictim = iGetInfectedVictim(tank, g_esWarpPlayer[tank].g_iInfectedType);
	iVictim = (iVictim <= 0) ? tank : iVictim;
	bool bSurvivor = bIsSurvivor(iVictim);
	if (bSurvivor)
	{
		g_esWarpPlayer[iVictim].g_bAffected = true;
		g_esWarpPlayer[iVictim].g_iOwner = tank;

		TeleportEntity(iVictim, flTempOrigin, flTempAngles, view_as<float>({0.0, 0.0, 0.0}));
		vFixPlayerPosition(iVictim);
	}

	TeleportEntity(tank, flTempOrigin, flTempAngles, view_as<float>({0.0, 0.0, 0.0}));
	vFixPlayerPosition(tank);
	vAttachParticle(iVictim, PARTICLE_ELECTRICITY, 1.0);
	EmitSoundToAll(SOUND_ELECTRICITY, iVictim);

	if (bIsPlayerStuck(iVictim))
	{
		if (bSurvivor)
		{
			g_esWarpPlayer[iVictim].g_bAffected = false;
			g_esWarpPlayer[iVictim].g_iOwner = -1;

			TeleportEntity(iVictim, flTankOrigin, flTankAngles, view_as<float>({0.0, 0.0, 0.0}));
		}

		TeleportEntity(tank, flTankOrigin, flTankAngles, view_as<float>({0.0, 0.0, 0.0}));

		return;
	}

	if (!bIsSurvivorCaught(other) && (g_esWarpCache[tank].g_iWarpMode == 1 || g_esWarpCache[tank].g_iWarpMode == 3))
	{
		bool bSurvivor2 = bIsSurvivor(other);
		g_esWarpPlayer[other].g_bAffected = bSurvivor2;
		g_esWarpPlayer[other].g_iOwner = bSurvivor2 ? tank : -1;

		TeleportEntity(other, flTankOrigin, flTankAngles, view_as<float>({0.0, 0.0, 0.0}));
		vFixPlayerPosition(other);
		vAttachParticle(other, PARTICLE_ELECTRICITY, 1.0);
		EmitSoundToAll(SOUND_ELECTRICITY2, other);

		if (bIsPlayerStuck(other))
		{
			if (bSurvivor)
			{
				g_esWarpPlayer[iVictim].g_bAffected = false;
				g_esWarpPlayer[iVictim].g_iOwner = -1;

				TeleportEntity(iVictim, flTankOrigin, flTankAngles, view_as<float>({0.0, 0.0, 0.0}));
			}

			g_esWarpPlayer[other].g_bAffected = false;
			g_esWarpPlayer[other].g_iOwner = -1;

			TeleportEntity(tank, flTankOrigin, flTankAngles, view_as<float>({0.0, 0.0, 0.0}));
			TeleportEntity(other, flOtherOrigin, flOtherAngles, view_as<float>({0.0, 0.0, 0.0}));

			return;
		}
	}

	if (g_esWarpCache[tank].g_iWarpMessage & MT_MESSAGE_SPECIAL)
	{
		char sTankName[64];
		MT_GetTankName(tank, sTankName);
		MT_PrintToChatAll("%s %t", MT_TAG2, "Warp3", sTankName, other);
		MT_LogMessage(MT_LOG_ABILITY, "%s %T", MT_TAG, "Warp3", LANG_SERVER, sTankName, other);
	}
}

void vWarpAbility(int tank, bool main, float random = 0.0, int pos = -1)
{
	if (bIsAreaNarrow(tank, g_esWarpCache[tank].g_flOpenAreasOnly) || bIsAreaWide(tank, g_esWarpCache[tank].g_flCloseAreasOnly) || MT_DoesTypeRequireHumans(g_esWarpPlayer[tank].g_iTankType, tank) || (g_esWarpCache[tank].g_iRequiresHumans > 0 && iGetHumanCount() < g_esWarpCache[tank].g_iRequiresHumans) || (!MT_HasAdminAccess(tank) && !bHasAdminAccess(tank, g_esWarpAbility[g_esWarpPlayer[tank].g_iTankTypeRecorded].g_iAccessFlags, g_esWarpPlayer[tank].g_iAccessFlags)))
	{
		return;
	}

	switch (main)
	{
		case true:
		{
			if (g_esWarpCache[tank].g_iWarpAbility == 1 || g_esWarpCache[tank].g_iWarpAbility == 3)
			{
				if (g_esWarpPlayer[tank].g_iAmmoCount2 < g_esWarpCache[tank].g_iHumanAmmo && g_esWarpCache[tank].g_iHumanAmmo > 0)
				{
					g_esWarpPlayer[tank].g_bFailed = false;
					g_esWarpPlayer[tank].g_bNoAmmo = false;

					float flTankPos[3], flSurvivorPos[3];
					GetClientAbsOrigin(tank, flTankPos);
					float flRange = (pos != -1) ? MT_GetCombinationSetting(tank, 9, pos) : g_esWarpCache[tank].g_flWarpRange,
						flChance = (pos != -1) ? MT_GetCombinationSetting(tank, 10, pos) : g_esWarpCache[tank].g_flWarpRangeChance;
					int iSurvivorCount = 0;
					for (int iSurvivor = 1; iSurvivor <= MaxClients; iSurvivor++)
					{
						if (bIsSurvivor(iSurvivor, MT_CHECK_INGAME|MT_CHECK_ALIVE) && !MT_IsAdminImmune(iSurvivor, tank) && !bIsAdminImmune(iSurvivor, g_esWarpPlayer[tank].g_iTankType, g_esWarpAbility[g_esWarpPlayer[tank].g_iTankTypeRecorded].g_iImmunityFlags, g_esWarpPlayer[iSurvivor].g_iImmunityFlags))
						{
							GetClientAbsOrigin(iSurvivor, flSurvivorPos);
							if (GetVectorDistance(flTankPos, flSurvivorPos) <= flRange && bIsVisibleToPlayer(tank, iSurvivor, g_esWarpCache[tank].g_iWarpSight, .range = flRange))
							{
								vWarpHit(iSurvivor, tank, random, flChance, g_esWarpCache[tank].g_iWarpAbility, MT_MESSAGE_RANGE, MT_ATTACK_RANGE, pos);

								iSurvivorCount++;
							}
						}
					}

					if (iSurvivorCount == 0)
					{
						if (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esWarpCache[tank].g_iHumanAbility == 1)
						{
							MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpHuman7");
						}
					}
				}
				else if (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esWarpCache[tank].g_iHumanAbility == 1)
				{
					MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpAmmo");
				}
			}
		}
		case false:
		{
			if (g_esWarpPlayer[tank].g_iCooldown != -1 && g_esWarpPlayer[tank].g_iCooldown >= GetTime())
			{
				return;
			}

			if ((g_esWarpCache[tank].g_iWarpAbility == 2 || g_esWarpCache[tank].g_iWarpAbility == 3) && !g_esWarpPlayer[tank].g_bActivated)
			{
				if (!bIsInfected(tank, MT_CHECK_FAKECLIENT) || (g_esWarpPlayer[tank].g_iAmmoCount < g_esWarpCache[tank].g_iHumanAmmo && g_esWarpCache[tank].g_iHumanAmmo > 0))
				{
					g_esWarpPlayer[tank].g_bActivated = true;

					vWarp(tank, pos);

					if (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esWarpCache[tank].g_iHumanAbility == 1)
					{
						g_esWarpPlayer[tank].g_iAmmoCount++;

						MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpHuman", g_esWarpPlayer[tank].g_iAmmoCount, g_esWarpCache[tank].g_iHumanAmmo);
					}

					if (g_esWarpCache[tank].g_iWarpMessage & MT_MESSAGE_SPECIAL)
					{
						char sTankName[64];
						MT_GetTankName(tank, sTankName);
						MT_PrintToChatAll("%s %t", MT_TAG2, "Warp2", sTankName);
						MT_LogMessage(MT_LOG_ABILITY, "%s %T", MT_TAG, "Warp2", LANG_SERVER, sTankName);
					}
				}
				else if (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esWarpCache[tank].g_iHumanAbility == 1)
				{
					MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpAmmo");
				}
			}
		}
	}
}

void vWarpHit(int survivor, int tank, float random, float chance, int enabled, int messages, int flags, int pos = -1)
{
	if (bIsAreaNarrow(tank, g_esWarpCache[tank].g_flOpenAreasOnly) || bIsAreaWide(tank, g_esWarpCache[tank].g_flCloseAreasOnly) || MT_DoesTypeRequireHumans(g_esWarpPlayer[tank].g_iTankType, tank) || (g_esWarpCache[tank].g_iRequiresHumans > 0 && iGetHumanCount() < g_esWarpCache[tank].g_iRequiresHumans) || (!MT_HasAdminAccess(tank) && !bHasAdminAccess(tank, g_esWarpAbility[g_esWarpPlayer[tank].g_iTankTypeRecorded].g_iAccessFlags, g_esWarpPlayer[tank].g_iAccessFlags)) || MT_IsAdminImmune(survivor, tank) || bIsAdminImmune(survivor, g_esWarpPlayer[tank].g_iTankType, g_esWarpAbility[g_esWarpPlayer[tank].g_iTankTypeRecorded].g_iImmunityFlags, g_esWarpPlayer[survivor].g_iImmunityFlags))
	{
		return;
	}

	int iTime = GetTime();
	if (((flags & MT_ATTACK_RANGE) && g_esWarpPlayer[tank].g_iRangeCooldown != -1 && g_esWarpPlayer[tank].g_iRangeCooldown >= iTime) || (((flags & MT_ATTACK_CLAW) || (flags & MT_ATTACK_MELEE)) && g_esWarpPlayer[tank].g_iCooldown2 != -1 && g_esWarpPlayer[tank].g_iCooldown2 >= iTime))
	{
		return;
	}

	if ((enabled == 1 || enabled == 3) && bIsSurvivor(survivor) && !bIsSurvivorCaught(survivor) && !bIsSurvivorDisabled(survivor))
	{
		if (!bIsInfected(tank, MT_CHECK_FAKECLIENT) || (flags & MT_ATTACK_CLAW) || (flags & MT_ATTACK_MELEE) || (g_esWarpPlayer[tank].g_iAmmoCount2 < g_esWarpCache[tank].g_iHumanAmmo && g_esWarpCache[tank].g_iHumanAmmo > 0))
		{
			if (random <= chance)
			{
				if ((messages & MT_MESSAGE_MELEE) && !bIsVisibleToPlayer(tank, survivor, g_esWarpCache[tank].g_iWarpSight, .range = 100.0))
				{
					return;
				}

				bool bTeleport = false;
				char sTankName[64];
				float flCurrentOrigin[3], flCurrentAngles[3];
				int iCooldown = -1;
				for (int iSurvivor = 1; iSurvivor <= MaxClients; iSurvivor++)
				{
					if (bIsSurvivor(iSurvivor, MT_CHECK_INGAME|MT_CHECK_ALIVE) && !bIsSurvivorDisabled(iSurvivor) && !bIsAreaNarrow(iSurvivor, g_esWarpCache[tank].g_flOpenAreasOnly) && !bIsAreaWide(tank, g_esWarpCache[tank].g_flCloseAreasOnly) && iSurvivor != survivor)
					{
						if ((flags & MT_ATTACK_RANGE) && (g_esWarpPlayer[tank].g_iRangeCooldown == -1 || g_esWarpPlayer[tank].g_iRangeCooldown <= iTime))
						{
							if (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esWarpCache[tank].g_iHumanAbility == 1)
							{
								g_esWarpPlayer[tank].g_iAmmoCount2++;

								MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpHuman2", g_esWarpPlayer[tank].g_iAmmoCount2, g_esWarpCache[tank].g_iHumanAmmo);
							}

							iCooldown = (pos != -1) ? RoundToNearest(MT_GetCombinationSetting(tank, 11, pos)) : g_esWarpCache[tank].g_iWarpRangeCooldown;
							iCooldown = (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esWarpCache[tank].g_iHumanAbility == 1 && g_esWarpPlayer[tank].g_iAmmoCount2 < g_esWarpCache[tank].g_iHumanAmmo && g_esWarpCache[tank].g_iHumanAmmo > 0) ? g_esWarpCache[tank].g_iHumanRangeCooldown : iCooldown;
							g_esWarpPlayer[tank].g_iRangeCooldown = (iTime + iCooldown);
							if (g_esWarpPlayer[tank].g_iRangeCooldown != -1 && g_esWarpPlayer[tank].g_iRangeCooldown >= iTime)
							{
								MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpHuman9", (g_esWarpPlayer[tank].g_iRangeCooldown - iTime));
							}
						}
						else if (((flags & MT_ATTACK_CLAW) || (flags & MT_ATTACK_MELEE)) && (g_esWarpPlayer[tank].g_iCooldown2 == -1 || g_esWarpPlayer[tank].g_iCooldown2 <= iTime))
						{
							iCooldown = (pos != -1) ? RoundToNearest(MT_GetCombinationSetting(tank, 2, pos)) : g_esWarpCache[tank].g_iWarpCooldown;
							iCooldown = (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esWarpCache[tank].g_iHumanAbility == 1) ? g_esWarpCache[tank].g_iHumanCooldown : iCooldown;
							g_esWarpPlayer[tank].g_iCooldown2 = (iTime + iCooldown);
							if (g_esWarpPlayer[tank].g_iCooldown2 != -1 && g_esWarpPlayer[tank].g_iCooldown2 >= iTime)
							{
								MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpHuman9", (g_esWarpPlayer[tank].g_iCooldown2 - iTime));
							}
						}

						bTeleport = g_esWarpPlayer[iSurvivor].g_bAffected;
						g_esWarpPlayer[survivor].g_bAffected = bTeleport;
						g_esWarpPlayer[survivor].g_iOwner = bTeleport ? tank : -1;

						GetClientAbsOrigin(iSurvivor, flCurrentOrigin);
						GetClientEyeAngles(iSurvivor, flCurrentAngles);
						TeleportEntity(survivor, flCurrentOrigin, flCurrentAngles, view_as<float>({0.0, 0.0, 0.0}));
						vFixPlayerPosition(survivor);

						if (g_esWarpCache[tank].g_iWarpMessage & messages)
						{
							MT_GetTankName(tank, sTankName);
							MT_PrintToChatAll("%s %t", MT_TAG2, "Warp", sTankName, survivor, iSurvivor);
							MT_LogMessage(MT_LOG_ABILITY, "%s %T", MT_TAG, "Warp", LANG_SERVER, sTankName, survivor, iSurvivor);
						}

						break;
					}
				}

				vScreenEffect(survivor, tank, g_esWarpCache[tank].g_iWarpEffect, flags);
			}
			else if ((flags & MT_ATTACK_RANGE) && (g_esWarpPlayer[tank].g_iRangeCooldown == -1 || g_esWarpPlayer[tank].g_iRangeCooldown <= iTime))
			{
				if (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esWarpCache[tank].g_iHumanAbility == 1 && !g_esWarpPlayer[tank].g_bFailed)
				{
					g_esWarpPlayer[tank].g_bFailed = true;

					MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpHuman3");
				}
			}
		}
		else if (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esWarpCache[tank].g_iHumanAbility == 1 && !g_esWarpPlayer[tank].g_bNoAmmo)
		{
			g_esWarpPlayer[tank].g_bNoAmmo = true;

			MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpAmmo2");
		}
	}
}

void vWarpRange(int tank)
{
	if (MT_IsTankSupported(tank, MT_CHECK_INDEX|MT_CHECK_INGAME) && MT_IsCustomTankSupported(tank) && g_esWarpCache[tank].g_iWarpAbility == 1)
	{
		if (bIsAreaNarrow(tank, g_esWarpCache[tank].g_flOpenAreasOnly) || bIsAreaWide(tank, g_esWarpCache[tank].g_flCloseAreasOnly) || MT_DoesTypeRequireHumans(g_esWarpPlayer[tank].g_iTankType, tank) || (g_esWarpCache[tank].g_iRequiresHumans > 0 && iGetHumanCount() < g_esWarpCache[tank].g_iRequiresHumans) || (bIsInfected(tank, MT_CHECK_FAKECLIENT) && ((!MT_HasAdminAccess(tank) && !bHasAdminAccess(tank, g_esWarpAbility[g_esWarpPlayer[tank].g_iTankTypeRecorded].g_iAccessFlags, g_esWarpPlayer[tank].g_iAccessFlags)) || g_esWarpCache[tank].g_iHumanAbility == 0)))
		{
			return;
		}

		vAttachParticle(tank, PARTICLE_ELECTRICITY, 1.0);
		EmitSoundToAll(SOUND_ELECTRICITY, tank);
	}
}

void vWarpRockBreak2(int tank, int rock, float random, int pos = -1)
{
	int iLauncher = GetEntPropEnt(rock, Prop_Data, "m_hOwnerEntity");
	if (bIsValidEntity(iLauncher))
	{
		int iThrower = GetEntPropEnt(iLauncher, Prop_Data, "m_hOwnerEntity");
		if (bIsInfected(iThrower) && iThrower == tank)
		{
			return;
		}
	}

	float flChance = (pos != -1) ? MT_GetCombinationSetting(tank, 14, pos) : g_esWarpCache[tank].g_flWarpRockChance;
	if (random <= flChance)
	{
		int iTime = GetTime(), iCooldown = (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esWarpCache[tank].g_iHumanAbility == 1) ? g_esWarpCache[tank].g_iHumanRockCooldown : g_esWarpCache[tank].g_iWarpRockCooldown;
		iCooldown = (pos != -1) ? RoundToNearest(MT_GetCombinationSetting(tank, 15, pos)) : iCooldown;
		if (g_esWarpPlayer[tank].g_iRockCooldown == -1 || g_esWarpPlayer[tank].g_iRockCooldown <= iTime)
		{
			g_esWarpPlayer[tank].g_iRockCooldown = (iTime + iCooldown);
			if (g_esWarpPlayer[tank].g_iRockCooldown != -1 && g_esWarpPlayer[tank].g_iRockCooldown >= iTime)
			{
				MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpHuman9", (g_esWarpPlayer[tank].g_iRockCooldown - iTime));
			}
		}
		else if (g_esWarpPlayer[tank].g_iRockCooldown != -1 && g_esWarpPlayer[tank].g_iRockCooldown >= iTime)
		{
			MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpHuman6", (g_esWarpPlayer[tank].g_iRockCooldown - iTime));

			return;
		}

		float flTankPos[3], flTankAngles[3];
		GetClientAbsOrigin(tank, flTankPos);
		GetClientAbsAngles(tank, flTankAngles);

		float flRockPos[3], flRockAngles[3];
		GetEntPropVector(rock, Prop_Data, "m_vecOrigin", flRockPos);
		GetEntPropVector(rock, Prop_Data, "m_angRotation", flRockAngles);

		if (bIsAreaNarrow(.range = g_esWarpCache[tank].g_flOpenAreasOnly, .pos = flRockPos) || bIsAreaWide(tank, g_esWarpCache[tank].g_flCloseAreasOnly, .pos = flRockPos))
		{
			return;
		}

		int iVictim = iGetInfectedVictim(tank, g_esWarpPlayer[tank].g_iInfectedType);
		iVictim = (iVictim <= 0) ? tank : iVictim;
		if (bIsSurvivor(iVictim))
		{
			g_esWarpPlayer[iVictim].g_bAffected = true;
			g_esWarpPlayer[iVictim].g_iOwner = tank;

			TeleportEntity(iVictim, flRockPos, flRockAngles, view_as<float>({0.0, 0.0, 0.0}));
			vFixPlayerPosition(iVictim);
		}

		TeleportEntity(tank, flRockPos, flRockAngles, view_as<float>({0.0, 0.0, 0.0}));
		vFixPlayerPosition(tank);
		vAttachParticle(iVictim, PARTICLE_ELECTRICITY, 1.0);
		EmitSoundToAll(SOUND_ELECTRICITY, iVictim);

		if (bIsPlayerStuck(iVictim))
		{
			if (bIsSurvivor(iVictim))
			{
				g_esWarpPlayer[iVictim].g_bAffected = false;
				g_esWarpPlayer[iVictim].g_iOwner = -1;

				TeleportEntity(iVictim, flTankPos, flTankAngles, view_as<float>({0.0, 0.0, 0.0}));
			}

			TeleportEntity(tank, flTankPos, flTankAngles, view_as<float>({0.0, 0.0, 0.0}));

			return;
		}

		if (g_esWarpCache[tank].g_iWarpMessage & MT_MESSAGE_SPECIAL)
		{
			char sTankName[64];
			MT_GetTankName(tank, sTankName);
			MT_PrintToChatAll("%s %t", MT_TAG2, "Warp4", sTankName);
			MT_LogMessage(MT_LOG_ABILITY, "%s %T", MT_TAG, "Warp4", LANG_SERVER, sTankName);
		}
	}
}

void vWarpCopyStats2(int oldTank, int newTank)
{
	g_esWarpPlayer[newTank].g_iAmmoCount = g_esWarpPlayer[oldTank].g_iAmmoCount;
	g_esWarpPlayer[newTank].g_iAmmoCount2 = g_esWarpPlayer[oldTank].g_iAmmoCount2;
	g_esWarpPlayer[newTank].g_iCooldown = g_esWarpPlayer[oldTank].g_iCooldown;
	g_esWarpPlayer[newTank].g_iCooldown2 = g_esWarpPlayer[oldTank].g_iCooldown2;
	g_esWarpPlayer[newTank].g_iRangeCooldown = g_esWarpPlayer[oldTank].g_iRangeCooldown;
	g_esWarpPlayer[newTank].g_iRockCooldown = g_esWarpPlayer[oldTank].g_iRockCooldown;
}

void vRemoveWarp(int tank)
{
	for (int iSurvivor = 1; iSurvivor <= MaxClients; iSurvivor++)
	{
		if (bIsSurvivor(iSurvivor, MT_CHECK_INGAME|MT_CHECK_ALIVE) && g_esWarpPlayer[iSurvivor].g_bAffected && g_esWarpPlayer[iSurvivor].g_iOwner == tank)
		{
			g_esWarpPlayer[iSurvivor].g_bAffected = false;
			g_esWarpPlayer[iSurvivor].g_iOwner = -1;
		}
	}

	g_esWarpPlayer[tank].g_bActivated = false;
	g_esWarpPlayer[tank].g_bAffected = false;
	g_esWarpPlayer[tank].g_bFailed = false;
	g_esWarpPlayer[tank].g_bNoAmmo = false;
	g_esWarpPlayer[tank].g_iAmmoCount = 0;
	g_esWarpPlayer[tank].g_iAmmoCount2 = 0;
	g_esWarpPlayer[tank].g_iCooldown = -1;
	g_esWarpPlayer[tank].g_iCooldown2 = -1;
	g_esWarpPlayer[tank].g_iRangeCooldown = -1;
	g_esWarpPlayer[tank].g_iRockCooldown = -1;
}

void vWarpReset()
{
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsValidClient(iPlayer, MT_CHECK_INGAME))
		{
			vRemoveWarp(iPlayer);
		}
	}
}

void vWarpReset2(int tank)
{
	g_esWarpPlayer[tank].g_bActivated = false;

	int iTime = GetTime(), iPos = g_esWarpAbility[g_esWarpPlayer[tank].g_iTankTypeRecorded].g_iComboPosition, iCooldown = (iPos != -1) ? RoundToNearest(MT_GetCombinationSetting(tank, 2, iPos)) : g_esWarpCache[tank].g_iWarpCooldown;
	iCooldown = (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esWarpCache[tank].g_iHumanAbility == 1 && g_esWarpPlayer[tank].g_iAmmoCount < g_esWarpCache[tank].g_iHumanAmmo && g_esWarpCache[tank].g_iHumanAmmo > 0) ? g_esWarpCache[tank].g_iHumanCooldown : iCooldown;
	g_esWarpPlayer[tank].g_iCooldown = (iTime + iCooldown);
	if (g_esWarpPlayer[tank].g_iCooldown != -1 && g_esWarpPlayer[tank].g_iCooldown >= iTime)
	{
		MT_PrintToChat(tank, "%s %t", MT_TAG3, "WarpHuman8", (g_esWarpPlayer[tank].g_iCooldown - iTime));
	}
}

bool bIsSurvivorInsideSaferoom(int survivor)
{
	int iArea = SDKCall(g_esWarpGeneral.g_hSDKGetLastKnownArea, survivor);
	if (iArea)
	{
		int iAttributeFlags = LoadFromAddress(view_as<Address>(iArea + g_esWarpGeneral.g_iAttributeFlagsOffset), NumberType_Int32);
		if (iAttributeFlags & 2048)
		{
			return true;
		}
	}

	return false;
}

void tTimerWarpCombo(Handle timer, DataPack pack)
{
	pack.Reset();

	int iTank = GetClientOfUserId(pack.ReadCell());
	if (!MT_IsCorePluginEnabled() || !MT_IsTankSupported(iTank) || (!MT_HasAdminAccess(iTank) && !bHasAdminAccess(iTank, g_esWarpAbility[g_esWarpPlayer[iTank].g_iTankTypeRecorded].g_iAccessFlags, g_esWarpPlayer[iTank].g_iAccessFlags)) || !MT_IsTypeEnabled(g_esWarpPlayer[iTank].g_iTankType, iTank) || !MT_IsCustomTankSupported(iTank) || g_esWarpCache[iTank].g_iWarpAbility == 0 || g_esWarpCache[iTank].g_iWarpAbility == 2)
	{
		return;
	}

	float flRandom = pack.ReadFloat();
	int iPos = pack.ReadCell();
	vWarpAbility(iTank, true, flRandom, iPos);
}

void tTimerWarpCombo2(Handle timer, DataPack pack)
{
	pack.Reset();

	int iTank = GetClientOfUserId(pack.ReadCell());
	if (!MT_IsCorePluginEnabled() || !MT_IsTankSupported(iTank) || (!MT_HasAdminAccess(iTank) && !bHasAdminAccess(iTank, g_esWarpAbility[g_esWarpPlayer[iTank].g_iTankTypeRecorded].g_iAccessFlags, g_esWarpPlayer[iTank].g_iAccessFlags)) || !MT_IsTypeEnabled(g_esWarpPlayer[iTank].g_iTankType, iTank) || !MT_IsCustomTankSupported(iTank) || g_esWarpCache[iTank].g_iWarpAbility == 0 || g_esWarpCache[iTank].g_iWarpAbility == 1)
	{
		return;
	}

	int iPos = pack.ReadCell();
	vWarpAbility(iTank, false, .pos = iPos);
}

void tTimerWarpCombo3(Handle timer, DataPack pack)
{
	pack.Reset();

	int iSurvivor = GetClientOfUserId(pack.ReadCell());
	if (!bIsSurvivor(iSurvivor))
	{
		return;
	}

	int iTank = GetClientOfUserId(pack.ReadCell());
	if (!MT_IsCorePluginEnabled() || !MT_IsTankSupported(iTank) || (!MT_HasAdminAccess(iTank) && !bHasAdminAccess(iTank, g_esWarpAbility[g_esWarpPlayer[iTank].g_iTankTypeRecorded].g_iAccessFlags, g_esWarpPlayer[iTank].g_iAccessFlags)) || !MT_IsTypeEnabled(g_esWarpPlayer[iTank].g_iTankType, iTank) || !MT_IsCustomTankSupported(iTank) || g_esWarpCache[iTank].g_iWarpHit == 0)
	{
		return;
	}

	float flRandom = pack.ReadFloat(), flChance = pack.ReadFloat();
	int iPos = pack.ReadCell();
	char sClassname[32];
	pack.ReadString(sClassname, sizeof sClassname);
	if ((g_esWarpCache[iTank].g_iWarpHitMode == 0 || g_esWarpCache[iTank].g_iWarpHitMode == 1) && (bIsSpecialInfected(iTank) || StrEqual(sClassname[7], "tank_claw") || StrEqual(sClassname, "tank_rock")))
	{
		vWarpHit(iSurvivor, iTank, flRandom, flChance, g_esWarpCache[iTank].g_iWarpHit, MT_MESSAGE_MELEE, MT_ATTACK_CLAW, iPos);
	}
	else if ((g_esWarpCache[iTank].g_iWarpHitMode == 0 || g_esWarpCache[iTank].g_iWarpHitMode == 2) && StrEqual(sClassname[7], "melee"))
	{
		vWarpHit(iSurvivor, iTank, flRandom, flChance, g_esWarpCache[iTank].g_iWarpHit, MT_MESSAGE_MELEE, MT_ATTACK_MELEE, iPos);
	}
}

Action tTimerWarp(Handle timer, DataPack pack)
{
	pack.Reset();

	int iTank = GetClientOfUserId(pack.ReadCell()), iType = pack.ReadCell();
	if (!MT_IsCorePluginEnabled() || !MT_IsTankSupported(iTank) || bIsAreaNarrow(iTank, g_esWarpCache[iTank].g_flOpenAreasOnly) || bIsAreaWide(iTank, g_esWarpCache[iTank].g_flCloseAreasOnly) || MT_DoesTypeRequireHumans(g_esWarpPlayer[iTank].g_iTankType, iTank) || (g_esWarpCache[iTank].g_iRequiresHumans > 0 && iGetHumanCount() < g_esWarpCache[iTank].g_iRequiresHumans) || (!MT_HasAdminAccess(iTank) && !bHasAdminAccess(iTank, g_esWarpAbility[g_esWarpPlayer[iTank].g_iTankTypeRecorded].g_iAccessFlags, g_esWarpPlayer[iTank].g_iAccessFlags)) || !MT_IsTypeEnabled(g_esWarpPlayer[iTank].g_iTankType, iTank) || !MT_IsCustomTankSupported(iTank) || iType != g_esWarpPlayer[iTank].g_iTankType || (g_esWarpCache[iTank].g_iWarpAbility != 2 && g_esWarpCache[iTank].g_iWarpAbility != 3) || !g_esWarpPlayer[iTank].g_bActivated)
	{
		g_esWarpPlayer[iTank].g_bActivated = false;

		return Plugin_Stop;
	}

	bool bHuman = bIsInfected(iTank, MT_CHECK_FAKECLIENT);
	int iTime = pack.ReadCell(), iCurrentTime = GetTime(), iPos = pack.ReadCell(),
		iDuration = (iPos != -1) ? RoundToNearest(MT_GetCombinationSetting(iTank, 5, iPos)) : g_esWarpCache[iTank].g_iWarpDuration;
	iDuration = (bHuman && g_esWarpCache[iTank].g_iHumanAbility == 1) ? g_esWarpCache[iTank].g_iHumanDuration : iDuration;
	if (iDuration > 0 && (!bHuman || (bHuman && g_esWarpCache[iTank].g_iHumanAbility == 1 && g_esWarpCache[iTank].g_iHumanMode == 0)) && (iTime + iDuration) < iCurrentTime && (g_esWarpPlayer[iTank].g_iCooldown == -1 || g_esWarpPlayer[iTank].g_iCooldown < iCurrentTime))
	{
		vWarpReset2(iTank);

		return Plugin_Stop;
	}

	switch (g_esWarpCache[iTank].g_iWarpMode)
	{
		case 0, 1:
		{
			int iSurvivor = iGetRandomSurvivor(iTank);
			if (bIsSurvivor(iSurvivor) && !bIsSurvivorDisabled(iSurvivor) && !bIsSurvivorInsideSaferoom(iSurvivor))
			{
				vWarp2(iTank, iSurvivor);
			}
		}
		case 2, 3:
		{
			int iTank2 = iGetRandomTank(iTank);
			if (bIsInfected(iTank2))
			{
				vWarp2(iTank, iTank2);
			}
		}
	}

	return Plugin_Continue;
}