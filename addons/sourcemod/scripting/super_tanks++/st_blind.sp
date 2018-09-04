// Super Tanks++: Blind Ability
#define REQUIRE_PLUGIN
#include <super_tanks++>
#undef REQUIRE_PLUGIN
#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo =
{
	name = "[ST++] Blind Ability",
	author = ST_AUTHOR,
	description = ST_DESCRIPTION,
	version = ST_VERSION,
	url = ST_URL
};

bool g_bBlind[MAXPLAYERS + 1], g_bLateLoad, g_bTankConfig[ST_MAXTYPES + 1];
float g_flBlindDuration[ST_MAXTYPES + 1], g_flBlindDuration2[ST_MAXTYPES + 1],
	g_flBlindRange[ST_MAXTYPES + 1], g_flBlindRange2[ST_MAXTYPES + 1];
int g_iBlindAbility[ST_MAXTYPES + 1], g_iBlindAbility2[ST_MAXTYPES + 1],
	g_iBlindChance[ST_MAXTYPES + 1], g_iBlindChance2[ST_MAXTYPES + 1],
	g_iBlindHit[ST_MAXTYPES + 1], g_iBlindHit2[ST_MAXTYPES + 1], g_iBlindIntensity[ST_MAXTYPES + 1],
	g_iBlindIntensity2[ST_MAXTYPES + 1], g_iBlindRangeChance[ST_MAXTYPES + 1],
	g_iBlindRangeChance2[ST_MAXTYPES + 1];
UserMsg g_umFadeUserMsgId;

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	EngineVersion evEngine = GetEngineVersion();
	if (evEngine != Engine_Left4Dead && evEngine != Engine_Left4Dead2)
	{
		strcopy(error, err_max, "[ST++] Blind Ability only supports Left 4 Dead 1 & 2.");
		return APLRes_SilentFailure;
	}
	g_bLateLoad = late;
	return APLRes_Success;
}

public void OnPluginStart()
{
	g_umFadeUserMsgId = GetUserMessageId("Fade");
}

public void OnMapStart()
{
	vReset();
	if (g_bLateLoad)
	{
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			if (bIsValidClient(iPlayer))
			{
				SDKHook(iPlayer, SDKHook_OnTakeDamage, OnTakeDamage);
			}
		}
		g_bLateLoad = false;
	}
}

public void OnClientPostAdminCheck(int client)
{
	SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
	g_bBlind[client] = false;
}

public void OnMapEnd()
{
	vReset();
}

public Action OnTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype)
{
	if (ST_PluginEnabled() && damage > 0.0)
	{
		if (ST_TankAllowed(attacker) && IsPlayerAlive(attacker) && bIsSurvivor(victim))
		{
			char sClassname[32];
			GetEntityClassname(inflictor, sClassname, sizeof(sClassname));
			if (strcmp(sClassname, "weapon_tank_claw") == 0 || strcmp(sClassname, "tank_rock") == 0)
			{
				int iBlindChance = !g_bTankConfig[ST_TankType(attacker)] ? g_iBlindChance[ST_TankType(attacker)] : g_iBlindChance2[ST_TankType(attacker)],
					iBlindHit = !g_bTankConfig[ST_TankType(attacker)] ? g_iBlindHit[ST_TankType(attacker)] : g_iBlindHit2[ST_TankType(attacker)];
				vBlindHit(victim, attacker, iBlindChance, iBlindHit);
			}
		}
	}
}

