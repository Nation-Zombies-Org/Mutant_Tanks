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

#define MT_BLIND_COMPILE_METHOD 0 // 0: packaged, 1: standalone

#if !defined MT_ABILITIES_MAIN
	#if MT_BLIND_COMPILE_METHOD == 1
		#include <sourcemod>
		#include <mutant_tanks>
	#else
		#error This file must be inside "scripting/mutant_tanks/abilities" while compiling "mt_abilities.sp" to include its content.
	#endif
public Plugin myinfo =
{
	name = "[MT] Blind Ability",
	author = MT_AUTHOR,
	description = "The Mutant Tank blinds survivors.",
	version = MT_VERSION,
	url = MT_URL
};

bool g_bDedicated, g_bLateLoad, g_bSecondGame;

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	switch (GetEngineVersion())
	{
		case Engine_Left4Dead: g_bSecondGame = false;
		case Engine_Left4Dead2: g_bSecondGame = true;
		default:
		{
			strcopy(error, err_max, "\"[MT] Blind Ability\" only supports Left 4 Dead 1 & 2.");

			return APLRes_SilentFailure;
		}
	}

	g_bDedicated = IsDedicatedServer();
	g_bLateLoad = late;

	return APLRes_Success;
}

#define PARTICLE_BASHED "screen_bashed"

#define SOUND_GROAN1 "ambient/random_amb_sfx/metalscrapeverb08.wav"
#define SOUND_GROAN2 "ambient/random_amb_sounds/randbridgegroan_03.wav" // Only available in L4D2
#else
	#if MT_BLIND_COMPILE_METHOD == 1
		#error This file must be compiled as a standalone plugin.
	#endif
#endif

#define MT_BLIND_SECTION "blindability"
#define MT_BLIND_SECTION2 "blind ability"
#define MT_BLIND_SECTION3 "blind_ability"
#define MT_BLIND_SECTION4 "blind"

#define MT_MENU_BLIND "Blind Ability"

enum struct esBlindPlayer
{
	bool g_bAffected;
	bool g_bFailed;
	bool g_bNoAmmo;

	float g_flBlindChance;
	float g_flBlindDuration;
	float g_flBlindRange;
	float g_flBlindRangeChance;
	float g_flCloseAreasOnly;
	float g_flOpenAreasOnly;

	int g_iAccessFlags;
	int g_iAmmoCount;
	int g_iBlindAbility;
	int g_iBlindCooldown;
	int g_iBlindEffect;
	int g_iBlindHit;
	int g_iBlindHitMode;
	int g_iBlindIntensity;
	int g_iBlindMessage;
	int g_iBlindMode;
	int g_iBlindRangeCooldown;
	int g_iBlindSight;
	int g_iBlindStagger;
	int g_iComboAbility;
	int g_iCooldown;
	int g_iHumanAbility;
	int g_iHumanAmmo;
	int g_iHumanCooldown;
	int g_iHumanRangeCooldown;
	int g_iImmunityFlags;
	int g_iOwner;
	int g_iRangeCooldown;
	int g_iRequiresHumans;
	int g_iTankType;
	int g_iTankTypeRecorded;
}

esBlindPlayer g_esBlindPlayer[MAXPLAYERS + 1];

enum struct esBlindTeammate
{
	float g_flBlindChance;
	float g_flBlindDuration;
	float g_flBlindRange;
	float g_flBlindRangeChance;
	float g_flCloseAreasOnly;
	float g_flOpenAreasOnly;

	int g_iBlindAbility;
	int g_iBlindCooldown;
	int g_iBlindEffect;
	int g_iBlindHit;
	int g_iBlindHitMode;
	int g_iBlindIntensity;
	int g_iBlindMessage;
	int g_iBlindMode;
	int g_iBlindRangeCooldown;
	int g_iBlindSight;
	int g_iBlindStagger;
	int g_iComboAbility;
	int g_iHumanAbility;
	int g_iHumanAmmo;
	int g_iHumanCooldown;
	int g_iHumanRangeCooldown;
	int g_iRequiresHumans;
}

esBlindTeammate g_esBlindTeammate[MAXPLAYERS + 1];

enum struct esBlindAbility
{
	float g_flBlindChance;
	float g_flBlindDuration;
	float g_flBlindRange;
	float g_flBlindRangeChance;
	float g_flCloseAreasOnly;
	float g_flOpenAreasOnly;

	int g_iAccessFlags;
	int g_iBlindAbility;
	int g_iBlindCooldown;
	int g_iBlindEffect;
	int g_iBlindHit;
	int g_iBlindHitMode;
	int g_iBlindIntensity;
	int g_iBlindMessage;
	int g_iBlindMode;
	int g_iBlindRangeCooldown;
	int g_iBlindSight;
	int g_iBlindStagger;
	int g_iComboAbility;
	int g_iHumanAbility;
	int g_iHumanAmmo;
	int g_iHumanCooldown;
	int g_iHumanRangeCooldown;
	int g_iImmunityFlags;
	int g_iRequiresHumans;
}

esBlindAbility g_esBlindAbility[MT_MAXTYPES + 1];

enum struct esBlindSpecial
{
	float g_flBlindChance;
	float g_flBlindDuration;
	float g_flBlindRange;
	float g_flBlindRangeChance;
	float g_flCloseAreasOnly;
	float g_flOpenAreasOnly;

	int g_iBlindAbility;
	int g_iBlindCooldown;
	int g_iBlindEffect;
	int g_iBlindHit;
	int g_iBlindHitMode;
	int g_iBlindIntensity;
	int g_iBlindMessage;
	int g_iBlindMode;
	int g_iBlindRangeCooldown;
	int g_iBlindSight;
	int g_iBlindStagger;
	int g_iComboAbility;
	int g_iHumanAbility;
	int g_iHumanAmmo;
	int g_iHumanCooldown;
	int g_iHumanRangeCooldown;
	int g_iRequiresHumans;
}

esBlindSpecial g_esBlindSpecial[MT_MAXTYPES + 1];

enum struct esBlindCache
{
	float g_flBlindChance;
	float g_flBlindDuration;
	float g_flBlindRange;
	float g_flBlindRangeChance;
	float g_flCloseAreasOnly;
	float g_flOpenAreasOnly;

	int g_iBlindAbility;
	int g_iBlindCooldown;
	int g_iBlindEffect;
	int g_iBlindHit;
	int g_iBlindHitMode;
	int g_iBlindIntensity;
	int g_iBlindMessage;
	int g_iBlindMode;
	int g_iBlindRangeCooldown;
	int g_iBlindSight;
	int g_iBlindStagger;
	int g_iComboAbility;
	int g_iHumanAbility;
	int g_iHumanAmmo;
	int g_iHumanCooldown;
	int g_iHumanRangeCooldown;
	int g_iRequiresHumans;
}

esBlindCache g_esBlindCache[MAXPLAYERS + 1];

int g_iBashedParticle = -1;

UserMsg g_umBlindFade;

#if defined MT_ABILITIES_MAIN
void vBlindPluginStart()
#else
public void OnPluginStart()
#endif
{
	g_umBlindFade = GetUserMessageId("Fade");
#if !defined MT_ABILITIES_MAIN
	LoadTranslations("common.phrases");
	LoadTranslations("mutant_tanks.phrases");
	LoadTranslations("mutant_tanks_names.phrases");

	RegConsoleCmd("sm_mt_blind", cmdBlindInfo, "View information about the Blind ability.");

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
#endif
}

#if defined MT_ABILITIES_MAIN
void vBlindMapStart()
#else
public void OnMapStart()
#endif
{
	g_iBashedParticle = iPrecacheParticle(PARTICLE_BASHED);

	switch (g_bSecondGame)
	{
		case true: PrecacheSound(SOUND_GROAN2, true);
		case false: PrecacheSound(SOUND_GROAN1, true);
	}

	vBlindReset();
}

#if defined MT_ABILITIES_MAIN
void vBlindClientPutInServer(int client)
#else
public void OnClientPutInServer(int client)
#endif
{
	SDKHook(client, SDKHook_OnTakeDamage, OnBlindTakeDamage);
	vBlindReset2(client);
}

#if defined MT_ABILITIES_MAIN
void vBlindClientDisconnect_Post(int client)
#else
public void OnClientDisconnect_Post(int client)
#endif
{
	vBlindReset2(client);
}

#if defined MT_ABILITIES_MAIN
void vBlindMapEnd()
#else
public void OnMapEnd()
#endif
{
	vBlindReset();
}

#if !defined MT_ABILITIES_MAIN
Action cmdBlindInfo(int client, int args)
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
		case false: vBlindMenu(client, MT_BLIND_SECTION4, 0);
	}

	return Plugin_Handled;
}
#endif

void vBlindMenu(int client, const char[] name, int item)
{
	if (StrContains(MT_BLIND_SECTION4, name, false) == -1)
	{
		return;
	}

	Menu mAbilityMenu = new Menu(iBlindMenuHandler, MENU_ACTIONS_DEFAULT|MenuAction_Display|MenuAction_DisplayItem);
	mAbilityMenu.SetTitle("Blind Ability Information");
	mAbilityMenu.AddItem("Status", "Status");
	mAbilityMenu.AddItem("Ammunition", "Ammunition");
	mAbilityMenu.AddItem("Buttons", "Buttons");
	mAbilityMenu.AddItem("Cooldown", "Cooldown");
	mAbilityMenu.AddItem("Details", "Details");
	mAbilityMenu.AddItem("Duration", "Duration");
	mAbilityMenu.AddItem("Human Support", "Human Support");
	mAbilityMenu.AddItem("Range Cooldown", "Range Cooldown");
	mAbilityMenu.DisplayAt(client, item, MENU_TIME_FOREVER);
}

int iBlindMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
	switch (action)
	{
		case MenuAction_End: delete menu;
		case MenuAction_Select:
		{
			switch (param2)
			{
				case 0: MT_PrintToChat(param1, "%s %t", MT_TAG3, (g_esBlindCache[param1].g_iBlindAbility == 0) ? "AbilityStatus1" : "AbilityStatus2");
				case 1: MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityAmmo", (g_esBlindCache[param1].g_iHumanAmmo - g_esBlindPlayer[param1].g_iAmmoCount), g_esBlindCache[param1].g_iHumanAmmo);
				case 2: MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityButtons2");
				case 3: MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityCooldown", ((g_esBlindCache[param1].g_iHumanAbility == 1) ? g_esBlindCache[param1].g_iHumanCooldown : g_esBlindCache[param1].g_iBlindCooldown));
				case 4: MT_PrintToChat(param1, "%s %t", MT_TAG3, "BlindDetails");
				case 5: MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityDuration", g_esBlindCache[param1].g_flBlindDuration);
				case 6: MT_PrintToChat(param1, "%s %t", MT_TAG3, (g_esBlindCache[param1].g_iHumanAbility == 0) ? "AbilityHumanSupport1" : "AbilityHumanSupport2");
				case 7: MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityRangeCooldown", ((g_esBlindCache[param1].g_iHumanAbility == 1) ? g_esBlindCache[param1].g_iHumanRangeCooldown : g_esBlindCache[param1].g_iBlindRangeCooldown));
			}

			if (bIsValidClient(param1, MT_CHECK_INGAME))
			{
				vBlindMenu(param1, MT_BLIND_SECTION4, menu.Selection);
			}
		}
		case MenuAction_Display:
		{
			char sMenuTitle[PLATFORM_MAX_PATH];
			Panel pBlind = view_as<Panel>(param2);
			FormatEx(sMenuTitle, sizeof sMenuTitle, "%T", "BlindMenu", param1);
			pBlind.SetTitle(sMenuTitle);
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
					case 3: FormatEx(sMenuOption, sizeof sMenuOption, "%T", "Cooldown", param1);
					case 4: FormatEx(sMenuOption, sizeof sMenuOption, "%T", "Details", param1);
					case 5: FormatEx(sMenuOption, sizeof sMenuOption, "%T", "Duration", param1);
					case 6: FormatEx(sMenuOption, sizeof sMenuOption, "%T", "HumanSupport", param1);
					case 7: FormatEx(sMenuOption, sizeof sMenuOption, "%T", "RangeCooldown", param1);
				}

				return RedrawMenuItem(sMenuOption);
			}
		}
	}

	return 0;
}

