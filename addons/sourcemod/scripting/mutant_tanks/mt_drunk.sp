/**
 * Mutant Tanks: a L4D/L4D2 SourceMod Plugin
 * Copyright (C) 2020  Alfred "Crasher_3637/Psyk0tik" Llagas
 *
 * This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
 **/

#include <sourcemod>
#include <sdkhooks>

#undef REQUIRE_PLUGIN
#include <mt_clone>
#define REQUIRE_PLUGIN

#include <mutant_tanks>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo =
{
	name = "[MT] Drunk Ability",
	author = MT_AUTHOR,
	description = "The Mutant Tank makes survivors drunk.",
	version = MT_VERSION,
	url = MT_URL
};

bool g_bLateLoad;

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	if (!bIsValidGame(false) && !bIsValidGame())
	{
		strcopy(error, err_max, "\"[MT] Drunk Ability\" only supports Left 4 Dead 1 & 2.");

		return APLRes_SilentFailure;
	}

	g_bLateLoad = late;

	return APLRes_Success;
}

#define MT_MENU_DRUNK "Drunk Ability"

bool g_bCloneInstalled;

enum struct esPlayerSettings
{
	bool g_bDrunk;
	bool g_bDrunk2;
	bool g_bDrunk3;
	bool g_bDrunk4;
	bool g_bDrunk5;

	float g_flOriginalSpeed;

	int g_iAccessFlags2;
	int g_iDrunkCount;
	int g_iDrunkOwner;
	int g_iImmunityFlags2;
}

esPlayerSettings g_esPlayer[MAXPLAYERS + 1];

enum struct esAbilitySettings
{
	float g_flDrunkChance;
	float g_flDrunkDuration;
	float g_flDrunkRange;
	float g_flDrunkRangeChance;
	float g_flDrunkSpeedInterval;
	float g_flDrunkTurnInterval;
	float g_flHumanCooldown;

	int g_iAccessFlags;
	int g_iDrunkAbility;
	int g_iDrunkEffect;
	int g_iDrunkHit;
	int g_iDrunkHitMode;
	int g_iDrunkMessage;
	int g_iHumanAbility;
	int g_iHumanAmmo;
	int g_iImmunityFlags;
}

esAbilitySettings g_esAbility[MT_MAXTYPES + 1];

public void OnAllPluginsLoaded()
{
	g_bCloneInstalled = LibraryExists("mt_clone");
}

public void OnLibraryAdded(const char[] name)
{
	if (StrEqual(name, "mt_clone", false))
	{
		g_bCloneInstalled = true;
	}
}

public void OnLibraryRemoved(const char[] name)
{
	if (StrEqual(name, "mt_clone", false))
	{
		g_bCloneInstalled = false;
	}
}

public void OnPluginStart()
{
	LoadTranslations("common.phrases");
	LoadTranslations("mutant_tanks.phrases");

	RegConsoleCmd("sm_mt_drunk", cmdDrunkInfo, "View information about the Drunk ability.");

	if (g_bLateLoad)
	{
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			if (bIsValidClient(iPlayer, MT_CHECK_INGAME|MT_CHECK_INKICKQUEUE))
			{
				OnClientPutInServer(iPlayer);
			}
		}

		g_bLateLoad = false;
	}
}

public void OnMapStart()
{
	vReset();
}

public void OnClientPutInServer(int client)
{
	SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);

	vReset3(client);
}

public void OnMapEnd()
{
	vReset();
}

public Action cmdDrunkInfo(int client, int args)
{
	if (!MT_IsCorePluginEnabled())
	{
		ReplyToCommand(client, "%s Mutant Tanks\x01 is disabled.", MT_TAG4);

		return Plugin_Handled;
	}

	if (!bIsValidClient(client, MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_INKICKQUEUE|MT_CHECK_FAKECLIENT))
	{
		ReplyToCommand(client, "%s This command is to be used only in-game.", MT_TAG);

		return Plugin_Handled;
	}

	switch (IsVoteInProgress())
	{
		case true: ReplyToCommand(client, "%s %t", MT_TAG2, "Vote in Progress");
		case false: vDrunkMenu(client, 0);
	}

	return Plugin_Handled;
}

static void vDrunkMenu(int client, int item)
{
	Menu mAbilityMenu = new Menu(iDrunkMenuHandler, MENU_ACTIONS_DEFAULT|MenuAction_Display|MenuAction_DisplayItem);
	mAbilityMenu.SetTitle("Drunk Ability Information");
	mAbilityMenu.AddItem("Status", "Status");
	mAbilityMenu.AddItem("Ammunition", "Ammunition");
	mAbilityMenu.AddItem("Buttons", "Buttons");
	mAbilityMenu.AddItem("Cooldown", "Cooldown");
	mAbilityMenu.AddItem("Details", "Details");
	mAbilityMenu.AddItem("Duration", "Duration");
	mAbilityMenu.AddItem("Human Support", "Human Support");
	mAbilityMenu.DisplayAt(client, item, MENU_TIME_FOREVER);
}

