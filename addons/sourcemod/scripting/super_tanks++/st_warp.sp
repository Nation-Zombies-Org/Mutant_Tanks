// Super Tanks++: Warp Ability
#pragma semicolon 1
#pragma newdecls required
#include <super_tanks++>

public Plugin myinfo =
{
	name = "[ST++] Warp Ability",
	author = ST_AUTHOR,
	description = ST_DESCRIPTION,
	version = ST_VERSION,
	url = ST_URL
};

bool g_bLateLoad;
bool g_bTankConfig[ST_MAXTYPES + 1];
bool g_bWarp[MAXPLAYERS + 1];
float g_flWarpInterval[ST_MAXTYPES + 1];
float g_flWarpInterval2[ST_MAXTYPES + 1];
int g_iWarpAbility[ST_MAXTYPES + 1];
int g_iWarpAbility2[ST_MAXTYPES + 1];
int g_iWarpChance[ST_MAXTYPES + 1];
int g_iWarpChance2[ST_MAXTYPES + 1];
int g_iWarpHit[ST_MAXTYPES + 1];
int g_iWarpHit2[ST_MAXTYPES + 1];
int g_iWarpMode[ST_MAXTYPES + 1];
int g_iWarpMode2[ST_MAXTYPES + 1];

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	EngineVersion evEngine = GetEngineVersion();
	if (evEngine != Engine_Left4Dead && evEngine != Engine_Left4Dead2)
	{
		strcopy(error, err_max, "[ST++] Warp Ability only supports Left 4 Dead 1 & 2.");
		return APLRes_SilentFailure;
	}
	g_bLateLoad = late;
	return APLRes_Success;
}

public void OnAllPluginsLoaded()
{
	if (!LibraryExists("super_tanks++"))
	{
		SetFailState("No Super Tanks++ library found.");
	}
}

public void OnPluginStart()
{
	vCreateInfoFile("cfg/sourcemod/super_tanks++/", "information/", "st_warp", "st_warp");
}

public void OnMapStart()
{
	vPrecacheParticle(PARTICLE_ELECTRICITY);
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsValidClient(iPlayer))
		{
			g_bWarp[iPlayer] = false;
		}
	}
	if (g_bLateLoad)
	{
		vLateLoad(true);
		g_bLateLoad = false;
	}
}

public void OnClientPostAdminCheck(int client)
{
	SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
	g_bWarp[client] = false;
}

public void OnClientDisconnect(int client)
{
	SDKUnhook(client, SDKHook_OnTakeDamage, OnTakeDamage);
	g_bWarp[client] = false;
}

public void OnMapEnd()
{
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsValidClient(iPlayer))
		{
			g_bWarp[iPlayer] = false;
		}
	}
}

void vLateLoad(bool late)
{
	if (late)
	{
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			if (bIsValidClient(iPlayer))
			{
				SDKHook(iPlayer, SDKHook_OnTakeDamage, OnTakeDamage);
			}
		}
	}
}

public Action OnTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype)
{
	if (ST_PluginEnabled() && damage > 0.0)
	{
		char sClassname[32];
		GetEntityClassname(inflictor, sClassname, sizeof(sClassname));
		if (ST_TankAllowed(attacker) && IsPlayerAlive(attacker) && bIsSurvivor(victim))
		{
			if (strcmp(sClassname, "weapon_tank_claw") == 0 || strcmp(sClassname, "tank_rock") == 0)
			{
				vWarpHit(victim, attacker);
			}
		}
		else if (bIsSurvivor(attacker) && ST_TankAllowed(victim) && IsPlayerAlive(victim))
		{
			if (strcmp(sClassname, "weapon_melee") == 0)
			{
				vWarpHit(attacker, victim);
			}
		}
	}
}