#if defined MT_ABILITIES_MAIN
void vBlindDisplayMenu(Menu menu)
#else
public void MT_OnDisplayMenu(Menu menu)
#endif
{
	menu.AddItem(MT_MENU_BLIND, MT_MENU_BLIND);
}

#if defined MT_ABILITIES_MAIN
void vBlindMenuItemSelected(int client, const char[] info)
#else
public void MT_OnMenuItemSelected(int client, const char[] info)
#endif
{
	if (StrEqual(info, MT_MENU_BLIND, false))
	{
		vBlindMenu(client, MT_BLIND_SECTION4, 0);
	}
}

#if defined MT_ABILITIES_MAIN
void vBlindMenuItemDisplayed(int client, const char[] info, char[] buffer, int size)
#else
public void MT_OnMenuItemDisplayed(int client, const char[] info, char[] buffer, int size)
#endif
{
	if (StrEqual(info, MT_MENU_BLIND, false))
	{
		FormatEx(buffer, size, "%T", "BlindMenu2", client);
	}
}

Action OnBlindTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype)
{
	if (MT_IsCorePluginEnabled() && bIsValidClient(victim, MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_ALIVE) && damage > 0.0)
	{
		char sClassname[32];
		if (bIsValidEntity(inflictor))
		{
			GetEntityClassname(inflictor, sClassname, sizeof sClassname);
		}

		if (MT_IsTankSupported(attacker) && MT_IsCustomTankSupported(attacker) && (g_esBlindCache[attacker].g_iBlindHitMode == 0 || g_esBlindCache[attacker].g_iBlindHitMode == 1) && bIsSurvivor(victim) && g_esBlindCache[attacker].g_iComboAbility == 0)
		{
			if ((!MT_HasAdminAccess(attacker) && !bHasAdminAccess(attacker, g_esBlindAbility[g_esBlindPlayer[attacker].g_iTankTypeRecorded].g_iAccessFlags, g_esBlindPlayer[attacker].g_iAccessFlags)) || MT_IsAdminImmune(victim, attacker) || bIsAdminImmune(victim, g_esBlindPlayer[attacker].g_iTankType, g_esBlindAbility[g_esBlindPlayer[attacker].g_iTankTypeRecorded].g_iImmunityFlags, g_esBlindPlayer[victim].g_iImmunityFlags))
			{
				return Plugin_Continue;
			}

			bool bCaught = bIsSurvivorCaught(victim);
			if ((bIsSpecialInfected(attacker) && (bCaught || (!bCaught && (damagetype & DMG_CLUB)) || (bIsSpitter(attacker) && StrEqual(sClassname, "insect_swarm")))) || StrEqual(sClassname[7], "tank_claw") || StrEqual(sClassname, "tank_rock"))
			{
				vBlindHit(victim, attacker, GetRandomFloat(0.1, 100.0), g_esBlindCache[attacker].g_flBlindChance, g_esBlindCache[attacker].g_iBlindHit, MT_MESSAGE_MELEE, MT_ATTACK_CLAW);
			}
		}
		else if (MT_IsTankSupported(victim) && MT_IsCustomTankSupported(victim) && (g_esBlindCache[victim].g_iBlindHitMode == 0 || g_esBlindCache[victim].g_iBlindHitMode == 2) && bIsSurvivor(attacker) && g_esBlindCache[victim].g_iComboAbility == 0)
		{
			if ((!MT_HasAdminAccess(victim) && !bHasAdminAccess(victim, g_esBlindAbility[g_esBlindPlayer[victim].g_iTankTypeRecorded].g_iAccessFlags, g_esBlindPlayer[victim].g_iAccessFlags)) || MT_IsAdminImmune(attacker, victim) || bIsAdminImmune(attacker, g_esBlindPlayer[victim].g_iTankType, g_esBlindAbility[g_esBlindPlayer[victim].g_iTankTypeRecorded].g_iImmunityFlags, g_esBlindPlayer[attacker].g_iImmunityFlags))
			{
				return Plugin_Continue;
			}

			if (StrEqual(sClassname[7], "melee"))
			{
				vBlindHit(attacker, victim, GetRandomFloat(0.1, 100.0), g_esBlindCache[victim].g_flBlindChance, g_esBlindCache[victim].g_iBlindHit, MT_MESSAGE_MELEE, MT_ATTACK_MELEE);
			}
		}
	}

	return Plugin_Continue;
}

#if defined MT_ABILITIES_MAIN
void vBlindPluginCheck(ArrayList list)
#else
public void MT_OnPluginCheck(ArrayList list)
#endif
{
	list.PushString(MT_MENU_BLIND);
}

#if defined MT_ABILITIES_MAIN
void vBlindAbilityCheck(ArrayList list, ArrayList list2, ArrayList list3, ArrayList list4)
#else
public void MT_OnAbilityCheck(ArrayList list, ArrayList list2, ArrayList list3, ArrayList list4)
#endif
{
	list.PushString(MT_BLIND_SECTION);
	list2.PushString(MT_BLIND_SECTION2);
	list3.PushString(MT_BLIND_SECTION3);
	list4.PushString(MT_BLIND_SECTION4);
}