public int iDrunkMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
	switch (action)
	{
		case MenuAction_End: delete menu;
		case MenuAction_Select:
		{
			switch (param2)
			{
				case 0: MT_PrintToChat(param1, "%s %t", MT_TAG3, g_esAbility[MT_GetTankType(param1)].g_iDrunkAbility == 0 ? "AbilityStatus1" : "AbilityStatus2");
				case 1: MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityAmmo", g_esAbility[MT_GetTankType(param1)].g_iHumanAmmo - g_esPlayer[param1].g_iDrunkCount, g_esAbility[MT_GetTankType(param1)].g_iHumanAmmo);
				case 2: MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityButtons2");
				case 3: MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityCooldown", g_esAbility[MT_GetTankType(param1)].g_flHumanCooldown);
				case 4: MT_PrintToChat(param1, "%s %t", MT_TAG3, "DrunkDetails");
				case 5: MT_PrintToChat(param1, "%s %t", MT_TAG3, "AbilityDuration", g_esAbility[MT_GetTankType(param1)].g_flDrunkDuration);
				case 6: MT_PrintToChat(param1, "%s %t", MT_TAG3, g_esAbility[MT_GetTankType(param1)].g_iHumanAbility == 0 ? "AbilityHumanSupport1" : "AbilityHumanSupport2");
			}

			if (bIsValidClient(param1, MT_CHECK_INGAME|MT_CHECK_INKICKQUEUE))
			{
				vDrunkMenu(param1, menu.Selection);
			}
		}
		case MenuAction_Display:
		{
			char sMenuTitle[255];
			Panel panel = view_as<Panel>(param2);
			Format(sMenuTitle, sizeof(sMenuTitle), "%T", "DrunkMenu", param1);
			panel.SetTitle(sMenuTitle);
		}
		case MenuAction_DisplayItem:
		{
			char sMenuOption[255];
			switch (param2)
			{
				case 0:
				{
					Format(sMenuOption, sizeof(sMenuOption), "%T", "Status", param1);
					return RedrawMenuItem(sMenuOption);
				}
				case 1:
				{
					Format(sMenuOption, sizeof(sMenuOption), "%T", "Ammunition", param1);
					return RedrawMenuItem(sMenuOption);
				}
				case 2:
				{
					Format(sMenuOption, sizeof(sMenuOption), "%T", "Buttons", param1);
					return RedrawMenuItem(sMenuOption);
				}
				case 3:
				{
					Format(sMenuOption, sizeof(sMenuOption), "%T", "Cooldown", param1);
					return RedrawMenuItem(sMenuOption);
				}
				case 4:
				{
					Format(sMenuOption, sizeof(sMenuOption), "%T", "Details", param1);
					return RedrawMenuItem(sMenuOption);
				}
				case 5:
				{
					Format(sMenuOption, sizeof(sMenuOption), "%T", "Duration", param1);
					return RedrawMenuItem(sMenuOption);
				}
				case 6:
				{
					Format(sMenuOption, sizeof(sMenuOption), "%T", "HumanSupport", param1);
					return RedrawMenuItem(sMenuOption);
				}
			}
		}
	}

	return 0;
}

public void MT_OnDisplayMenu(Menu menu)
{
	menu.AddItem(MT_MENU_DRUNK, MT_MENU_DRUNK);
}

public void MT_OnMenuItemSelected(int client, const char[] info)
{
	if (StrEqual(info, MT_MENU_DRUNK, false))
	{
		vDrunkMenu(client, 0);
	}
}

public Action OnTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype)
{
	if (MT_IsCorePluginEnabled() && bIsValidClient(victim, MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_ALIVE|MT_CHECK_INKICKQUEUE) && damage >= 0.5)
	{
		char sClassname[32];
		GetEntityClassname(inflictor, sClassname, sizeof(sClassname));
		if (MT_IsTankSupported(attacker) && bIsCloneAllowed(attacker, g_bCloneInstalled) && (g_esAbility[MT_GetTankType(attacker)].g_iDrunkHitMode == 0 || g_esAbility[MT_GetTankType(attacker)].g_iDrunkHitMode == 1) && bIsSurvivor(victim))
		{
			if ((!MT_HasAdminAccess(attacker) && !bHasAdminAccess(attacker)) || MT_IsAdminImmune(victim, attacker) || bIsAdminImmune(victim, attacker))
			{
				return Plugin_Continue;
			}

			if (StrEqual(sClassname, "weapon_tank_claw") || StrEqual(sClassname, "tank_rock"))
			{
				vDrunkHit(victim, attacker, g_esAbility[MT_GetTankType(attacker)].g_flDrunkChance, g_esAbility[MT_GetTankType(attacker)].g_iDrunkHit, MT_MESSAGE_MELEE, MT_ATTACK_CLAW);
			}
		}
		else if (MT_IsTankSupported(victim) && bIsCloneAllowed(victim, g_bCloneInstalled) && (g_esAbility[MT_GetTankType(victim)].g_iDrunkHitMode == 0 || g_esAbility[MT_GetTankType(victim)].g_iDrunkHitMode == 2) && bIsSurvivor(attacker))
		{
			if ((!MT_HasAdminAccess(victim) && !bHasAdminAccess(victim)) || MT_IsAdminImmune(attacker, victim) || bIsAdminImmune(attacker, victim))
			{
				return Plugin_Continue;
			}

			if (StrEqual(sClassname, "weapon_melee"))
			{
				vDrunkHit(attacker, victim, g_esAbility[MT_GetTankType(victim)].g_flDrunkChance, g_esAbility[MT_GetTankType(victim)].g_iDrunkHit, MT_MESSAGE_MELEE, MT_ATTACK_MELEE);
			}
		}
	}

	return Plugin_Continue;
}