public void ST_Configs(char[] savepath, int limit, bool main)
{
	KeyValues kvSuperTanks = new KeyValues("Super Tanks++");
	kvSuperTanks.ImportFromFile(savepath);
	for (int iIndex = 1; iIndex <= limit; iIndex++)
	{
		char sName[MAX_NAME_LENGTH + 1];
		Format(sName, sizeof(sName), "Tank %d", iIndex);
		if (kvSuperTanks.JumpToKey(sName))
		{
			main ? (g_bTankConfig[iIndex] = false) : (g_bTankConfig[iIndex] = true);
			main ? (g_iWarpAbility[iIndex] = kvSuperTanks.GetNum("Warp Ability/Ability Enabled", 0)) : (g_iWarpAbility2[iIndex] = kvSuperTanks.GetNum("Warp Ability/Ability Enabled", g_iWarpAbility[iIndex]));
			main ? (g_iWarpAbility[iIndex] = iSetCellLimit(g_iWarpAbility[iIndex], 0, 1)) : (g_iWarpAbility2[iIndex] = iSetCellLimit(g_iWarpAbility2[iIndex], 0, 1));
			main ? (g_iWarpChance[iIndex] = kvSuperTanks.GetNum("Warp Ability/Warp Chance", 4)) : (g_iWarpChance2[iIndex] = kvSuperTanks.GetNum("Warp Ability/Warp Chance", g_iWarpChance[iIndex]));
			main ? (g_iWarpChance[iIndex] = iSetCellLimit(g_iWarpChance[iIndex], 1, 9999999999)) : (g_iWarpChance2[iIndex] = iSetCellLimit(g_iWarpChance2[iIndex], 1, 9999999999));
			main ? (g_iWarpHit[iIndex] = kvSuperTanks.GetNum("Warp Ability/Warp Hit", 0)) : (g_iWarpHit2[iIndex] = kvSuperTanks.GetNum("Warp Ability/Warp Hit", g_iWarpHit[iIndex]));
			main ? (g_iWarpHit[iIndex] = iSetCellLimit(g_iWarpHit[iIndex], 0, 1)) : (g_iWarpHit2[iIndex] = iSetCellLimit(g_iWarpHit2[iIndex], 0, 1));
			main ? (g_iWarpMode[iIndex] = kvSuperTanks.GetNum("Warp Ability/Warp Mode", 0)) : (g_iWarpMode2[iIndex] = kvSuperTanks.GetNum("Warp Ability/Warp Mode", g_iWarpMode[iIndex]));
			main ? (g_iWarpMode[iIndex] = iSetCellLimit(g_iWarpMode[iIndex], 0, 1)) : (g_iWarpMode2[iIndex] = iSetCellLimit(g_iWarpMode2[iIndex], 0, 1));
			main ? (g_flWarpInterval[iIndex] = kvSuperTanks.GetFloat("Warp Ability/Warp Interval", 5.0)) : (g_flWarpInterval2[iIndex] = kvSuperTanks.GetFloat("Warp Ability/Warp Interval", g_flWarpInterval[iIndex]));
			main ? (g_flWarpInterval[iIndex] = flSetFloatLimit(g_flWarpInterval[iIndex], 0.1, 9999999999.0)) : (g_flWarpInterval2[iIndex] = flSetFloatLimit(g_flWarpInterval2[iIndex], 0.1, 9999999999.0));
			kvSuperTanks.Rewind();
		}
	}
	delete kvSuperTanks;
}

public void ST_Ability(int client)
{
	int iWarpAbility = !g_bTankConfig[ST_TankType(client)] ? g_iWarpAbility[ST_TankType(client)] : g_iWarpAbility2[ST_TankType(client)];
	if (iWarpAbility == 1 && ST_TankAllowed(client) && IsPlayerAlive(client) && !g_bWarp[client])
	{
		g_bWarp[client] = true;
		float flWarpInterval = !g_bTankConfig[ST_TankType(client)] ? g_flWarpInterval[ST_TankType(client)] : g_flWarpInterval2[ST_TankType(client)];
		CreateTimer(flWarpInterval, tTimerWarp, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
	}
}

void vWarpHit(int client, int owner)
{
	int iWarpChance = !g_bTankConfig[ST_TankType(owner)] ? g_iWarpChance[ST_TankType(owner)] : g_iWarpChance2[ST_TankType(owner)];
	int iWarpHit = !g_bTankConfig[ST_TankType(owner)] ? g_iWarpHit[ST_TankType(owner)] : g_iWarpHit2[ST_TankType(owner)];
	if (iWarpHit == 1 && GetRandomInt(1, iWarpChance) == 1 && bIsSurvivor(client))
	{
		float flCurrentOrigin[3];
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			if (bIsSurvivor(iPlayer) && iPlayer != client)
			{
				GetClientAbsOrigin(iPlayer, flCurrentOrigin);
				TeleportEntity(client, flCurrentOrigin, NULL_VECTOR, NULL_VECTOR);
				break;
			}
		}
	}
}