#if defined MT_ABILITIES_MAIN
void vBlindCombineAbilities(int tank, int type, const float random, const char[] combo, int survivor, const char[] classname)
#else
public void MT_OnCombineAbilities(int tank, int type, const float random, const char[] combo, int survivor, int weapon, const char[] classname)
#endif
{
	if (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esBlindCache[tank].g_iHumanAbility != 2)
	{
		return;
	}

	char sCombo[320], sSet[4][32];
	FormatEx(sCombo, sizeof sCombo, ",%s,", combo);
	FormatEx(sSet[0], sizeof sSet[], ",%s,", MT_BLIND_SECTION);
	FormatEx(sSet[1], sizeof sSet[], ",%s,", MT_BLIND_SECTION2);
	FormatEx(sSet[2], sizeof sSet[], ",%s,", MT_BLIND_SECTION3);
	FormatEx(sSet[3], sizeof sSet[], ",%s,", MT_BLIND_SECTION4);
	if (g_esBlindCache[tank].g_iComboAbility == 1 && (StrContains(sCombo, sSet[0], false) != -1 || StrContains(sCombo, sSet[1], false) != -1 || StrContains(sCombo, sSet[2], false) != -1 || StrContains(sCombo, sSet[3], false) != -1))
	{
		char sAbilities[320], sSubset[10][32];
		strcopy(sAbilities, sizeof sAbilities, combo);
		ExplodeString(sAbilities, ",", sSubset, sizeof sSubset, sizeof sSubset[]);

		float flChance = 0.0, flDelay = 0.0;
		for (int iPos = 0; iPos < (sizeof sSubset); iPos++)
		{
			if (StrEqual(sSubset[iPos], MT_BLIND_SECTION, false) || StrEqual(sSubset[iPos], MT_BLIND_SECTION2, false) || StrEqual(sSubset[iPos], MT_BLIND_SECTION3, false) || StrEqual(sSubset[iPos], MT_BLIND_SECTION4, false))
			{
				flDelay = MT_GetCombinationSetting(tank, 4, iPos);

				switch (type)
				{
					case MT_COMBO_MAINRANGE:
					{
						if (g_esBlindCache[tank].g_iBlindAbility == 1)
						{
							switch (flDelay)
							{
								case 0.0: vBlindAbility(tank, random, iPos);
								default:
								{
									DataPack dpCombo;
									CreateDataTimer(flDelay, tTimerBlindCombo, dpCombo, TIMER_FLAG_NO_MAPCHANGE);
									dpCombo.WriteCell(GetClientUserId(tank));
									dpCombo.WriteFloat(random);
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
								if ((g_esBlindCache[tank].g_iBlindHitMode == 0 || g_esBlindCache[tank].g_iBlindHitMode == 1) && (StrEqual(classname[7], "tank_claw") || StrEqual(classname, "tank_rock")))
								{
									vBlindHit(survivor, tank, random, flChance, g_esBlindCache[tank].g_iBlindHit, MT_MESSAGE_MELEE, MT_ATTACK_CLAW, iPos);
								}
								else if ((g_esBlindCache[tank].g_iBlindHitMode == 0 || g_esBlindCache[tank].g_iBlindHitMode == 2) && StrEqual(classname[7], "melee"))
								{
									vBlindHit(survivor, tank, random, flChance, g_esBlindCache[tank].g_iBlindHit, MT_MESSAGE_MELEE, MT_ATTACK_MELEE, iPos);
								}
							}
							default:
							{
								DataPack dpCombo;
								CreateDataTimer(flDelay, tTimerBlindCombo2, dpCombo, TIMER_FLAG_NO_MAPCHANGE);
								dpCombo.WriteCell(GetClientUserId(survivor));
								dpCombo.WriteCell(GetClientUserId(tank));
								dpCombo.WriteFloat(random);
								dpCombo.WriteFloat(flChance);
								dpCombo.WriteCell(iPos);
								dpCombo.WriteString(classname);
							}
						}
					}
				}

				break;
			}
		}
	}
}

#if defined MT_ABILITIES_MAIN
void vBlindConfigsLoad(int mode)
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
				g_esBlindAbility[iIndex].g_iAccessFlags = 0;
				g_esBlindAbility[iIndex].g_iImmunityFlags = 0;
				g_esBlindAbility[iIndex].g_flCloseAreasOnly = 0.0;
				g_esBlindAbility[iIndex].g_iComboAbility = 0;
				g_esBlindAbility[iIndex].g_iHumanAbility = 0;
				g_esBlindAbility[iIndex].g_iHumanAmmo = 5;
				g_esBlindAbility[iIndex].g_iHumanCooldown = 0;
				g_esBlindAbility[iIndex].g_iHumanRangeCooldown = 0;
				g_esBlindAbility[iIndex].g_flOpenAreasOnly = 0.0;
				g_esBlindAbility[iIndex].g_iRequiresHumans = 1;
				g_esBlindAbility[iIndex].g_iBlindAbility = 0;
				g_esBlindAbility[iIndex].g_iBlindEffect = 0;
				g_esBlindAbility[iIndex].g_iBlindMessage = 0;
				g_esBlindAbility[iIndex].g_flBlindChance = 33.3;
				g_esBlindAbility[iIndex].g_iBlindCooldown = 0;
				g_esBlindAbility[iIndex].g_flBlindDuration = 5.0;
				g_esBlindAbility[iIndex].g_iBlindHit = 0;
				g_esBlindAbility[iIndex].g_iBlindHitMode = 0;
				g_esBlindAbility[iIndex].g_iBlindIntensity = 255;
				g_esBlindAbility[iIndex].g_iBlindMode = 0;
				g_esBlindAbility[iIndex].g_flBlindRange = 150.0;
				g_esBlindAbility[iIndex].g_flBlindRangeChance = 15.0;
				g_esBlindAbility[iIndex].g_iBlindRangeCooldown = 0;
				g_esBlindAbility[iIndex].g_iBlindSight = 0;
				g_esBlindAbility[iIndex].g_iBlindStagger = 3;

				g_esBlindSpecial[iIndex].g_flCloseAreasOnly = -1.0;
				g_esBlindSpecial[iIndex].g_iComboAbility = -1;
				g_esBlindSpecial[iIndex].g_iHumanAbility = -1;
				g_esBlindSpecial[iIndex].g_iHumanAmmo = -1;
				g_esBlindSpecial[iIndex].g_iHumanCooldown = -1;
				g_esBlindSpecial[iIndex].g_iHumanRangeCooldown = -1;
				g_esBlindSpecial[iIndex].g_flOpenAreasOnly = -1.0;
				g_esBlindSpecial[iIndex].g_iRequiresHumans = -1;
				g_esBlindSpecial[iIndex].g_iBlindAbility = -1;
				g_esBlindSpecial[iIndex].g_iBlindEffect = -1;
				g_esBlindSpecial[iIndex].g_iBlindMessage = -1;
				g_esBlindSpecial[iIndex].g_flBlindChance = -1.0;
				g_esBlindSpecial[iIndex].g_iBlindCooldown = -1;
				g_esBlindSpecial[iIndex].g_flBlindDuration = -1.0;
				g_esBlindSpecial[iIndex].g_iBlindHit = -1;
				g_esBlindSpecial[iIndex].g_iBlindHitMode = -1;
				g_esBlindSpecial[iIndex].g_iBlindIntensity = -1;
				g_esBlindSpecial[iIndex].g_iBlindMode = -1;
				g_esBlindSpecial[iIndex].g_flBlindRange = -1.0;
				g_esBlindSpecial[iIndex].g_flBlindRangeChance = -1.0;
				g_esBlindSpecial[iIndex].g_iBlindRangeCooldown = -1;
				g_esBlindSpecial[iIndex].g_iBlindSight = -1;
				g_esBlindSpecial[iIndex].g_iBlindStagger = -1;
			}
		}
		case 3:
		{
			for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
			{
				g_esBlindPlayer[iPlayer].g_iAccessFlags = -1;
				g_esBlindPlayer[iPlayer].g_iImmunityFlags = -1;
				g_esBlindPlayer[iPlayer].g_flCloseAreasOnly = -1.0;
				g_esBlindPlayer[iPlayer].g_iComboAbility = -1;
				g_esBlindPlayer[iPlayer].g_iHumanAbility = -1;
				g_esBlindPlayer[iPlayer].g_iHumanAmmo = -1;
				g_esBlindPlayer[iPlayer].g_iHumanCooldown = -1;
				g_esBlindPlayer[iPlayer].g_iHumanRangeCooldown = -1;
				g_esBlindPlayer[iPlayer].g_flOpenAreasOnly = -1.0;
				g_esBlindPlayer[iPlayer].g_iRequiresHumans = -1;
				g_esBlindPlayer[iPlayer].g_iBlindAbility = -1;
				g_esBlindPlayer[iPlayer].g_iBlindEffect = -1;
				g_esBlindPlayer[iPlayer].g_iBlindMessage = -1;
				g_esBlindPlayer[iPlayer].g_flBlindChance = -1.0;
				g_esBlindPlayer[iPlayer].g_iBlindCooldown = -1;
				g_esBlindPlayer[iPlayer].g_flBlindDuration = -1.0;
				g_esBlindPlayer[iPlayer].g_iBlindHit = -1;
				g_esBlindPlayer[iPlayer].g_iBlindHitMode = -1;
				g_esBlindPlayer[iPlayer].g_iBlindIntensity = -1;
				g_esBlindPlayer[iPlayer].g_iBlindMode = -1;
				g_esBlindPlayer[iPlayer].g_flBlindRange = -1.0;
				g_esBlindPlayer[iPlayer].g_flBlindRangeChance = -1.0;
				g_esBlindPlayer[iPlayer].g_iBlindRangeCooldown = -1;
				g_esBlindPlayer[iPlayer].g_iBlindSight = -1;
				g_esBlindPlayer[iPlayer].g_iBlindStagger = -1;

				g_esBlindTeammate[iPlayer].g_flCloseAreasOnly = -1.0;
				g_esBlindTeammate[iPlayer].g_iComboAbility = -1;
				g_esBlindTeammate[iPlayer].g_iHumanAbility = -1;
				g_esBlindTeammate[iPlayer].g_iHumanAmmo = -1;
				g_esBlindTeammate[iPlayer].g_iHumanCooldown = -1;
				g_esBlindTeammate[iPlayer].g_iHumanRangeCooldown = -1;
				g_esBlindTeammate[iPlayer].g_flOpenAreasOnly = -1.0;
				g_esBlindTeammate[iPlayer].g_iRequiresHumans = -1;
				g_esBlindTeammate[iPlayer].g_iBlindAbility = -1;
				g_esBlindTeammate[iPlayer].g_iBlindEffect = -1;
				g_esBlindTeammate[iPlayer].g_iBlindMessage = -1;
				g_esBlindTeammate[iPlayer].g_flBlindChance = -1.0;
				g_esBlindTeammate[iPlayer].g_iBlindCooldown = -1;
				g_esBlindTeammate[iPlayer].g_flBlindDuration = -1.0;
				g_esBlindTeammate[iPlayer].g_iBlindHit = -1;
				g_esBlindTeammate[iPlayer].g_iBlindHitMode = -1;
				g_esBlindTeammate[iPlayer].g_iBlindIntensity = -1;
				g_esBlindTeammate[iPlayer].g_iBlindMode = -1;
				g_esBlindTeammate[iPlayer].g_flBlindRange = -1.0;
				g_esBlindTeammate[iPlayer].g_flBlindRangeChance = -1.0;
				g_esBlindTeammate[iPlayer].g_iBlindRangeCooldown = -1;
				g_esBlindTeammate[iPlayer].g_iBlindSight = -1;
				g_esBlindTeammate[iPlayer].g_iBlindStagger = -1;
			}
		}
	}
}