public void MT_OnPluginCheck(ArrayList &list)
{
	char sName[32];
	GetPluginFilename(null, sName, sizeof(sName));
	list.PushString(sName);
}

public void MT_OnAbilityCheck(ArrayList &list, ArrayList &list2, ArrayList &list3, ArrayList &list4)
{
	list.PushString("drunkability");
	list2.PushString("drunk ability");
	list3.PushString("drunk_ability");
	list4.PushString("drunk");
}

public void MT_OnConfigsLoad(int mode)
{
	if (mode == 3)
	{
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			if (bIsValidClient(iPlayer))
			{
				g_esPlayer[iPlayer].g_iAccessFlags2 = 0;
				g_esPlayer[iPlayer].g_iImmunityFlags2 = 0;
			}
		}
	}
	else if (mode == 1)
	{
		for (int iIndex = MT_GetMinType(); iIndex <= MT_GetMaxType(); iIndex++)
		{
			g_esAbility[iIndex].g_iAccessFlags = 0;
			g_esAbility[iIndex].g_iImmunityFlags = 0;
			g_esAbility[iIndex].g_iHumanAbility = 0;
			g_esAbility[iIndex].g_iHumanAmmo = 5;
			g_esAbility[iIndex].g_flHumanCooldown = 30.0;
			g_esAbility[iIndex].g_iDrunkAbility = 0;
			g_esAbility[iIndex].g_iDrunkEffect = 0;
			g_esAbility[iIndex].g_iDrunkMessage = 0;
			g_esAbility[iIndex].g_flDrunkChance = 33.3;
			g_esAbility[iIndex].g_flDrunkDuration = 5.0;
			g_esAbility[iIndex].g_iDrunkHit = 0;
			g_esAbility[iIndex].g_iDrunkHitMode = 0;
			g_esAbility[iIndex].g_flDrunkRange = 150.0;
			g_esAbility[iIndex].g_flDrunkRangeChance = 15.0;
			g_esAbility[iIndex].g_flDrunkSpeedInterval = 1.5;
			g_esAbility[iIndex].g_flDrunkTurnInterval = 0.5;
		}
	}
}