void vCreateInfoFile(const char[] filepath, const char[] folder, const char[] filename, const char[] label = "")
{
	char sConfigFilename[128];
	char sConfigLabel[128];
	File fFilename;
	Format(sConfigFilename, sizeof(sConfigFilename), "%s%s%s.txt", filepath, folder, filename);
	if (FileExists(sConfigFilename))
	{
		return;
	}
	fFilename = OpenFile(sConfigFilename, "w+");
	strlen(label) > 0 ? strcopy(sConfigLabel, sizeof(sConfigLabel), label) : strcopy(sConfigLabel, sizeof(sConfigLabel), sConfigFilename);
	if (fFilename != null)
	{
		fFilename.WriteLine("// Note: The config will automatically update any changes mid-game. No need to restart the server or reload the plugin.");
		fFilename.WriteLine("\"Super Tanks++\"");
		fFilename.WriteLine("{");
		fFilename.WriteLine("	\"Example\"");
		fFilename.WriteLine("	{");
		fFilename.WriteLine("		// The Super Tank warps to survivors and warps survivors back to teammates.");
		fFilename.WriteLine("		// \"Ability Enabled\" - The Tank warps to a random survivor.");
		fFilename.WriteLine("		// - \"Warp Interval\"");
		fFilename.WriteLine("		// \"Warp Hit\" - When a survivor is hit by a Tank's claw or rock, the survivor is warped to a random teammate.");
		fFilename.WriteLine("		// - \"Warp Chance\"");
		fFilename.WriteLine("		// Requires \"st_warp.smx\" to be installed.");
		fFilename.WriteLine("		\"Warp Ability\"");
		fFilename.WriteLine("		{");
		fFilename.WriteLine("			// Enable this ability.");
		fFilename.WriteLine("			// 0: OFF");
		fFilename.WriteLine("			// 1: ON");
		fFilename.WriteLine("			\"Ability Enabled\"				\"0\"");
		fFilename.WriteLine("");
		fFilename.WriteLine("			// The Super Tank has 1 out of this many chances to trigger the ability.");
		fFilename.WriteLine("			// Minimum: 1 (Greatest chance)");
		fFilename.WriteLine("			// Maximum: 9999999999 (Less chance)");
		fFilename.WriteLine("			\"Warp Chance\"					\"4\"");
		fFilename.WriteLine("");
		fFilename.WriteLine("			// Enable the Super Tank's claw/rock attack.");
		fFilename.WriteLine("			// Note: This setting does not need \"Ability Enabled\" set to 1.");
		fFilename.WriteLine("			// 0: OFF");
		fFilename.WriteLine("			// 1: ON");
		fFilename.WriteLine("			\"Warp Hit\"						\"0\"");
		fFilename.WriteLine("");
		fFilename.WriteLine("			// The Super Tank warps to a random survivor every time this many seconds passes.");
		fFilename.WriteLine("			// Minimum: 0.1");
		fFilename.WriteLine("			// Maximum: 9999999999.0");
		fFilename.WriteLine("			\"Warp Interval\"					\"5.0\"");
		fFilename.WriteLine("");
		fFilename.WriteLine("			// The mode of the Super Tank's warp ability.");
		fFilename.WriteLine("			// 0: The Super Tank warps to a random survivor.");
		fFilename.WriteLine("			// 1: The Super Tank switches places with a random survivor.");
		fFilename.WriteLine("			\"Warp Mode\"						\"0\"");
		fFilename.WriteLine("		}");
		fFilename.WriteLine("	}");
		fFilename.WriteLine("}");
		delete fFilename;
	}
}

public Action tTimerWarp(Handle timer, any userid)
{
	int iTank = GetClientOfUserId(userid);
	if (!ST_TankAllowed(iTank) || !IsPlayerAlive(iTank))
	{
		return Plugin_Stop;
	}
	int iWarpAbility = !g_bTankConfig[ST_TankType(iTank)] ? g_iWarpAbility[ST_TankType(iTank)] : g_iWarpAbility2[ST_TankType(iTank)];
	int iWarpMode = !g_bTankConfig[ST_TankType(iTank)] ? g_iWarpMode[ST_TankType(iTank)] : g_iWarpMode2[ST_TankType(iTank)];
	if (iWarpAbility == 0)
	{
		return Plugin_Stop;
	}
	int iSurvivor = iGetRandomSurvivor(iTank);
	if (iSurvivor > 0)
	{
		float flTankOrigin[3];
		float flTankAngles[3];
		GetClientAbsOrigin(iTank, flTankOrigin);
		GetClientAbsAngles(iTank, flTankAngles);
		float flSurvivorOrigin[3];
		float flSurvivorAngles[3];
		GetClientAbsOrigin(iSurvivor, flSurvivorOrigin);
		GetClientAbsAngles(iSurvivor, flSurvivorAngles);
		vCreateParticle(iTank, PARTICLE_ELECTRICITY, 1.0, 0.0);
		if (iWarpMode == 1)
		{
			vCreateParticle(iSurvivor, PARTICLE_ELECTRICITY, 1.0, 0.0);
		}
		EmitSoundToAll(SOUND_ELECTRICITY, iTank);
		EmitSoundToAll(SOUND_ELECTRICITY2, iSurvivor);
		TeleportEntity(iTank, flSurvivorOrigin, flSurvivorAngles, NULL_VECTOR);
		if (iWarpMode == 1)
		{
			TeleportEntity(iSurvivor, flTankOrigin, flTankAngles, NULL_VECTOR);
		}
	}
	return Plugin_Continue;
}