#if defined MT_ABILITIES_MAIN
void vBlindConfigsLoaded(const char[] subsection, const char[] key, const char[] value, int type, int admin, int mode, bool special, const char[] specsection)
#else
public void MT_OnConfigsLoaded(const char[] subsection, const char[] key, const char[] value, int type, int admin, int mode, bool special, const char[] specsection)
#endif
{
	if ((mode == -1 || mode == 3) && bIsValidClient(admin))
	{
		if (special && specsection[0] != '\0')
		{
			g_esBlindTeammate[admin].g_flCloseAreasOnly = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "CloseAreasOnly", "Close Areas Only", "Close_Areas_Only", "closeareas", g_esBlindTeammate[admin].g_flCloseAreasOnly, value, -1.0, 99999.0);
			g_esBlindTeammate[admin].g_iComboAbility = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "ComboAbility", "Combo Ability", "Combo_Ability", "combo", g_esBlindTeammate[admin].g_iComboAbility, value, -1, 1);
			g_esBlindTeammate[admin].g_iHumanAbility = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "HumanAbility", "Human Ability", "Human_Ability", "human", g_esBlindTeammate[admin].g_iHumanAbility, value, -1, 2);
			g_esBlindTeammate[admin].g_iHumanAmmo = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "HumanAmmo", "Human Ammo", "Human_Ammo", "hammo", g_esBlindTeammate[admin].g_iHumanAmmo, value, -1, 99999);
			g_esBlindTeammate[admin].g_iHumanCooldown = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "HumanCooldown", "Human Cooldown", "Human_Cooldown", "hcooldown", g_esBlindTeammate[admin].g_iHumanCooldown, value, -1, 99999);
			g_esBlindTeammate[admin].g_iHumanRangeCooldown = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "HumanRangeCooldown", "Human Range Cooldown", "Human_Range_Cooldown", "hrangecooldown", g_esBlindTeammate[admin].g_iHumanRangeCooldown, value, -1, 99999);
			g_esBlindTeammate[admin].g_flOpenAreasOnly = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "OpenAreasOnly", "Open Areas Only", "Open_Areas_Only", "openareas", g_esBlindTeammate[admin].g_flOpenAreasOnly, value, -1.0, 99999.0);
			g_esBlindTeammate[admin].g_iRequiresHumans = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "RequiresHumans", "Requires Humans", "Requires_Humans", "hrequire", g_esBlindTeammate[admin].g_iRequiresHumans, value, -1, 32);
			g_esBlindTeammate[admin].g_iBlindAbility = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AbilityEnabled", "Ability Enabled", "Ability_Enabled", "aenabled", g_esBlindTeammate[admin].g_iBlindAbility, value, -1, 1);
			g_esBlindTeammate[admin].g_iBlindEffect = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AbilityEffect", "Ability Effect", "Ability_Effect", "effect", g_esBlindTeammate[admin].g_iBlindEffect, value, -1, 7);
			g_esBlindTeammate[admin].g_iBlindMessage = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AbilityMessage", "Ability Message", "Ability_Message", "message", g_esBlindTeammate[admin].g_iBlindMessage, value, -1, 3);
			g_esBlindTeammate[admin].g_iBlindSight = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AbilitySight", "Ability Sight", "Ability_Sight", "sight", g_esBlindTeammate[admin].g_iBlindSight, value, -1, 5);
			g_esBlindTeammate[admin].g_flBlindChance = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindChance", "Blind Chance", "Blind_Chance", "chance", g_esBlindTeammate[admin].g_flBlindChance, value, -1.0, 100.0);
			g_esBlindTeammate[admin].g_iBlindCooldown = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindCooldown", "Blind Cooldown", "Blind_Cooldown", "cooldown", g_esBlindTeammate[admin].g_iBlindCooldown, value, -1, 99999);
			g_esBlindTeammate[admin].g_flBlindDuration = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindDuration", "Blind Duration", "Blind_Duration", "duration", g_esBlindTeammate[admin].g_flBlindDuration, value, -1.0, 99999.0);
			g_esBlindTeammate[admin].g_iBlindHit = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindHit", "Blind Hit", "Blind_Hit", "hit", g_esBlindTeammate[admin].g_iBlindHit, value, -1, 1);
			g_esBlindTeammate[admin].g_iBlindHitMode = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindHitMode", "Blind Hit Mode", "Blind_Hit_Mode", "hitmode", g_esBlindTeammate[admin].g_iBlindHitMode, value, -1, 2);
			g_esBlindTeammate[admin].g_iBlindIntensity = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindIntensity", "Blind Intensity", "Blind_Intensity", "intensity", g_esBlindTeammate[admin].g_iBlindIntensity, value, -1, 255);
			g_esBlindTeammate[admin].g_iBlindMode = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindMode", "Blind Mode", "Blind_Mode", "mode", g_esBlindTeammate[admin].g_iBlindMode, value, -1, 1);
			g_esBlindTeammate[admin].g_flBlindRange = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindRange", "Blind Range", "Blind_Range", "range", g_esBlindTeammate[admin].g_flBlindRange, value, -1.0, 99999.0);
			g_esBlindTeammate[admin].g_flBlindRangeChance = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindRangeChance", "Blind Range Chance", "Blind_Range_Chance", "rangechance", g_esBlindTeammate[admin].g_flBlindRangeChance, value, -1.0, 100.0);
			g_esBlindTeammate[admin].g_iBlindRangeCooldown = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindRangeCooldown", "Blind Range Cooldown", "Blind_Range_Cooldown", "rangecooldown", g_esBlindTeammate[admin].g_iBlindRangeCooldown, value, -1, 99999);
			g_esBlindTeammate[admin].g_iBlindStagger = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindStagger", "Blind Stagger", "Blind_Stagger", "stagger", g_esBlindTeammate[admin].g_iBlindStagger, value, -1, 3);
		}
		else
		{
			g_esBlindPlayer[admin].g_flCloseAreasOnly = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "CloseAreasOnly", "Close Areas Only", "Close_Areas_Only", "closeareas", g_esBlindPlayer[admin].g_flCloseAreasOnly, value, -1.0, 99999.0);
			g_esBlindPlayer[admin].g_iComboAbility = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "ComboAbility", "Combo Ability", "Combo_Ability", "combo", g_esBlindPlayer[admin].g_iComboAbility, value, -1, 1);
			g_esBlindPlayer[admin].g_iHumanAbility = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "HumanAbility", "Human Ability", "Human_Ability", "human", g_esBlindPlayer[admin].g_iHumanAbility, value, -1, 2);
			g_esBlindPlayer[admin].g_iHumanAmmo = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "HumanAmmo", "Human Ammo", "Human_Ammo", "hammo", g_esBlindPlayer[admin].g_iHumanAmmo, value, -1, 99999);
			g_esBlindPlayer[admin].g_iHumanCooldown = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "HumanCooldown", "Human Cooldown", "Human_Cooldown", "hcooldown", g_esBlindPlayer[admin].g_iHumanCooldown, value, -1, 99999);
			g_esBlindPlayer[admin].g_iHumanRangeCooldown = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "HumanRangeCooldown", "Human Range Cooldown", "Human_Range_Cooldown", "hrangecooldown", g_esBlindPlayer[admin].g_iHumanRangeCooldown, value, -1, 99999);
			g_esBlindPlayer[admin].g_flOpenAreasOnly = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "OpenAreasOnly", "Open Areas Only", "Open_Areas_Only", "openareas", g_esBlindPlayer[admin].g_flOpenAreasOnly, value, -1.0, 99999.0);
			g_esBlindPlayer[admin].g_iRequiresHumans = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "RequiresHumans", "Requires Humans", "Requires_Humans", "hrequire", g_esBlindPlayer[admin].g_iRequiresHumans, value, -1, 32);
			g_esBlindPlayer[admin].g_iBlindAbility = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AbilityEnabled", "Ability Enabled", "Ability_Enabled", "aenabled", g_esBlindPlayer[admin].g_iBlindAbility, value, -1, 1);
			g_esBlindPlayer[admin].g_iBlindEffect = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AbilityEffect", "Ability Effect", "Ability_Effect", "effect", g_esBlindPlayer[admin].g_iBlindEffect, value, -1, 7);
			g_esBlindPlayer[admin].g_iBlindMessage = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AbilityMessage", "Ability Message", "Ability_Message", "message", g_esBlindPlayer[admin].g_iBlindMessage, value, -1, 3);
			g_esBlindPlayer[admin].g_iBlindSight = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AbilitySight", "Ability Sight", "Ability_Sight", "sight", g_esBlindPlayer[admin].g_iBlindSight, value, -1, 5);
			g_esBlindPlayer[admin].g_flBlindChance = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindChance", "Blind Chance", "Blind_Chance", "chance", g_esBlindPlayer[admin].g_flBlindChance, value, -1.0, 100.0);
			g_esBlindPlayer[admin].g_iBlindCooldown = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindCooldown", "Blind Cooldown", "Blind_Cooldown", "cooldown", g_esBlindPlayer[admin].g_iBlindCooldown, value, -1, 99999);
			g_esBlindPlayer[admin].g_flBlindDuration = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindDuration", "Blind Duration", "Blind_Duration", "duration", g_esBlindPlayer[admin].g_flBlindDuration, value, -1.0, 99999.0);
			g_esBlindPlayer[admin].g_iBlindHit = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindHit", "Blind Hit", "Blind_Hit", "hit", g_esBlindPlayer[admin].g_iBlindHit, value, -1, 1);
			g_esBlindPlayer[admin].g_iBlindHitMode = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindHitMode", "Blind Hit Mode", "Blind_Hit_Mode", "hitmode", g_esBlindPlayer[admin].g_iBlindHitMode, value, -1, 2);
			g_esBlindPlayer[admin].g_iBlindIntensity = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindIntensity", "Blind Intensity", "Blind_Intensity", "intensity", g_esBlindPlayer[admin].g_iBlindIntensity, value, -1, 255);
			g_esBlindPlayer[admin].g_iBlindMode = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindMode", "Blind Mode", "Blind_Mode", "mode", g_esBlindPlayer[admin].g_iBlindMode, value, -1, 1);
			g_esBlindPlayer[admin].g_flBlindRange = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindRange", "Blind Range", "Blind_Range", "range", g_esBlindPlayer[admin].g_flBlindRange, value, -1.0, 99999.0);
			g_esBlindPlayer[admin].g_flBlindRangeChance = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindRangeChance", "Blind Range Chance", "Blind_Range_Chance", "rangechance", g_esBlindPlayer[admin].g_flBlindRangeChance, value, -1.0, 100.0);
			g_esBlindPlayer[admin].g_iBlindRangeCooldown = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindRangeCooldown", "Blind Range Cooldown", "Blind_Range_Cooldown", "rangecooldown", g_esBlindPlayer[admin].g_iBlindRangeCooldown, value, -1, 99999);
			g_esBlindPlayer[admin].g_iBlindStagger = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindStagger", "Blind Stagger", "Blind_Stagger", "stagger", g_esBlindPlayer[admin].g_iBlindStagger, value, -1, 3);
			g_esBlindPlayer[admin].g_iAccessFlags = iGetAdminFlagsValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AccessFlags", "Access Flags", "Access_Flags", "access", value);
			g_esBlindPlayer[admin].g_iImmunityFlags = iGetAdminFlagsValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "ImmunityFlags", "Immunity Flags", "Immunity_Flags", "immunity", value);
		}
	}

	if (mode < 3 && type > 0)
	{
		if (special && specsection[0] != '\0')
		{
			g_esBlindSpecial[type].g_flCloseAreasOnly = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "CloseAreasOnly", "Close Areas Only", "Close_Areas_Only", "openareas", g_esBlindSpecial[type].g_flCloseAreasOnly, value, -1.0, 99999.0);
			g_esBlindSpecial[type].g_iComboAbility = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "ComboAbility", "Combo Ability", "Combo_Ability", "combo", g_esBlindSpecial[type].g_iComboAbility, value, -1, 1);
			g_esBlindSpecial[type].g_iHumanAbility = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "HumanAbility", "Human Ability", "Human_Ability", "human", g_esBlindSpecial[type].g_iHumanAbility, value, -1, 2);
			g_esBlindSpecial[type].g_iHumanAmmo = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "HumanAmmo", "Human Ammo", "Human_Ammo", "hammo", g_esBlindSpecial[type].g_iHumanAmmo, value, -1, 99999);
			g_esBlindSpecial[type].g_iHumanCooldown = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "HumanCooldown", "Human Cooldown", "Human_Cooldown", "hcooldown", g_esBlindSpecial[type].g_iHumanCooldown, value, -1, 99999);
			g_esBlindSpecial[type].g_iHumanRangeCooldown = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "HumanRangeCooldown", "Human Range Cooldown", "Human_Range_Cooldown", "hrangecooldown", g_esBlindSpecial[type].g_iHumanRangeCooldown, value, -1, 99999);
			g_esBlindSpecial[type].g_flOpenAreasOnly = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "OpenAreasOnly", "Open Areas Only", "Open_Areas_Only", "openareas", g_esBlindSpecial[type].g_flOpenAreasOnly, value, -1.0, 99999.0);
			g_esBlindSpecial[type].g_iRequiresHumans = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "RequiresHumans", "Requires Humans", "Requires_Humans", "hrequire", g_esBlindSpecial[type].g_iRequiresHumans, value, -1, 32);
			g_esBlindSpecial[type].g_iBlindAbility = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AbilityEnabled", "Ability Enabled", "Ability_Enabled", "aenabled", g_esBlindSpecial[type].g_iBlindAbility, value, -1, 1);
			g_esBlindSpecial[type].g_iBlindEffect = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AbilityEffect", "Ability Effect", "Ability_Effect", "effect", g_esBlindSpecial[type].g_iBlindEffect, value, -1, 7);
			g_esBlindSpecial[type].g_iBlindMessage = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AbilityMessage", "Ability Message", "Ability_Message", "message", g_esBlindSpecial[type].g_iBlindMessage, value, -1, 3);
			g_esBlindSpecial[type].g_iBlindSight = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AbilitySight", "Ability Sight", "Ability_Sight", "sight", g_esBlindSpecial[type].g_iBlindSight, value, -1, 5);
			g_esBlindSpecial[type].g_flBlindChance = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindChance", "Blind Chance", "Blind_Chance", "chance", g_esBlindSpecial[type].g_flBlindChance, value, -1.0, 100.0);
			g_esBlindSpecial[type].g_iBlindCooldown = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindCooldown", "Blind Cooldown", "Blind_Cooldown", "cooldown", g_esBlindSpecial[type].g_iBlindCooldown, value, -1, 99999);
			g_esBlindSpecial[type].g_flBlindDuration = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindDuration", "Blind Duration", "Blind_Duration", "duration", g_esBlindSpecial[type].g_flBlindDuration, value, -1.0, 99999.0);
			g_esBlindSpecial[type].g_iBlindHit = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindHit", "Blind Hit", "Blind_Hit", "hit", g_esBlindSpecial[type].g_iBlindHit, value, -1, 1);
			g_esBlindSpecial[type].g_iBlindHitMode = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindHitMode", "Blind Hit Mode", "Blind_Hit_Mode", "hitmode", g_esBlindSpecial[type].g_iBlindHitMode, value, -1, 2);
			g_esBlindSpecial[type].g_iBlindIntensity = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindIntensity", "Blind Intensity", "Blind_Intensity", "intensity", g_esBlindSpecial[type].g_iBlindIntensity, value, -1, 255);
			g_esBlindSpecial[type].g_iBlindMode = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindMode", "Blind Mode", "Blind_Mode", "mode", g_esBlindSpecial[type].g_iBlindMode, value, -1, 1);
			g_esBlindSpecial[type].g_flBlindRange = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindRange", "Blind Range", "Blind_Range", "range", g_esBlindSpecial[type].g_flBlindRange, value, -1.0, 99999.0);
			g_esBlindSpecial[type].g_flBlindRangeChance = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindRangeChance", "Blind Range Chance", "Blind_Range_Chance", "rangechance", g_esBlindSpecial[type].g_flBlindRangeChance, value, -1.0, 100.0);
			g_esBlindSpecial[type].g_iBlindRangeCooldown = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindRangeCooldown", "Blind Range Cooldown", "Blind_Range_Cooldown", "rangecooldown", g_esBlindSpecial[type].g_iBlindRangeCooldown, value, -1, 99999);
			g_esBlindSpecial[type].g_iBlindStagger = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindStagger", "Blind Stagger", "Blind_Stagger", "stagger", g_esBlindSpecial[type].g_iBlindStagger, value, -1, 3);
		}
		else
		{
			g_esBlindAbility[type].g_flCloseAreasOnly = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "CloseAreasOnly", "Close Areas Only", "Close_Areas_Only", "openareas", g_esBlindAbility[type].g_flCloseAreasOnly, value, -1.0, 99999.0);
			g_esBlindAbility[type].g_iComboAbility = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "ComboAbility", "Combo Ability", "Combo_Ability", "combo", g_esBlindAbility[type].g_iComboAbility, value, -1, 1);
			g_esBlindAbility[type].g_iHumanAbility = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "HumanAbility", "Human Ability", "Human_Ability", "human", g_esBlindAbility[type].g_iHumanAbility, value, -1, 2);
			g_esBlindAbility[type].g_iHumanAmmo = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "HumanAmmo", "Human Ammo", "Human_Ammo", "hammo", g_esBlindAbility[type].g_iHumanAmmo, value, -1, 99999);
			g_esBlindAbility[type].g_iHumanCooldown = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "HumanCooldown", "Human Cooldown", "Human_Cooldown", "hcooldown", g_esBlindAbility[type].g_iHumanCooldown, value, -1, 99999);
			g_esBlindAbility[type].g_iHumanRangeCooldown = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "HumanRangeCooldown", "Human Range Cooldown", "Human_Range_Cooldown", "hrangecooldown", g_esBlindAbility[type].g_iHumanRangeCooldown, value, -1, 99999);
			g_esBlindAbility[type].g_flOpenAreasOnly = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "OpenAreasOnly", "Open Areas Only", "Open_Areas_Only", "openareas", g_esBlindAbility[type].g_flOpenAreasOnly, value, -1.0, 99999.0);
			g_esBlindAbility[type].g_iRequiresHumans = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "RequiresHumans", "Requires Humans", "Requires_Humans", "hrequire", g_esBlindAbility[type].g_iRequiresHumans, value, -1, 32);
			g_esBlindAbility[type].g_iBlindAbility = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AbilityEnabled", "Ability Enabled", "Ability_Enabled", "aenabled", g_esBlindAbility[type].g_iBlindAbility, value, -1, 1);
			g_esBlindAbility[type].g_iBlindEffect = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AbilityEffect", "Ability Effect", "Ability_Effect", "effect", g_esBlindAbility[type].g_iBlindEffect, value, -1, 7);
			g_esBlindAbility[type].g_iBlindMessage = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AbilityMessage", "Ability Message", "Ability_Message", "message", g_esBlindAbility[type].g_iBlindMessage, value, -1, 3);
			g_esBlindAbility[type].g_iBlindSight = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AbilitySight", "Ability Sight", "Ability_Sight", "sight", g_esBlindAbility[type].g_iBlindSight, value, -1, 5);
			g_esBlindAbility[type].g_flBlindChance = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindChance", "Blind Chance", "Blind_Chance", "chance", g_esBlindAbility[type].g_flBlindChance, value, -1.0, 100.0);
			g_esBlindAbility[type].g_iBlindCooldown = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindCooldown", "Blind Cooldown", "Blind_Cooldown", "cooldown", g_esBlindAbility[type].g_iBlindCooldown, value, -1, 99999);
			g_esBlindAbility[type].g_flBlindDuration = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindDuration", "Blind Duration", "Blind_Duration", "duration", g_esBlindAbility[type].g_flBlindDuration, value, -1.0, 99999.0);
			g_esBlindAbility[type].g_iBlindHit = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindHit", "Blind Hit", "Blind_Hit", "hit", g_esBlindAbility[type].g_iBlindHit, value, -1, 1);
			g_esBlindAbility[type].g_iBlindHitMode = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindHitMode", "Blind Hit Mode", "Blind_Hit_Mode", "hitmode", g_esBlindAbility[type].g_iBlindHitMode, value, -1, 2);
			g_esBlindAbility[type].g_iBlindIntensity = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindIntensity", "Blind Intensity", "Blind_Intensity", "intensity", g_esBlindAbility[type].g_iBlindIntensity, value, -1, 255);
			g_esBlindAbility[type].g_iBlindMode = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindMode", "Blind Mode", "Blind_Mode", "mode", g_esBlindAbility[type].g_iBlindMode, value, -1, 1);
			g_esBlindAbility[type].g_flBlindRange = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindRange", "Blind Range", "Blind_Range", "range", g_esBlindAbility[type].g_flBlindRange, value, -1.0, 99999.0);
			g_esBlindAbility[type].g_flBlindRangeChance = flGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindRangeChance", "Blind Range Chance", "Blind_Range_Chance", "rangechance", g_esBlindAbility[type].g_flBlindRangeChance, value, -1.0, 100.0);
			g_esBlindAbility[type].g_iBlindRangeCooldown = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindRangeCooldown", "Blind Range Cooldown", "Blind_Range_Cooldown", "rangecooldown", g_esBlindAbility[type].g_iBlindRangeCooldown, value, -1, 99999);
			g_esBlindAbility[type].g_iBlindStagger = iGetKeyValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "BlindStagger", "Blind Stagger", "Blind_Stagger", "stagger", g_esBlindAbility[type].g_iBlindStagger, value, -1, 3);
			g_esBlindAbility[type].g_iAccessFlags = iGetAdminFlagsValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "AccessFlags", "Access Flags", "Access_Flags", "access", value);
			g_esBlindAbility[type].g_iImmunityFlags = iGetAdminFlagsValue(subsection, MT_BLIND_SECTION, MT_BLIND_SECTION2, MT_BLIND_SECTION3, MT_BLIND_SECTION4, key, "ImmunityFlags", "Immunity Flags", "Immunity_Flags", "immunity", value);
		}
	}
}