public void MT_OnConfigsLoaded(const char[] subsection, const char[] key, const char[] value, int type, int admin, int mode)
{
	if (mode == 3 && bIsValidClient(admin) && value[0] != '\0')
	{
		if (StrEqual(subsection, "drunkability", false) || StrEqual(subsection, "drunk ability", false) || StrEqual(subsection, "drunk_ability", false) || StrEqual(subsection, "drunk", false))
		{
			if (StrEqual(key, "AccessFlags", false) || StrEqual(key, "Access Flags", false) || StrEqual(key, "Access_Flags", false) || StrEqual(key, "access", false))
			{
				g_esPlayer[admin].g_iAccessFlags2 = (value[0] != '\0') ? ReadFlagString(value) : g_esPlayer[admin].g_iAccessFlags2;
			}
			else if (StrEqual(key, "ImmunityFlags", false) || StrEqual(key, "Immunity Flags", false) || StrEqual(key, "Immunity_Flags", false) || StrEqual(key, "immunity", false))
			{
				g_esPlayer[admin].g_iImmunityFlags2 = (value[0] != '\0') ? ReadFlagString(value) : g_esPlayer[admin].g_iImmunityFlags2;
			}
		}
	}

	if (mode < 3 && type > 0)
	{
		g_esAbility[type].g_iHumanAbility = iGetValue(subsection, "drunkability", "drunk ability", "drunk_ability", "drunk", key, "HumanAbility", "Human Ability", "Human_Ability", "human", g_esAbility[type].g_iHumanAbility, value, 0, 1);
		g_esAbility[type].g_iHumanAmmo = iGetValue(subsection, "drunkability", "drunk ability", "drunk_ability", "drunk", key, "HumanAmmo", "Human Ammo", "Human_Ammo", "hammo", g_esAbility[type].g_iHumanAmmo, value, 0, 999999);
		g_esAbility[type].g_flHumanCooldown = flGetValue(subsection, "drunkability", "drunk ability", "drunk_ability", "drunk", key, "HumanCooldown", "Human Cooldown", "Human_Cooldown", "hcooldown", g_esAbility[type].g_flHumanCooldown, value, 0.0, 999999.0);
		g_esAbility[type].g_iDrunkAbility = iGetValue(subsection, "drunkability", "drunk ability", "drunk_ability", "drunk", key, "AbilityEnabled", "Ability Enabled", "Ability_Enabled", "enabled", g_esAbility[type].g_iDrunkAbility, value, 0, 1);
		g_esAbility[type].g_iDrunkEffect = iGetValue(subsection, "drunkability", "drunk ability", "drunk_ability", "drunk", key, "AbilityEffect", "Ability Effect", "Ability_Effect", "effect", g_esAbility[type].g_iDrunkEffect, value, 0, 7);
		g_esAbility[type].g_iDrunkMessage = iGetValue(subsection, "drunkability", "drunk ability", "drunk_ability", "drunk", key, "AbilityMessage", "Ability Message", "Ability_Message", "message", g_esAbility[type].g_iDrunkMessage, value, 0, 3);
		g_esAbility[type].g_flDrunkChance = flGetValue(subsection, "drunkability", "drunk ability", "drunk_ability", "drunk", key, "DrunkChance", "Drunk Chance", "Drunk_Chance", "chance", g_esAbility[type].g_flDrunkChance, value, 0.0, 100.0);
		g_esAbility[type].g_flDrunkDuration = flGetValue(subsection, "drunkability", "drunk ability", "drunk_ability", "drunk", key, "DrunkDuration", "Drunk Duration", "Drunk_Duration", "duration", g_esAbility[type].g_flDrunkDuration, value, 0.1, 999999.0);
		g_esAbility[type].g_iDrunkHit = iGetValue(subsection, "drunkability", "drunk ability", "drunk_ability", "drunk", key, "DrunkHit", "Drunk Hit", "Drunk_Hit", "hit", g_esAbility[type].g_iDrunkHit, value, 0, 1);
		g_esAbility[type].g_iDrunkHitMode = iGetValue(subsection, "drunkability", "drunk ability", "drunk_ability", "drunk", key, "DrunkHitMode", "Drunk Hit Mode", "Drunk_Hit_Mode", "hitmode", g_esAbility[type].g_iDrunkHitMode, value, 0, 2);
		g_esAbility[type].g_flDrunkRange = flGetValue(subsection, "drunkability", "drunk ability", "drunk_ability", "drunk", key, "DrunkRange", "Drunk Range", "Drunk_Range", "range", g_esAbility[type].g_flDrunkRange, value, 1.0, 999999.0);
		g_esAbility[type].g_flDrunkRangeChance = flGetValue(subsection, "drunkability", "drunk ability", "drunk_ability", "drunk", key, "DrunkRangeChance", "Drunk Range Chance", "Drunk_Range_Chance", "rangechance", g_esAbility[type].g_flDrunkRangeChance, value, 0.0, 100.0);
		g_esAbility[type].g_flDrunkSpeedInterval = flGetValue(subsection, "drunkability", "drunk ability", "drunk_ability", "drunk", key, "DrunkSpeedInterval", "Drunk Speed Interval", "Drunk_Speed_Interval", "speedinterval", g_esAbility[type].g_flDrunkSpeedInterval, value, 0.1, 999999.0);
		g_esAbility[type].g_flDrunkTurnInterval = flGetValue(subsection, "drunkability", "drunk ability", "drunk_ability", "drunk", key, "DrunkTurnInterval", "Drunk Turn Interval", "Drunk_Turn_Interval", "turninterval", g_esAbility[type].g_flDrunkTurnInterval, value, 0.1, 999999.0);

		if (StrEqual(subsection, "drunkability", false) || StrEqual(subsection, "drunk ability", false) || StrEqual(subsection, "drunk_ability", false) || StrEqual(subsection, "drunk", false))
		{
			if (StrEqual(key, "AccessFlags", false) || StrEqual(key, "Access Flags", false) || StrEqual(key, "Access_Flags", false) || StrEqual(key, "access", false))
			{
				g_esAbility[type].g_iAccessFlags = (value[0] != '\0') ? ReadFlagString(value) : g_esAbility[type].g_iAccessFlags;
			}
			else if (StrEqual(key, "ImmunityFlags", false) || StrEqual(key, "Immunity Flags", false) || StrEqual(key, "Immunity_Flags", false) || StrEqual(key, "immunity", false))
			{
				g_esAbility[type].g_iImmunityFlags = (value[0] != '\0') ? ReadFlagString(value) : g_esAbility[type].g_iImmunityFlags;
			}
		}
	}
}

public void MT_OnPluginEnd()
{
	for (int iSurvivor = 1; iSurvivor <= MaxClients; iSurvivor++)
	{
		if (bIsSurvivor(iSurvivor, MT_CHECK_INGAME|MT_CHECK_ALIVE|MT_CHECK_INKICKQUEUE) && g_esPlayer[iSurvivor].g_bDrunk)
		{
			SetEntPropFloat(iSurvivor, Prop_Send, "m_flLaggedMovementValue", g_esPlayer[iSurvivor].g_flOriginalSpeed);
		}
	}
}

public void MT_OnEventFired(Event event, const char[] name, bool dontBroadcast)
{
	if (StrEqual(name, "player_death") || StrEqual(name, "player_spawn"))
	{
		int iTankId = event.GetInt("userid"), iTank = GetClientOfUserId(iTankId);
		if (MT_IsTankSupported(iTank, MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_INKICKQUEUE))
		{
			vRemoveDrunk(iTank);
		}
	}

	if (StrEqual(name, "player_spawn"))
	{
		int iSurvivorId = event.GetInt("userid"), iSurvivor = GetClientOfUserId(iSurvivorId);
		if (bIsSurvivor(iSurvivor, MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_INKICKQUEUE|MT_CHECK_ALIVE))
		{
			g_esPlayer[iSurvivor].g_flOriginalSpeed = GetEntPropFloat(iSurvivor, Prop_Send, "m_flLaggedMovementValue");
		}
	}
}