public void ST_Configs(char[] savepath, bool main)
{
	KeyValues kvSuperTanks = new KeyValues("Super Tanks++");
	kvSuperTanks.ImportFromFile(savepath);
	for (int iIndex = ST_MinType(); iIndex <= ST_MaxType(); iIndex++)
	{
		char sName[MAX_NAME_LENGTH + 1];
		Format(sName, sizeof(sName), "Tank %d", iIndex);
		if (kvSuperTanks.JumpToKey(sName))
		{
			main ? (g_bTankConfig[iIndex] = false) : (g_bTankConfig[iIndex] = true);
			main ? (g_iBlindAbility[iIndex] = kvSuperTanks.GetNum("Blind Ability/Ability Enabled", 0)) : (g_iBlindAbility2[iIndex] = kvSuperTanks.GetNum("Blind Ability/Ability Enabled", g_iBlindAbility[iIndex]));
			main ? (g_iBlindAbility[iIndex] = iSetCellLimit(g_iBlindAbility[iIndex], 0, 1)) : (g_iBlindAbility2[iIndex] = iSetCellLimit(g_iBlindAbility2[iIndex], 0, 1));
			main ? (g_iBlindChance[iIndex] = kvSuperTanks.GetNum("Blind Ability/Blind Chance", 4)) : (g_iBlindChance2[iIndex] = kvSuperTanks.GetNum("Blind Ability/Blind Chance", g_iBlindChance[iIndex]));
			main ? (g_iBlindChance[iIndex] = iSetCellLimit(g_iBlindChance[iIndex], 1, 9999999999)) : (g_iBlindChance2[iIndex] = iSetCellLimit(g_iBlindChance2[iIndex], 1, 9999999999));
			main ? (g_flBlindDuration[iIndex] = kvSuperTanks.GetFloat("Blind Ability/Blind Duration", 5.0)) : (g_flBlindDuration2[iIndex] = kvSuperTanks.GetFloat("Blind Ability/Blind Duration", g_flBlindDuration[iIndex]));
			main ? (g_flBlindDuration[iIndex] = flSetFloatLimit(g_flBlindDuration[iIndex], 0.1, 9999999999.0)) : (g_flBlindDuration2[iIndex] = flSetFloatLimit(g_flBlindDuration2[iIndex], 0.1, 9999999999.0));
			main ? (g_iBlindHit[iIndex] = kvSuperTanks.GetNum("Blind Ability/Blind Hit", 0)) : (g_iBlindHit2[iIndex] = kvSuperTanks.GetNum("Blind Ability/Blind Hit", g_iBlindHit[iIndex]));
			main ? (g_iBlindHit[iIndex] = iSetCellLimit(g_iBlindHit[iIndex], 0, 1)) : (g_iBlindHit2[iIndex] = iSetCellLimit(g_iBlindHit2[iIndex], 0, 1));
			main ? (g_iBlindIntensity[iIndex] = kvSuperTanks.GetNum("Blind Ability/Blind Intensity", 255)) : (g_iBlindIntensity2[iIndex] = kvSuperTanks.GetNum("Blind Ability/Blind Intensity", g_iBlindIntensity[iIndex]));
			main ? (g_iBlindIntensity[iIndex] = iSetCellLimit(g_iBlindIntensity[iIndex], 0, 255)) : (g_iBlindIntensity2[iIndex] = iSetCellLimit(g_iBlindIntensity2[iIndex], 0, 255));
			main ? (g_flBlindRange[iIndex] = kvSuperTanks.GetFloat("Blind Ability/Blind Range", 150.0)) : (g_flBlindRange2[iIndex] = kvSuperTanks.GetFloat("Blind Ability/Blind Range", g_flBlindRange[iIndex]));
			main ? (g_flBlindRange[iIndex] = flSetFloatLimit(g_flBlindRange[iIndex], 1.0, 9999999999.0)) : (g_flBlindRange2[iIndex] = flSetFloatLimit(g_flBlindRange2[iIndex], 1.0, 9999999999.0));
			main ? (g_iBlindRangeChance[iIndex] = kvSuperTanks.GetNum("Blind Ability/Blind Range Chance", 16)) : (g_iBlindRangeChance2[iIndex] = kvSuperTanks.GetNum("Blind Ability/Blind Range Chance", g_iBlindRangeChance[iIndex]));
			main ? (g_iBlindRangeChance[iIndex] = iSetCellLimit(g_iBlindRangeChance[iIndex], 1, 9999999999)) : (g_iBlindRangeChance2[iIndex] = iSetCellLimit(g_iBlindRangeChance2[iIndex], 1, 9999999999));
			kvSuperTanks.Rewind();
		}
	}
	delete kvSuperTanks;
}

public void ST_Event(Event event, const char[] name)
{
	if (strcmp(name, "player_death") == 0)
	{
		int iTankId = event.GetInt("userid"), iTank = GetClientOfUserId(iTankId),
			iBlindAbility = !g_bTankConfig[ST_TankType(iTank)] ? g_iBlindAbility[ST_TankType(iTank)] : g_iBlindAbility2[ST_TankType(iTank)];
		if (ST_TankAllowed(iTank) && iBlindAbility == 1)
		{
			vRemoveBlind(iTank);
		}
	}
}

public void ST_Ability(int client)
{
	if (ST_TankAllowed(client) && IsPlayerAlive(client))
	{
		int iBlindAbility = !g_bTankConfig[ST_TankType(client)] ? g_iBlindAbility[ST_TankType(client)] : g_iBlindAbility2[ST_TankType(client)],
			iBlindRangeChance = !g_bTankConfig[ST_TankType(client)] ? g_iBlindChance[ST_TankType(client)] : g_iBlindChance2[ST_TankType(client)];
		float flBlindRange = !g_bTankConfig[ST_TankType(client)] ? g_flBlindRange[ST_TankType(client)] : g_flBlindRange2[ST_TankType(client)],
			flTankPos[3];
		GetClientAbsOrigin(client, flTankPos);
		for (int iSurvivor = 1; iSurvivor <= MaxClients; iSurvivor++)
		{
			if (bIsSurvivor(iSurvivor))
			{
				float flSurvivorPos[3];
				GetClientAbsOrigin(iSurvivor, flSurvivorPos);
				float flDistance = GetVectorDistance(flTankPos, flSurvivorPos);
				if (flDistance <= flBlindRange)
				{
					vBlindHit(iSurvivor, client, iBlindRangeChance, iBlindAbility);
				}
			}
		}
	}
}