#if defined MT_ABILITIES_MAIN
void vBlindSettingsCached(int tank, bool apply, int type)
#else
public void MT_OnSettingsCached(int tank, bool apply, int type)
#endif
{
	bool bHuman = bIsValidClient(tank, MT_CHECK_FAKECLIENT);
	g_esBlindPlayer[tank].g_iTankTypeRecorded = apply ? MT_GetRecordedTankType(tank, type) : 0;
	g_esBlindPlayer[tank].g_iTankType = apply ? type : 0;
	int iType = g_esBlindPlayer[tank].g_iTankTypeRecorded;

	if (bIsSpecialInfected(tank, MT_CHECK_INDEX|MT_CHECK_INGAME))
	{
		g_esBlindCache[tank].g_flBlindChance = flGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_flBlindChance, g_esBlindPlayer[tank].g_flBlindChance, g_esBlindSpecial[iType].g_flBlindChance, g_esBlindAbility[iType].g_flBlindChance, 1);
		g_esBlindCache[tank].g_flBlindDuration = flGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_flBlindDuration, g_esBlindPlayer[tank].g_flBlindDuration, g_esBlindSpecial[iType].g_flBlindDuration, g_esBlindAbility[iType].g_flBlindDuration, 1);
		g_esBlindCache[tank].g_flBlindRange = flGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_flBlindRange, g_esBlindPlayer[tank].g_flBlindRange, g_esBlindSpecial[iType].g_flBlindRange, g_esBlindAbility[iType].g_flBlindRange, 1);
		g_esBlindCache[tank].g_flBlindRangeChance = flGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_flBlindRangeChance, g_esBlindPlayer[tank].g_flBlindRangeChance, g_esBlindSpecial[iType].g_flBlindRangeChance, g_esBlindAbility[iType].g_flBlindRangeChance, 1);
		g_esBlindCache[tank].g_iBlindAbility = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iBlindAbility, g_esBlindPlayer[tank].g_iBlindAbility, g_esBlindSpecial[iType].g_iBlindAbility, g_esBlindAbility[iType].g_iBlindAbility, 1);
		g_esBlindCache[tank].g_iBlindCooldown = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iBlindCooldown, g_esBlindPlayer[tank].g_iBlindCooldown, g_esBlindSpecial[iType].g_iBlindCooldown, g_esBlindAbility[iType].g_iBlindCooldown, 1);
		g_esBlindCache[tank].g_iBlindEffect = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iBlindEffect, g_esBlindPlayer[tank].g_iBlindEffect, g_esBlindSpecial[iType].g_iBlindEffect, g_esBlindAbility[iType].g_iBlindEffect, 1);
		g_esBlindCache[tank].g_iBlindHit = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iBlindHit, g_esBlindPlayer[tank].g_iBlindHit, g_esBlindSpecial[iType].g_iBlindHit, g_esBlindAbility[iType].g_iBlindHit, 1);
		g_esBlindCache[tank].g_iBlindHitMode = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iBlindHitMode, g_esBlindPlayer[tank].g_iBlindHitMode, g_esBlindSpecial[iType].g_iBlindHitMode, g_esBlindAbility[iType].g_iBlindHitMode, 1);
		g_esBlindCache[tank].g_iBlindIntensity = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iBlindIntensity, g_esBlindPlayer[tank].g_iBlindIntensity, g_esBlindSpecial[iType].g_iBlindIntensity, g_esBlindAbility[iType].g_iBlindIntensity, 1);
		g_esBlindCache[tank].g_iBlindMessage = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iBlindMessage, g_esBlindPlayer[tank].g_iBlindMessage, g_esBlindSpecial[iType].g_iBlindMessage, g_esBlindAbility[iType].g_iBlindMessage, 1);
		g_esBlindCache[tank].g_iBlindMode = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iBlindMode, g_esBlindPlayer[tank].g_iBlindMode, g_esBlindSpecial[iType].g_iBlindMode, g_esBlindAbility[iType].g_iBlindMode, 1);
		g_esBlindCache[tank].g_iBlindRangeCooldown = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iBlindRangeCooldown, g_esBlindPlayer[tank].g_iBlindRangeCooldown, g_esBlindSpecial[iType].g_iBlindRangeCooldown, g_esBlindAbility[iType].g_iBlindRangeCooldown, 1);
		g_esBlindCache[tank].g_iBlindSight = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iBlindSight, g_esBlindPlayer[tank].g_iBlindSight, g_esBlindSpecial[iType].g_iBlindSight, g_esBlindAbility[iType].g_iBlindSight, 1);
		g_esBlindCache[tank].g_iBlindStagger = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iBlindStagger, g_esBlindPlayer[tank].g_iBlindStagger, g_esBlindSpecial[iType].g_iBlindStagger, g_esBlindAbility[iType].g_iBlindStagger, 1);
		g_esBlindCache[tank].g_flCloseAreasOnly = flGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_flCloseAreasOnly, g_esBlindPlayer[tank].g_flCloseAreasOnly, g_esBlindSpecial[iType].g_flCloseAreasOnly, g_esBlindAbility[iType].g_flCloseAreasOnly, 1);
		g_esBlindCache[tank].g_iComboAbility = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iComboAbility, g_esBlindPlayer[tank].g_iComboAbility, g_esBlindSpecial[iType].g_iComboAbility, g_esBlindAbility[iType].g_iComboAbility, 1);
		g_esBlindCache[tank].g_iHumanAbility = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iHumanAbility, g_esBlindPlayer[tank].g_iHumanAbility, g_esBlindSpecial[iType].g_iHumanAbility, g_esBlindAbility[iType].g_iHumanAbility, 1);
		g_esBlindCache[tank].g_iHumanAmmo = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iHumanAmmo, g_esBlindPlayer[tank].g_iHumanAmmo, g_esBlindSpecial[iType].g_iHumanAmmo, g_esBlindAbility[iType].g_iHumanAmmo, 1);
		g_esBlindCache[tank].g_iHumanCooldown = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iHumanCooldown, g_esBlindPlayer[tank].g_iHumanCooldown, g_esBlindSpecial[iType].g_iHumanCooldown, g_esBlindAbility[iType].g_iHumanCooldown, 1);
		g_esBlindCache[tank].g_iHumanRangeCooldown = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iHumanRangeCooldown, g_esBlindPlayer[tank].g_iHumanRangeCooldown, g_esBlindSpecial[iType].g_iHumanRangeCooldown, g_esBlindAbility[iType].g_iHumanRangeCooldown, 1);
		g_esBlindCache[tank].g_flOpenAreasOnly = flGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_flOpenAreasOnly, g_esBlindPlayer[tank].g_flOpenAreasOnly, g_esBlindSpecial[iType].g_flOpenAreasOnly, g_esBlindAbility[iType].g_flOpenAreasOnly, 1);
		g_esBlindCache[tank].g_iRequiresHumans = iGetSubSettingValue(apply, bHuman, g_esBlindTeammate[tank].g_iRequiresHumans, g_esBlindPlayer[tank].g_iRequiresHumans, g_esBlindSpecial[iType].g_iRequiresHumans, g_esBlindAbility[iType].g_iRequiresHumans, 1);
	}
	else
	{
		g_esBlindCache[tank].g_flBlindChance = flGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_flBlindChance, g_esBlindAbility[iType].g_flBlindChance, 1);
		g_esBlindCache[tank].g_flBlindDuration = flGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_flBlindDuration, g_esBlindAbility[iType].g_flBlindDuration, 1);
		g_esBlindCache[tank].g_flBlindRange = flGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_flBlindRange, g_esBlindAbility[iType].g_flBlindRange, 1);
		g_esBlindCache[tank].g_flBlindRangeChance = flGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_flBlindRangeChance, g_esBlindAbility[iType].g_flBlindRangeChance, 1);
		g_esBlindCache[tank].g_iBlindAbility = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iBlindAbility, g_esBlindAbility[iType].g_iBlindAbility, 1);
		g_esBlindCache[tank].g_iBlindCooldown = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iBlindCooldown, g_esBlindAbility[iType].g_iBlindCooldown, 1);
		g_esBlindCache[tank].g_iBlindEffect = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iBlindEffect, g_esBlindAbility[iType].g_iBlindEffect, 1);
		g_esBlindCache[tank].g_iBlindHit = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iBlindHit, g_esBlindAbility[iType].g_iBlindHit, 1);
		g_esBlindCache[tank].g_iBlindHitMode = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iBlindHitMode, g_esBlindAbility[iType].g_iBlindHitMode, 1);
		g_esBlindCache[tank].g_iBlindIntensity = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iBlindIntensity, g_esBlindAbility[iType].g_iBlindIntensity, 1);
		g_esBlindCache[tank].g_iBlindMessage = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iBlindMessage, g_esBlindAbility[iType].g_iBlindMessage, 1);
		g_esBlindCache[tank].g_iBlindMode = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iBlindMode, g_esBlindAbility[iType].g_iBlindMode, 1);
		g_esBlindCache[tank].g_iBlindRangeCooldown = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iBlindRangeCooldown, g_esBlindAbility[iType].g_iBlindRangeCooldown, 1);
		g_esBlindCache[tank].g_iBlindSight = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iBlindSight, g_esBlindAbility[iType].g_iBlindSight, 1);
		g_esBlindCache[tank].g_iBlindStagger = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iBlindStagger, g_esBlindAbility[iType].g_iBlindStagger, 1);
		g_esBlindCache[tank].g_flCloseAreasOnly = flGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_flCloseAreasOnly, g_esBlindAbility[iType].g_flCloseAreasOnly, 1);
		g_esBlindCache[tank].g_iComboAbility = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iComboAbility, g_esBlindAbility[iType].g_iComboAbility, 1);
		g_esBlindCache[tank].g_iHumanAbility = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iHumanAbility, g_esBlindAbility[iType].g_iHumanAbility, 1);
		g_esBlindCache[tank].g_iHumanAmmo = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iHumanAmmo, g_esBlindAbility[iType].g_iHumanAmmo, 1);
		g_esBlindCache[tank].g_iHumanCooldown = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iHumanCooldown, g_esBlindAbility[iType].g_iHumanCooldown, 1);
		g_esBlindCache[tank].g_iHumanRangeCooldown = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iHumanRangeCooldown, g_esBlindAbility[iType].g_iHumanRangeCooldown, 1);
		g_esBlindCache[tank].g_flOpenAreasOnly = flGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_flOpenAreasOnly, g_esBlindAbility[iType].g_flOpenAreasOnly, 1);
		g_esBlindCache[tank].g_iRequiresHumans = iGetSettingValue(apply, bHuman, g_esBlindPlayer[tank].g_iRequiresHumans, g_esBlindAbility[iType].g_iRequiresHumans, 1);
	}
}