public void MT_OnAbilityActivated(int tank)
{
	if (MT_IsTankSupported(tank, MT_CHECK_INGAME|MT_CHECK_FAKECLIENT) && ((!MT_HasAdminAccess(tank) && !bHasAdminAccess(tank)) || g_esAbility[MT_GetTankType(tank)].g_iHumanAbility == 0))
	{
		return;
	}

	if (MT_IsTankSupported(tank) && (!MT_IsTankSupported(tank, MT_CHECK_FAKECLIENT) || g_esAbility[MT_GetTankType(tank)].g_iHumanAbility == 0) && bIsCloneAllowed(tank, g_bCloneInstalled) && g_esAbility[MT_GetTankType(tank)].g_iDrunkAbility == 1)
	{
		vDrunkAbility(tank);
	}
}

public void MT_OnButtonPressed(int tank, int button)
{
	if (MT_IsTankSupported(tank, MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_ALIVE|MT_CHECK_INKICKQUEUE|MT_CHECK_FAKECLIENT) && bIsCloneAllowed(tank, g_bCloneInstalled))
	{
		if (!MT_HasAdminAccess(tank) && !bHasAdminAccess(tank))
		{
			return;
		}

		if (button & MT_SUB_KEY == MT_SUB_KEY)
		{
			if (g_esAbility[MT_GetTankType(tank)].g_iDrunkAbility == 1 && g_esAbility[MT_GetTankType(tank)].g_iHumanAbility == 1)
			{
				if (!g_esPlayer[tank].g_bDrunk2 && !g_esPlayer[tank].g_bDrunk3)
				{
					vDrunkAbility(tank);
				}
				else if (g_esPlayer[tank].g_bDrunk2)
				{
					MT_PrintToChat(tank, "%s %t", MT_TAG3, "DrunkHuman3");
				}
				else if (g_esPlayer[tank].g_bDrunk3)
				{
					MT_PrintToChat(tank, "%s %t", MT_TAG3, "DrunkHuman4");
				}
			}
		}
	}
}

public void MT_OnChangeType(int tank, bool revert)
{
	vRemoveDrunk(tank);
}

static void vDrunkAbility(int tank)
{
	if (!MT_HasAdminAccess(tank) && !bHasAdminAccess(tank))
	{
		return;
	}

	if (g_esPlayer[tank].g_iDrunkCount < g_esAbility[MT_GetTankType(tank)].g_iHumanAmmo && g_esAbility[MT_GetTankType(tank)].g_iHumanAmmo > 0)
	{
		g_esPlayer[tank].g_bDrunk4 = false;
		g_esPlayer[tank].g_bDrunk5 = false;

		float flTankPos[3];
		GetClientAbsOrigin(tank, flTankPos);

		int iSurvivorCount;
		for (int iSurvivor = 1; iSurvivor <= MaxClients; iSurvivor++)
		{
			if (bIsSurvivor(iSurvivor, MT_CHECK_INGAME|MT_CHECK_ALIVE|MT_CHECK_INKICKQUEUE) && !MT_IsAdminImmune(iSurvivor, tank) && !bIsAdminImmune(iSurvivor, tank))
			{
				float flSurvivorPos[3];
				GetClientAbsOrigin(iSurvivor, flSurvivorPos);

				float flDistance = GetVectorDistance(flTankPos, flSurvivorPos);
				if (flDistance <= g_esAbility[MT_GetTankType(tank)].g_flDrunkRange)
				{
					vDrunkHit(iSurvivor, tank, g_esAbility[MT_GetTankType(tank)].g_flDrunkRangeChance, g_esAbility[MT_GetTankType(tank)].g_iDrunkAbility, MT_MESSAGE_RANGE, MT_ATTACK_RANGE);

					iSurvivorCount++;
				}
			}
		}

		if (iSurvivorCount == 0)
		{
			if (MT_IsTankSupported(tank, MT_CHECK_FAKECLIENT) && g_esAbility[MT_GetTankType(tank)].g_iHumanAbility == 1)
			{
				MT_PrintToChat(tank, "%s %t", MT_TAG3, "DrunkHuman5");
			}
		}
	}
	else if (MT_IsTankSupported(tank, MT_CHECK_FAKECLIENT) && g_esAbility[MT_GetTankType(tank)].g_iHumanAbility == 1)
	{
		MT_PrintToChat(tank, "%s %t", MT_TAG3, "DrunkAmmo");
	}
}