public void ST_BossStage(int client)
{
	int iBlindAbility = !g_bTankConfig[ST_TankType(client)] ? g_iBlindAbility[ST_TankType(client)] : g_iBlindAbility2[ST_TankType(client)];
	if (ST_TankAllowed(client) && iBlindAbility == 1)
	{
		vRemoveBlind(client);
	}
}

void vBlind(int client, int amount)
{
	int iTargets[2], iFlags;
	iTargets[0] = client;
	if (bIsSurvivor(client))
	{
		amount == 0 ? (iFlags = (0x0001|0x0010)) : (iFlags = (0x0002|0x0008));
		int iColor[4] = {0, 0, 0, 0};
		iColor[3] = amount;
		Handle hBlindTarget = StartMessageEx(g_umFadeUserMsgId, iTargets, 1);
		if (GetUserMessageType() == UM_Protobuf)
		{
			Protobuf pbSet = UserMessageToProtobuf(hBlindTarget);
			pbSet.SetInt("duration", 1536);
			pbSet.SetInt("hold_time", 1536);
			pbSet.SetInt("flags", iFlags);
			pbSet.SetColor("clr", iColor);
		}
		else
		{
			BfWrite bfWrite = UserMessageToBfWrite(hBlindTarget);
			bfWrite.WriteShort(1536);
			bfWrite.WriteShort(1536);
			bfWrite.WriteShort(iFlags);
			bfWrite.WriteByte(iColor[0]);
			bfWrite.WriteByte(iColor[1]);
			bfWrite.WriteByte(iColor[2]);
			bfWrite.WriteByte(iColor[3]);
		}
		EndMessage();
	}
}

void vBlindHit(int client, int owner, int chance, int enabled)
{
	if (enabled == 1 && GetRandomInt(1, chance) == 1 && bIsSurvivor(client) && !g_bBlind[client])
	{
		g_bBlind[client] = true;
		int iBlindIntensity = !g_bTankConfig[ST_TankType(owner)] ? g_iBlindIntensity[ST_TankType(owner)] : g_iBlindIntensity2[ST_TankType(owner)];
		vBlind(client, iBlindIntensity);
		float flBlindDuration = !g_bTankConfig[ST_TankType(owner)] ? g_flBlindDuration[ST_TankType(owner)] : g_flBlindDuration2[ST_TankType(owner)];
		DataPack dpDataPack = new DataPack();
		CreateDataTimer(flBlindDuration, tTimerStopBlindness, dpDataPack, TIMER_FLAG_NO_MAPCHANGE);
		dpDataPack.WriteCell(GetClientUserId(client));
		dpDataPack.WriteCell(GetClientUserId(owner));
	}
}

void vRemoveBlind(int client)
{
	for (int iSurvivor = 1; iSurvivor <= MaxClients; iSurvivor++)
	{
		if (bIsSurvivor(iSurvivor) && g_bBlind[iSurvivor])
		{
			DataPack dpDataPack = new DataPack();
			CreateDataTimer(0.1, tTimerStopBlindness, dpDataPack, TIMER_FLAG_NO_MAPCHANGE);
			dpDataPack.WriteCell(GetClientUserId(iSurvivor));
			dpDataPack.WriteCell(GetClientUserId(client));
		}
	}
}

void vReset()
{
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsValidClient(iPlayer))
		{
			g_bBlind[iPlayer] = false;
		}
	}
}

public Action tTimerStopBlindness(Handle timer, DataPack pack)
{
	pack.Reset();
	int iSurvivor = GetClientOfUserId(pack.ReadCell());
	if (!bIsSurvivor(iSurvivor))
	{
		g_bBlind[iSurvivor] = false;
		return Plugin_Stop;
	}
	int iTank = GetClientOfUserId(pack.ReadCell());
	if (!ST_TankAllowed(iTank) || !IsPlayerAlive(iTank))
	{
		g_bBlind[iSurvivor] = false;
		vBlind(iSurvivor, 0);
		return Plugin_Stop;
	}
	int iBlindAbility = !g_bTankConfig[ST_TankType(iTank)] ? g_iBlindAbility[ST_TankType(iTank)] : g_iBlindAbility2[ST_TankType(iTank)];
	if (iBlindAbility == 0)
	{
		g_bBlind[iSurvivor] = false;
		vBlind(iSurvivor, 0);
		return Plugin_Stop;
	}
	g_bBlind[iSurvivor] = false;
	vBlind(iSurvivor, 0);
	return Plugin_Continue;
}