#if defined MT_ABILITIES_MAIN
void vBlindCopyStats(int oldTank, int newTank)
#else
public void MT_OnCopyStats(int oldTank, int newTank)
#endif
{
	vBlindCopyStats2(oldTank, newTank);

	if (oldTank != newTank)
	{
		vRemoveBlind(oldTank);
	}
}

#if !defined MT_ABILITIES_MAIN
public void MT_OnPluginUpdate()
{
	MT_ReloadPlugin(null);
}
#endif

#if defined MT_ABILITIES_MAIN
void vBlindPluginEnd()
#else
public void MT_OnPluginEnd()
#endif
{
	for (int iTank = 1; iTank <= MaxClients; iTank++)
	{
		if (bIsInfected(iTank, MT_CHECK_INGAME|MT_CHECK_ALIVE))
		{
			vRemoveBlind(iTank);
		}
	}
}

#if defined MT_ABILITIES_MAIN
void vBlindEventFired(Event event, const char[] name)
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
			vBlindCopyStats2(iBot, iTank);
			vRemoveBlind(iBot);
		}
	}
	else if (StrEqual(name, "mission_lost") || StrEqual(name, "round_start") || StrEqual(name, "round_end"))
	{
		vBlindReset();
	}
	else if (StrEqual(name, "player_bot_replace"))
	{
		int iTankId = event.GetInt("player"), iTank = GetClientOfUserId(iTankId),
			iBotId = event.GetInt("bot"), iBot = GetClientOfUserId(iBotId);
		if (bIsValidClient(iTank) && bIsInfected(iBot))
		{
			vBlindCopyStats2(iTank, iBot);
			vRemoveBlind(iTank);
		}
	}
	else if (StrEqual(name, "player_death") || StrEqual(name, "player_spawn"))
	{
		int iPlayerId = event.GetInt("userid"), iPlayer = GetClientOfUserId(iPlayerId);
		if (MT_IsTankSupported(iPlayer, MT_CHECK_INDEX|MT_CHECK_INGAME))
		{
			vRemoveBlind(iPlayer);
		}
		else if (bIsHumanSurvivor(iPlayer, MT_CHECK_INDEX|MT_CHECK_INGAME))
		{
			vBlind(iPlayer, 0);
		}
	}
	else if (StrEqual(name, "player_now_it"))
	{
		bool bExploded = event.GetBool("exploded");
		int iSurvivorId = event.GetInt("userid"), iSurvivor = GetClientOfUserId(iSurvivorId),
			iBoomerId = event.GetInt("attacker"), iBoomer = GetClientOfUserId(iBoomerId);
		if (bIsBoomer(iBoomer) && bIsSurvivor(iSurvivor) && !bExploded)
		{
			vBlindHit(iSurvivor, iBoomer, GetRandomFloat(0.1, 100.0), g_esBlindCache[iBoomer].g_flBlindChance, g_esBlindCache[iBoomer].g_iBlindHit, MT_MESSAGE_RANGE, MT_ATTACK_RANGE);
		}
	}
}

#if defined MT_ABILITIES_MAIN
void vBlindAbilityActivated(int tank)
#else
public void MT_OnAbilityActivated(int tank)
#endif
{
	if (MT_IsTankSupported(tank, MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_FAKECLIENT) && ((!MT_HasAdminAccess(tank) && !bHasAdminAccess(tank, g_esBlindAbility[g_esBlindPlayer[tank].g_iTankTypeRecorded].g_iAccessFlags, g_esBlindPlayer[tank].g_iAccessFlags)) || g_esBlindCache[tank].g_iHumanAbility == 0))
	{
		return;
	}

	if (MT_IsTankSupported(tank) && (!bIsInfected(tank, MT_CHECK_FAKECLIENT) || g_esBlindCache[tank].g_iHumanAbility != 1) && MT_IsCustomTankSupported(tank) && g_esBlindCache[tank].g_iBlindAbility == 1 && g_esBlindCache[tank].g_iComboAbility == 0)
	{
		vBlindAbility(tank, GetRandomFloat(0.1, 100.0));
	}
}

#if defined MT_ABILITIES_MAIN
void vBlindButtonPressed(int tank, int button)
#else
public void MT_OnButtonPressed(int tank, int button)
#endif
{
	if (MT_IsTankSupported(tank, MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_ALIVE|MT_CHECK_FAKECLIENT) && MT_IsCustomTankSupported(tank))
	{
		if (bIsAreaNarrow(tank, g_esBlindCache[tank].g_flOpenAreasOnly) || bIsAreaWide(tank, g_esBlindCache[tank].g_flCloseAreasOnly) || MT_DoesTypeRequireHumans(g_esBlindPlayer[tank].g_iTankType, tank) || (g_esBlindCache[tank].g_iRequiresHumans > 0 && iGetHumanCount() < g_esBlindCache[tank].g_iRequiresHumans) || (!MT_HasAdminAccess(tank) && !bHasAdminAccess(tank, g_esBlindAbility[g_esBlindPlayer[tank].g_iTankTypeRecorded].g_iAccessFlags, g_esBlindPlayer[tank].g_iAccessFlags)))
		{
			return;
		}

		if ((button & MT_SUB_KEY) && g_esBlindCache[tank].g_iBlindAbility == 1 && g_esBlindCache[tank].g_iHumanAbility == 1)
		{
			int iTime = GetTime();

			switch (g_esBlindPlayer[tank].g_iRangeCooldown == -1 || g_esBlindPlayer[tank].g_iRangeCooldown <= iTime)
			{
				case true: vBlindAbility(tank, GetRandomFloat(0.1, 100.0));
				case false: MT_PrintToChat(tank, "%s %t", MT_TAG3, "BlindHuman3", (g_esBlindPlayer[tank].g_iRangeCooldown - iTime));
			}
		}
	}
}

#if defined MT_ABILITIES_MAIN
void vBlindChangeType(int tank, int oldType)
#else
public void MT_OnChangeType(int tank, int oldType, int newType, bool revert)
#endif
{
	if (oldType <= 0)
	{
		return;
	}

	vRemoveBlind(tank);
}