static void vDrunkHit(int survivor, int tank, float chance, int enabled, int messages, int flags)
{
	if ((!MT_HasAdminAccess(tank) && !bHasAdminAccess(tank)) || MT_IsAdminImmune(survivor, tank) || bIsAdminImmune(survivor, tank))
	{
		return;
	}

	if (enabled == 1 && bIsSurvivor(survivor))
	{
		if (g_esPlayer[tank].g_iDrunkCount < g_esAbility[MT_GetTankType(tank)].g_iHumanAmmo && g_esAbility[MT_GetTankType(tank)].g_iHumanAmmo > 0)
		{
			if (GetRandomFloat(0.1, 100.0) <= chance && !g_esPlayer[survivor].g_bDrunk)
			{
				g_esPlayer[survivor].g_bDrunk = true;
				g_esPlayer[survivor].g_iDrunkOwner = tank;

				if (MT_IsTankSupported(tank, MT_CHECK_FAKECLIENT) && g_esAbility[MT_GetTankType(tank)].g_iHumanAbility == 1 && (flags & MT_ATTACK_RANGE) && !g_esPlayer[tank].g_bDrunk2)
				{
					g_esPlayer[tank].g_bDrunk2 = true;
					g_esPlayer[tank].g_iDrunkCount++;

					MT_PrintToChat(tank, "%s %t", MT_TAG3, "DrunkHuman", g_esPlayer[tank].g_iDrunkCount, g_esAbility[MT_GetTankType(tank)].g_iHumanAmmo);
				}

				DataPack dpDrunkSpeed;
				CreateDataTimer(g_esAbility[MT_GetTankType(tank)].g_flDrunkSpeedInterval, tTimerDrunkSpeed, dpDrunkSpeed, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
				dpDrunkSpeed.WriteCell(GetClientUserId(survivor));
				dpDrunkSpeed.WriteCell(GetClientUserId(tank));
				dpDrunkSpeed.WriteCell(MT_GetTankType(tank));
				dpDrunkSpeed.WriteCell(enabled);
				dpDrunkSpeed.WriteFloat(GetEngineTime());

				DataPack dpDrunkTurn;
				CreateDataTimer(g_esAbility[MT_GetTankType(tank)].g_flDrunkTurnInterval, tTimerDrunkTurn, dpDrunkTurn, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
				dpDrunkTurn.WriteCell(GetClientUserId(survivor));
				dpDrunkTurn.WriteCell(GetClientUserId(tank));
				dpDrunkTurn.WriteCell(MT_GetTankType(tank));
				dpDrunkTurn.WriteCell(messages);
				dpDrunkTurn.WriteCell(enabled);
				dpDrunkTurn.WriteFloat(GetEngineTime());

				vEffect(survivor, tank, g_esAbility[MT_GetTankType(tank)].g_iDrunkEffect, flags);

				if (g_esAbility[MT_GetTankType(tank)].g_iDrunkMessage & messages)
				{
					char sTankName[33];
					MT_GetTankName(tank, MT_GetTankType(tank), sTankName);
					MT_PrintToChatAll("%s %t", MT_TAG2, "Drunk", sTankName, survivor);
				}
			}
			else if ((flags & MT_ATTACK_RANGE) && !g_esPlayer[tank].g_bDrunk2)
			{
				if (MT_IsTankSupported(tank, MT_CHECK_FAKECLIENT) && g_esAbility[MT_GetTankType(tank)].g_iHumanAbility == 1 && !g_esPlayer[tank].g_bDrunk4)
				{
					g_esPlayer[tank].g_bDrunk4 = true;

					MT_PrintToChat(tank, "%s %t", MT_TAG3, "DrunkHuman2");
				}
			}
		}
		else if (MT_IsTankSupported(tank, MT_CHECK_FAKECLIENT) && g_esAbility[MT_GetTankType(tank)].g_iHumanAbility == 1 && !g_esPlayer[tank].g_bDrunk5)
		{
			g_esPlayer[tank].g_bDrunk5 = true;

			MT_PrintToChat(tank, "%s %t", MT_TAG3, "DrunkAmmo");
		}
	}
}

static void vRemoveDrunk(int tank)
{
	for (int iSurvivor = 1; iSurvivor <= MaxClients; iSurvivor++)
	{
		if (bIsSurvivor(iSurvivor, MT_CHECK_INGAME|MT_CHECK_INKICKQUEUE) && g_esPlayer[iSurvivor].g_bDrunk && g_esPlayer[iSurvivor].g_iDrunkOwner == tank)
		{
			g_esPlayer[iSurvivor].g_bDrunk = false;
			g_esPlayer[iSurvivor].g_iDrunkOwner = 0;
		}
	}

	vReset3(tank);
}

static void vReset()
{
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsValidClient(iPlayer, MT_CHECK_INGAME|MT_CHECK_INKICKQUEUE))
		{
			vReset3(iPlayer);

			g_esPlayer[iPlayer].g_iDrunkOwner = 0;
		}
	}
}

static void vReset2(int survivor, int tank, int messages)
{
	g_esPlayer[survivor].g_bDrunk = false;
	g_esPlayer[survivor].g_iDrunkOwner = 0;

	if (g_esAbility[MT_GetTankType(tank)].g_iDrunkMessage & messages)
	{
		MT_PrintToChatAll("%s %t", MT_TAG2, "Drunk2", survivor);
	}
}

static void vReset3(int tank)
{
	g_esPlayer[tank].g_bDrunk = false;
	g_esPlayer[tank].g_bDrunk2 = false;
	g_esPlayer[tank].g_bDrunk3 = false;
	g_esPlayer[tank].g_bDrunk4 = false;
	g_esPlayer[tank].g_bDrunk5 = false;
	g_esPlayer[tank].g_iDrunkCount = 0;
	g_esPlayer[tank].g_flOriginalSpeed = 1.0;
}

static bool bHasAdminAccess(int admin)
{
	if (!bIsValidClient(admin, MT_CHECK_FAKECLIENT))
	{
		return true;
	}

	int iAbilityFlags = g_esAbility[MT_GetTankType(admin)].g_iAccessFlags;
	if (iAbilityFlags != 0 && g_esPlayer[admin].g_iAccessFlags2 != 0)
	{
		return (!(g_esPlayer[admin].g_iAccessFlags2 & iAbilityFlags)) ? false : true;
	}

	int iTypeFlags = MT_GetAccessFlags(2, MT_GetTankType(admin));
	if (iTypeFlags != 0 && g_esPlayer[admin].g_iAccessFlags2 != 0)
	{
		return (!(g_esPlayer[admin].g_iAccessFlags2 & iTypeFlags)) ? false : true;
	}

	int iGlobalFlags = MT_GetAccessFlags(1);
	if (iGlobalFlags != 0 && g_esPlayer[admin].g_iAccessFlags2 != 0)
	{
		return (!(g_esPlayer[admin].g_iAccessFlags2 & iGlobalFlags)) ? false : true;
	}

	int iClientTypeFlags = MT_GetAccessFlags(4, MT_GetTankType(admin), admin);
	if (iClientTypeFlags != 0 && iAbilityFlags != 0)
	{
		return (!(iClientTypeFlags & iAbilityFlags)) ? false : true;
	}

	int iClientGlobalFlags = MT_GetAccessFlags(3, 0, admin);
	if (iClientGlobalFlags != 0 && iAbilityFlags != 0)
	{
		return (!(iClientGlobalFlags & iAbilityFlags)) ? false : true;
	}

	if (iAbilityFlags != 0)
	{
		return (!(GetUserFlagBits(admin) & iAbilityFlags)) ? false : true;
	}

	return true;
}

static bool bIsAdminImmune(int survivor, int tank)
{
	if (!bIsValidClient(survivor, MT_CHECK_FAKECLIENT))
	{
		return false;
	}

	int iAbilityFlags = g_esAbility[MT_GetTankType(tank)].g_iImmunityFlags;
	if (iAbilityFlags != 0 && g_esPlayer[survivor].g_iImmunityFlags2 != 0 && (g_esPlayer[survivor].g_iImmunityFlags2 & iAbilityFlags))
	{
		return (g_esPlayer[tank].g_iImmunityFlags2 != 0 && (g_esPlayer[tank].g_iImmunityFlags2 & iAbilityFlags) && g_esPlayer[survivor].g_iImmunityFlags2 <= g_esPlayer[tank].g_iImmunityFlags2) ? false : true;
	}

	int iTypeFlags = MT_GetImmunityFlags(2, MT_GetTankType(tank));
	if (iTypeFlags != 0 && g_esPlayer[survivor].g_iImmunityFlags2 != 0 && (g_esPlayer[survivor].g_iImmunityFlags2 & iTypeFlags))
	{
		return (g_esPlayer[tank].g_iImmunityFlags2 != 0 && (g_esPlayer[tank].g_iImmunityFlags2 & iAbilityFlags) && g_esPlayer[survivor].g_iImmunityFlags2 <= g_esPlayer[tank].g_iImmunityFlags2) ? false : true;
	}

	int iGlobalFlags = MT_GetImmunityFlags(1);
	if (iGlobalFlags != 0 && g_esPlayer[survivor].g_iImmunityFlags2 != 0 && (g_esPlayer[survivor].g_iImmunityFlags2 & iGlobalFlags))
	{
		return (g_esPlayer[tank].g_iImmunityFlags2 != 0 && (g_esPlayer[tank].g_iImmunityFlags2 & iAbilityFlags) && g_esPlayer[survivor].g_iImmunityFlags2 <= g_esPlayer[tank].g_iImmunityFlags2) ? false : true;
	}

	int iClientTypeFlags = MT_GetImmunityFlags(4, MT_GetTankType(tank), survivor),
		iClientTypeFlags2 = MT_GetImmunityFlags(4, MT_GetTankType(tank), tank);
	if (iClientTypeFlags != 0 && iAbilityFlags != 0 && (iClientTypeFlags & iAbilityFlags))
	{
		return (iClientTypeFlags2 != 0 && (iClientTypeFlags2 & iAbilityFlags) && iClientTypeFlags <= iClientTypeFlags2) ? false : true;
	}

	int iClientGlobalFlags = MT_GetImmunityFlags(3, 0, survivor),
		iClientGlobalFlags2 = MT_GetImmunityFlags(3, 0, tank);
	if (iClientGlobalFlags != 0 && iAbilityFlags != 0 && (iClientGlobalFlags & iAbilityFlags))
	{
		return (iClientGlobalFlags2 != 0 && (iClientGlobalFlags2 & iAbilityFlags) && iClientGlobalFlags <= iClientGlobalFlags2) ? false : true;
	}

	int iSurvivorFlags = GetUserFlagBits(survivor), iTankFlags = GetUserFlagBits(tank);
	if (iAbilityFlags != 0 && iSurvivorFlags != 0 && (iSurvivorFlags & iAbilityFlags))
	{
		return (iTankFlags != 0 && iSurvivorFlags <= iTankFlags) ? false : true;
	}

	return false;
}