void vBlind(int survivor, int intensity)
{
	int iTargets[1], iFlags = (intensity == 0) ? (MT_FADE_IN|MT_FADE_PURGE) : (MT_FADE_OUT|MT_FADE_STAYOUT), iColor[4] = {0, 0, 0, 0};
	iTargets[0] = survivor;
	iColor[3] = intensity;

	Handle hMessage = StartMessageEx(g_umBlindFade, iTargets, 1);
	if (hMessage != null)
	{
		BfWrite bfWrite = UserMessageToBfWrite(hMessage);
		bfWrite.WriteShort(1536);
		bfWrite.WriteShort(1536);
		bfWrite.WriteShort(iFlags);

		for (int iPos = 0; iPos < (sizeof iColor); iPos++)
		{
			bfWrite.WriteByte(iColor[iPos]);
		}

		EndMessage();
	}
}

void vBlind2(int survivor, int red = 255, int green = 255, int blue = 255, int alpha = 255)
{
	int iTargets[2];
	iTargets[0] = survivor;

	Handle hMessage = StartMessageEx(g_umBlindFade, iTargets, 1);
	if (hMessage != null)
	{
		BfWrite bfWrite = UserMessageToBfWrite(hMessage);
		bfWrite.WriteShort(3000);
		bfWrite.WriteShort(100);
		bfWrite.WriteShort(MT_FADE_IN);
		bfWrite.WriteByte(red);
		bfWrite.WriteByte(green);
		bfWrite.WriteByte(blue);
		bfWrite.WriteByte(alpha);

		EndMessage();
	}

	MT_TE_CreateParticle(.particle = g_iBashedParticle, .all = false);
	TE_SendToClient(survivor);
}

void vBlindAbility(int tank, float random, int pos = -1)
{
	if (bIsAreaNarrow(tank, g_esBlindCache[tank].g_flOpenAreasOnly) || bIsAreaWide(tank, g_esBlindCache[tank].g_flCloseAreasOnly) || MT_DoesTypeRequireHumans(g_esBlindPlayer[tank].g_iTankType, tank) || (g_esBlindCache[tank].g_iRequiresHumans > 0 && iGetHumanCount() < g_esBlindCache[tank].g_iRequiresHumans) || (!MT_HasAdminAccess(tank) && !bHasAdminAccess(tank, g_esBlindAbility[g_esBlindPlayer[tank].g_iTankTypeRecorded].g_iAccessFlags, g_esBlindPlayer[tank].g_iAccessFlags)))
	{
		return;
	}

	if (!bIsInfected(tank, MT_CHECK_FAKECLIENT) || (g_esBlindPlayer[tank].g_iAmmoCount < g_esBlindCache[tank].g_iHumanAmmo && g_esBlindCache[tank].g_iHumanAmmo > 0))
	{
		g_esBlindPlayer[tank].g_bFailed = false;
		g_esBlindPlayer[tank].g_bNoAmmo = false;

		float flTankPos[3], flSurvivorPos[3];
		GetClientAbsOrigin(tank, flTankPos);
		float flRange = (pos != -1) ? MT_GetCombinationSetting(tank, 9, pos) : g_esBlindCache[tank].g_flBlindRange,
			flChance = (pos != -1) ? MT_GetCombinationSetting(tank, 10, pos) : g_esBlindCache[tank].g_flBlindRangeChance;
		int iSurvivorCount = 0;
		for (int iSurvivor = 1; iSurvivor <= MaxClients; iSurvivor++)
		{
			if (bIsSurvivor(iSurvivor, MT_CHECK_INGAME|MT_CHECK_ALIVE) && !MT_IsAdminImmune(iSurvivor, tank) && !bIsAdminImmune(iSurvivor, g_esBlindPlayer[tank].g_iTankType, g_esBlindAbility[g_esBlindPlayer[tank].g_iTankTypeRecorded].g_iImmunityFlags, g_esBlindPlayer[iSurvivor].g_iImmunityFlags))
			{
				GetClientAbsOrigin(iSurvivor, flSurvivorPos);
				if (GetVectorDistance(flTankPos, flSurvivorPos) <= flRange && bIsVisibleToPlayer(tank, iSurvivor, g_esBlindCache[tank].g_iBlindSight, .range = flRange))
				{
					vBlindHit(iSurvivor, tank, random, flChance, g_esBlindCache[tank].g_iBlindAbility, MT_MESSAGE_RANGE, MT_ATTACK_RANGE, pos);

					iSurvivorCount++;
				}
			}
		}

		if (iSurvivorCount == 0)
		{
			if (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esBlindCache[tank].g_iHumanAbility == 1)
			{
				MT_PrintToChat(tank, "%s %t", MT_TAG3, "BlindHuman4");
			}
		}
	}
	else if (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esBlindCache[tank].g_iHumanAbility == 1)
	{
		MT_PrintToChat(tank, "%s %t", MT_TAG3, "BlindAmmo");
	}
}

void vBlindHit(int survivor, int tank, float random, float chance, int enabled, int messages, int flags, int pos = -1)
{
	if (bIsAreaNarrow(tank, g_esBlindCache[tank].g_flOpenAreasOnly) || bIsAreaWide(tank, g_esBlindCache[tank].g_flCloseAreasOnly) || MT_DoesTypeRequireHumans(g_esBlindPlayer[tank].g_iTankType, tank) || (g_esBlindCache[tank].g_iRequiresHumans > 0 && iGetHumanCount() < g_esBlindCache[tank].g_iRequiresHumans) || (!MT_HasAdminAccess(tank) && !bHasAdminAccess(tank, g_esBlindAbility[g_esBlindPlayer[tank].g_iTankTypeRecorded].g_iAccessFlags, g_esBlindPlayer[tank].g_iAccessFlags)) || MT_IsAdminImmune(survivor, tank) || bIsAdminImmune(survivor, g_esBlindPlayer[tank].g_iTankType, g_esBlindAbility[g_esBlindPlayer[tank].g_iTankTypeRecorded].g_iImmunityFlags, g_esBlindPlayer[survivor].g_iImmunityFlags))
	{
		return;
	}

	int iTime = GetTime();
	if (((flags & MT_ATTACK_RANGE) && g_esBlindPlayer[tank].g_iRangeCooldown != -1 && g_esBlindPlayer[tank].g_iRangeCooldown >= iTime) || (((flags & MT_ATTACK_CLAW) || (flags & MT_ATTACK_MELEE)) && g_esBlindPlayer[tank].g_iCooldown != -1 && g_esBlindPlayer[tank].g_iCooldown >= iTime))
	{
		return;
	}

	if (enabled == 1 && bIsSurvivor(survivor))
	{
		if (!bIsInfected(tank, MT_CHECK_FAKECLIENT) || (flags & MT_ATTACK_CLAW) || (flags & MT_ATTACK_MELEE) || (g_esBlindPlayer[tank].g_iAmmoCount < g_esBlindCache[tank].g_iHumanAmmo && g_esBlindCache[tank].g_iHumanAmmo > 0))
		{
			if (random <= chance && !g_esBlindPlayer[survivor].g_bAffected)
			{
				if ((messages & MT_MESSAGE_MELEE) && !bIsVisibleToPlayer(tank, survivor, g_esBlindCache[tank].g_iBlindSight, .range = 100.0))
				{
					return;
				}

				g_esBlindPlayer[survivor].g_bAffected = true;
				g_esBlindPlayer[survivor].g_iOwner = tank;

				int iCooldown = -1;
				if ((flags & MT_ATTACK_RANGE) && (g_esBlindPlayer[tank].g_iRangeCooldown == -1 || g_esBlindPlayer[tank].g_iRangeCooldown <= iTime))
				{
					if (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esBlindCache[tank].g_iHumanAbility == 1)
					{
						g_esBlindPlayer[tank].g_iAmmoCount++;

						MT_PrintToChat(tank, "%s %t", MT_TAG3, "BlindHuman", g_esBlindPlayer[tank].g_iAmmoCount, g_esBlindCache[tank].g_iHumanAmmo);
					}

					iCooldown = (pos != -1) ? RoundToNearest(MT_GetCombinationSetting(tank, 11, pos)) : g_esBlindCache[tank].g_iBlindRangeCooldown;
					iCooldown = (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esBlindCache[tank].g_iHumanAbility == 1 && g_esBlindPlayer[tank].g_iAmmoCount < g_esBlindCache[tank].g_iHumanAmmo && g_esBlindCache[tank].g_iHumanAmmo > 0) ? g_esBlindCache[tank].g_iHumanRangeCooldown : iCooldown;
					g_esBlindPlayer[tank].g_iRangeCooldown = (iTime + iCooldown);
					if (g_esBlindPlayer[tank].g_iRangeCooldown != -1 && g_esBlindPlayer[tank].g_iRangeCooldown >= iTime)
					{
						MT_PrintToChat(tank, "%s %t", MT_TAG3, "BlindHuman5", (g_esBlindPlayer[tank].g_iRangeCooldown - iTime));
					}
				}
				else if (((flags & MT_ATTACK_CLAW) || (flags & MT_ATTACK_MELEE)) && (g_esBlindPlayer[tank].g_iCooldown == -1 || g_esBlindPlayer[tank].g_iCooldown <= iTime))
				{
					iCooldown = (pos != -1) ? RoundToNearest(MT_GetCombinationSetting(tank, 2, pos)) : g_esBlindCache[tank].g_iBlindCooldown;
					iCooldown = (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esBlindCache[tank].g_iHumanAbility == 1) ? g_esBlindCache[tank].g_iHumanCooldown : iCooldown;
					g_esBlindPlayer[tank].g_iCooldown = (iTime + iCooldown);
					if (g_esBlindPlayer[tank].g_iCooldown != -1 && g_esBlindPlayer[tank].g_iCooldown >= iTime)
					{
						MT_PrintToChat(tank, "%s %t", MT_TAG3, "BlindHuman5", (g_esBlindPlayer[tank].g_iCooldown - iTime));
					}
				}

				if (g_esBlindCache[tank].g_iBlindMode == 1)
				{
					g_esBlindPlayer[survivor].g_bAffected = false;
					g_esBlindPlayer[survivor].g_iOwner = -1;

					vBlind2(survivor, .alpha = 240);
					vShakePlayerScreen(survivor);
					MT_DeafenPlayer(survivor);

					int iStagger = g_esBlindCache[tank].g_iBlindStagger;
					if (iStagger > 0)
					{
						float flTankOrigin[3];
						GetClientAbsOrigin(tank, flTankOrigin);
						if (iStagger == 1 || iStagger == 3)
						{
							MT_StaggerPlayer(survivor, tank, flTankOrigin);
						}

						if (iStagger == 2 || iStagger == 3)
						{
							float flSurvivorOrigin[3], flDirection[3];
							GetClientAbsOrigin(survivor, flSurvivorOrigin);
							MakeVectorFromPoints(flSurvivorOrigin, flTankOrigin, flDirection);
							NormalizeVector(flDirection, flDirection);
							MT_ShoveBySurvivor(tank, survivor, flDirection);
							SetEntPropFloat(tank, Prop_Send, "m_flVelocityModifier", 0.4);
						}
					}
				}
				else if (g_esBlindCache[tank].g_iBlindMode == 0 && bIsValidClient(survivor, MT_CHECK_FAKECLIENT))
				{
					int iSurvivorId = GetClientUserId(survivor), iTankId = GetClientUserId(tank);
					DataPack dpBlind;
					CreateDataTimer(1.0, tTimerBlind, dpBlind, TIMER_FLAG_NO_MAPCHANGE);
					dpBlind.WriteCell(iSurvivorId);
					dpBlind.WriteCell(iTankId);
					dpBlind.WriteCell(g_esBlindPlayer[tank].g_iTankType);
					dpBlind.WriteCell(enabled);

					float flDuration = (pos != -1) ? MT_GetCombinationSetting(tank, 5, pos) : g_esBlindCache[tank].g_flBlindDuration;
					if (flDuration > 0.0)
					{
						DataPack dpStopBlind;
						CreateDataTimer(0.1, tTimerStopBlind, dpStopBlind, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
						dpStopBlind.WriteCell(iSurvivorId);
						dpStopBlind.WriteCell(iTankId);
						dpStopBlind.WriteFloat(GetGameTime());
						dpStopBlind.WriteFloat(flDuration + 1.0);
						dpStopBlind.WriteCell(messages);
					}

					vScreenEffect(survivor, tank, g_esBlindCache[tank].g_iBlindEffect, flags);

					switch (g_bSecondGame)
					{
						case true: EmitSoundToAll(SOUND_GROAN2, survivor);
						case false: EmitSoundToAll(SOUND_GROAN1, survivor);
					}
				}

				if (g_esBlindCache[tank].g_iBlindMessage & messages)
				{
					char sTankName[64];
					MT_GetTankName(tank, sTankName);
					MT_PrintToChatAll("%s %t", MT_TAG2, "Blind", sTankName, survivor);
					MT_LogMessage(MT_LOG_ABILITY, "%s %T", MT_TAG, "Blind", LANG_SERVER, sTankName, survivor);
				}
			}
			else if ((flags & MT_ATTACK_RANGE) && (g_esBlindPlayer[tank].g_iRangeCooldown == -1 || g_esBlindPlayer[tank].g_iRangeCooldown <= iTime))
			{
				if (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esBlindCache[tank].g_iHumanAbility == 1 && !g_esBlindPlayer[tank].g_bFailed)
				{
					g_esBlindPlayer[tank].g_bFailed = true;

					MT_PrintToChat(tank, "%s %t", MT_TAG3, "BlindHuman2");
				}
			}
		}
		else if (bIsInfected(tank, MT_CHECK_FAKECLIENT) && g_esBlindCache[tank].g_iHumanAbility == 1 && !g_esBlindPlayer[tank].g_bNoAmmo)
		{
			g_esBlindPlayer[tank].g_bNoAmmo = true;

			MT_PrintToChat(tank, "%s %t", MT_TAG3, "BlindAmmo");
		}
	}
}

void vBlindCopyStats2(int oldTank, int newTank)
{
	g_esBlindPlayer[newTank].g_iAmmoCount = g_esBlindPlayer[oldTank].g_iAmmoCount;
	g_esBlindPlayer[newTank].g_iCooldown = g_esBlindPlayer[oldTank].g_iCooldown;
	g_esBlindPlayer[newTank].g_iRangeCooldown = g_esBlindPlayer[oldTank].g_iRangeCooldown;
}

void vRemoveBlind(int tank)
{
	for (int iSurvivor = 1; iSurvivor <= MaxClients; iSurvivor++)
	{
		if (bIsSurvivor(iSurvivor, MT_CHECK_INGAME|MT_CHECK_ALIVE) && g_esBlindPlayer[iSurvivor].g_bAffected && g_esBlindPlayer[iSurvivor].g_iOwner == tank)
		{
			vBlind(iSurvivor, 0);

			g_esBlindPlayer[iSurvivor].g_bAffected = false;
			g_esBlindPlayer[iSurvivor].g_iOwner = -1;
		}
	}

	vBlindReset2(tank);
}

void vBlindReset()
{
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsValidClient(iPlayer, MT_CHECK_INGAME))
		{
			vBlindReset2(iPlayer);

			g_esBlindPlayer[iPlayer].g_iOwner = -1;
		}
	}
}

void vBlindReset2(int tank)
{
	g_esBlindPlayer[tank].g_bAffected = false;
	g_esBlindPlayer[tank].g_bFailed = false;
	g_esBlindPlayer[tank].g_bNoAmmo = false;
	g_esBlindPlayer[tank].g_iAmmoCount = 0;
	g_esBlindPlayer[tank].g_iCooldown = -1;
	g_esBlindPlayer[tank].g_iRangeCooldown = -1;
}

void tTimerBlind(Handle timer, DataPack pack)
{
	pack.Reset();

	int iSurvivor = GetClientOfUserId(pack.ReadCell());
	if (!MT_IsCorePluginEnabled() || !bIsHumanSurvivor(iSurvivor) || !g_esBlindPlayer[iSurvivor].g_bAffected)
	{
		g_esBlindPlayer[iSurvivor].g_bAffected = false;
		g_esBlindPlayer[iSurvivor].g_iOwner = -1;

		return;
	}

	int iTank = GetClientOfUserId(pack.ReadCell()),
		iType = pack.ReadCell(),
		iBlindEnabled = pack.ReadCell();
	if (!MT_IsTankSupported(iTank) || bIsAreaNarrow(iTank, g_esBlindCache[iTank].g_flOpenAreasOnly) || bIsAreaWide(iTank, g_esBlindCache[iTank].g_flCloseAreasOnly) || MT_DoesTypeRequireHumans(g_esBlindPlayer[iTank].g_iTankType, iTank) || (g_esBlindCache[iTank].g_iRequiresHumans > 0 && iGetHumanCount() < g_esBlindCache[iTank].g_iRequiresHumans) || !MT_HasAdminAccess(iTank) || !bHasAdminAccess(iTank, g_esBlindAbility[g_esBlindPlayer[iTank].g_iTankTypeRecorded].g_iAccessFlags, g_esBlindPlayer[iTank].g_iAccessFlags) || !MT_IsTypeEnabled(g_esBlindPlayer[iTank].g_iTankType, iTank) || !MT_IsCustomTankSupported(iTank) || iType != g_esBlindPlayer[iTank].g_iTankType || MT_IsAdminImmune(iSurvivor, iTank) || bIsAdminImmune(iSurvivor, g_esBlindPlayer[iTank].g_iTankType, g_esBlindAbility[g_esBlindPlayer[iTank].g_iTankTypeRecorded].g_iImmunityFlags, g_esBlindPlayer[iSurvivor].g_iImmunityFlags) || iBlindEnabled == 0)
	{
		g_esBlindPlayer[iSurvivor].g_bAffected = false;
		g_esBlindPlayer[iSurvivor].g_iOwner = -1;

		vBlind(iSurvivor, 0);

		return;
	}

	vBlind(iSurvivor, g_esBlindCache[iTank].g_iBlindIntensity);
}

void tTimerBlindCombo(Handle timer, DataPack pack)
{
	pack.Reset();

	int iTank = GetClientOfUserId(pack.ReadCell());
	if (!MT_IsCorePluginEnabled() || !MT_IsTankSupported(iTank) || (!MT_HasAdminAccess(iTank) && !bHasAdminAccess(iTank, g_esBlindAbility[g_esBlindPlayer[iTank].g_iTankTypeRecorded].g_iAccessFlags, g_esBlindPlayer[iTank].g_iAccessFlags)) || !MT_IsTypeEnabled(g_esBlindPlayer[iTank].g_iTankType, iTank) || !MT_IsCustomTankSupported(iTank) || g_esBlindCache[iTank].g_iBlindAbility == 0)
	{
		return;
	}

	float flRandom = pack.ReadFloat();
	int iPos = pack.ReadCell();
	vBlindAbility(iTank, flRandom, iPos);
}

void tTimerBlindCombo2(Handle timer, DataPack pack)
{
	pack.Reset();

	int iSurvivor = GetClientOfUserId(pack.ReadCell());
	if (!bIsHumanSurvivor(iSurvivor) || g_esBlindPlayer[iSurvivor].g_bAffected)
	{
		return;
	}

	int iTank = GetClientOfUserId(pack.ReadCell());
	if (!MT_IsCorePluginEnabled() || !MT_IsTankSupported(iTank) || (!MT_HasAdminAccess(iTank) && !bHasAdminAccess(iTank, g_esBlindAbility[g_esBlindPlayer[iTank].g_iTankTypeRecorded].g_iAccessFlags, g_esBlindPlayer[iTank].g_iAccessFlags)) || !MT_IsTypeEnabled(g_esBlindPlayer[iTank].g_iTankType, iTank) || !MT_IsCustomTankSupported(iTank) || g_esBlindCache[iTank].g_iBlindHit == 0)
	{
		return;
	}

	float flRandom = pack.ReadFloat(), flChance = pack.ReadFloat();
	int iPos = pack.ReadCell();
	char sClassname[32];
	pack.ReadString(sClassname, sizeof sClassname);
	if ((g_esBlindCache[iTank].g_iBlindHitMode == 0 || g_esBlindCache[iTank].g_iBlindHitMode == 1) && (bIsSpecialInfected(iTank) || StrEqual(sClassname[7], "tank_claw") || StrEqual(sClassname, "tank_rock")))
	{
		vBlindHit(iSurvivor, iTank, flRandom, flChance, g_esBlindCache[iTank].g_iBlindHit, MT_MESSAGE_MELEE, MT_ATTACK_CLAW, iPos);
	}
	else if ((g_esBlindCache[iTank].g_iBlindHitMode == 0 || g_esBlindCache[iTank].g_iBlindHitMode == 2) && StrEqual(sClassname[7], "melee"))
	{
		vBlindHit(iSurvivor, iTank, flRandom, flChance, g_esBlindCache[iTank].g_iBlindHit, MT_MESSAGE_MELEE, MT_ATTACK_MELEE, iPos);
	}
}

Action tTimerStopBlind(Handle timer, DataPack pack)
{
	pack.Reset();

	int iSurvivor = GetClientOfUserId(pack.ReadCell());
	if (!bIsHumanSurvivor(iSurvivor))
	{
		g_esBlindPlayer[iSurvivor].g_bAffected = false;
		g_esBlindPlayer[iSurvivor].g_iOwner = -1;

		return Plugin_Stop;
	}

	int iTank = GetClientOfUserId(pack.ReadCell());
	if (!MT_IsTankSupported(iTank) || !MT_IsCustomTankSupported(iTank) || !g_esBlindPlayer[iSurvivor].g_bAffected)
	{
		g_esBlindPlayer[iSurvivor].g_bAffected = false;
		g_esBlindPlayer[iSurvivor].g_iOwner = -1;

		vBlind(iSurvivor, 0);

		return Plugin_Stop;
	}

	float flCurrentTime = pack.ReadFloat(), flDuration = pack.ReadFloat();
	int iMessage = pack.ReadCell();
	if ((flCurrentTime + flDuration) < GetGameTime())
	{
		g_esBlindPlayer[iSurvivor].g_bAffected = false;
		g_esBlindPlayer[iSurvivor].g_iOwner = -1;

		vBlind(iSurvivor, 0);

		if (g_esBlindCache[iTank].g_iBlindMessage & iMessage)
		{
			MT_PrintToChatAll("%s %t", MT_TAG2, "Blind2", iSurvivor);
			MT_LogMessage(MT_LOG_ABILITY, "%s %T", MT_TAG, "Blind2", LANG_SERVER, iSurvivor);
		}

		return Plugin_Stop;
	}

	switch (bIsVisibleToPlayer(iTank, iSurvivor, g_esBlindCache[iTank].g_iBlindSight))
	{
		case true: vBlind(iSurvivor, g_esBlindCache[iTank].g_iBlindIntensity);
		case false: vBlind(iSurvivor, 0);
	}

	return Plugin_Continue;
}