public Action tTimerDrunkSpeed(Handle timer, DataPack pack)
{
	pack.Reset();

	int iSurvivor = GetClientOfUserId(pack.ReadCell());
	if (!MT_IsCorePluginEnabled() || !bIsSurvivor(iSurvivor) || !g_esPlayer[iSurvivor].g_bDrunk)
	{
		return Plugin_Stop;
	}

	int iTank = GetClientOfUserId(pack.ReadCell()), iType = pack.ReadCell();
	if (!MT_IsTankSupported(iTank) || (!MT_HasAdminAccess(iTank) && !bHasAdminAccess(iTank)) || !MT_IsTypeEnabled(MT_GetTankType(iTank)) || !bIsCloneAllowed(iTank, g_bCloneInstalled) || iType != MT_GetTankType(iTank) || MT_IsAdminImmune(iSurvivor, iTank) || bIsAdminImmune(iSurvivor, iTank))
	{
		return Plugin_Stop;
	}

	int iDrunkEnabled = pack.ReadCell();
	float flTime = pack.ReadFloat();
	if (iDrunkEnabled == 0 || (flTime + g_esAbility[MT_GetTankType(iTank)].g_flDrunkDuration < GetEngineTime()))
	{
		return Plugin_Stop;
	}

	g_esPlayer[iSurvivor].g_flOriginalSpeed = GetEntPropFloat(iSurvivor, Prop_Send, "m_flLaggedMovementValue");
	SetEntPropFloat(iSurvivor, Prop_Send, "m_flLaggedMovementValue", GetRandomFloat(1.5, 3.0));

	CreateTimer(GetRandomFloat(1.0, 3.0), tTimerStopDrunkSpeed, GetClientUserId(iSurvivor), TIMER_FLAG_NO_MAPCHANGE);

	return Plugin_Continue;
}

public Action tTimerDrunkTurn(Handle timer, DataPack pack)
{
	pack.Reset();

	int iSurvivor = GetClientOfUserId(pack.ReadCell());
	if (!MT_IsCorePluginEnabled() || !bIsSurvivor(iSurvivor))
	{
		g_esPlayer[iSurvivor].g_bDrunk = false;
		g_esPlayer[iSurvivor].g_iDrunkOwner = 0;

		return Plugin_Stop;
	}

	int iTank = GetClientOfUserId(pack.ReadCell()), iType = pack.ReadCell(), iMessage = pack.ReadCell();
	if (!MT_IsTankSupported(iTank) || (!MT_HasAdminAccess(iTank) && !bHasAdminAccess(iTank)) || !MT_IsTypeEnabled(MT_GetTankType(iTank)) || !bIsCloneAllowed(iTank, g_bCloneInstalled) || iType != MT_GetTankType(iTank) || MT_IsAdminImmune(iSurvivor, iTank) || bIsAdminImmune(iSurvivor, iTank) || !g_esPlayer[iSurvivor].g_bDrunk)
	{
		vReset2(iSurvivor, iTank, iMessage);

		return Plugin_Stop;
	}

	int iDrunkEnabled = pack.ReadCell();
	float flTime = pack.ReadFloat();
	if (iDrunkEnabled == 0 || (flTime + g_esAbility[MT_GetTankType(iTank)].g_flDrunkDuration < GetEngineTime()))
	{
		g_esPlayer[iTank].g_bDrunk2 = false;

		vReset2(iSurvivor, iTank, iMessage);

		if (MT_IsTankSupported(iTank, MT_CHECK_FAKECLIENT) && g_esAbility[MT_GetTankType(iTank)].g_iHumanAbility == 1 && (iMessage & MT_MESSAGE_RANGE) && !g_esPlayer[iTank].g_bDrunk3)
		{
			g_esPlayer[iTank].g_bDrunk3 = true;

			MT_PrintToChat(iTank, "%s %t", MT_TAG3, "DrunkHuman6");

			if (g_esPlayer[iTank].g_iDrunkCount < g_esAbility[MT_GetTankType(iTank)].g_iHumanAmmo && g_esAbility[MT_GetTankType(iTank)].g_iHumanAmmo > 0)
			{
				CreateTimer(g_esAbility[MT_GetTankType(iTank)].g_flHumanCooldown, tTimerResetCooldown, GetClientUserId(iTank), TIMER_FLAG_NO_MAPCHANGE);
			}
			else
			{
				g_esPlayer[iTank].g_bDrunk3 = false;
			}
		}

		return Plugin_Stop;
	}

	float flAngle = GetRandomFloat(-360.0, 360.0), flPunchAngles[3], flEyeAngles[3];
	GetClientEyeAngles(iSurvivor, flEyeAngles);

	flEyeAngles[1] -= flAngle;
	flPunchAngles[1] += flAngle;

	TeleportEntity(iSurvivor, NULL_VECTOR, flEyeAngles, NULL_VECTOR);
	SetEntPropVector(iSurvivor, Prop_Send, "m_vecPunchAngle", flPunchAngles);

	return Plugin_Continue;
}

public Action tTimerStopDrunkSpeed(Handle timer, int userid)
{
	int iSurvivor = GetClientOfUserId(userid);
	if (!bIsSurvivor(iSurvivor))
	{
		return Plugin_Stop;
	}

	SetEntPropFloat(iSurvivor, Prop_Send, "m_flLaggedMovementValue", g_esPlayer[iSurvivor].g_flOriginalSpeed);

	return Plugin_Continue;
}

public Action tTimerResetCooldown(Handle timer, int userid)
{
	int iTank = GetClientOfUserId(userid);
	if (!MT_IsTankSupported(iTank, MT_CHECK_INDEX|MT_CHECK_INGAME|MT_CHECK_ALIVE|MT_CHECK_INKICKQUEUE|MT_CHECK_FAKECLIENT) || !bIsCloneAllowed(iTank, g_bCloneInstalled) || !g_esPlayer[iTank].g_bDrunk3)
	{
		g_esPlayer[iTank].g_bDrunk3 = false;

		return Plugin_Stop;
	}

	g_esPlayer[iTank].g_bDrunk3 = false;

	MT_PrintToChat(iTank, "%s %t", MT_TAG3, "DrunkHuman7");

	return Plugin_Continue;
}