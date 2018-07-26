// Super Tanks++: Drug Ability
#pragma semicolon 1
#pragma newdecls required
#include <super_tanks++>

public Plugin myinfo =
{
	name = "[ST++] Drug Ability",
	author = ST_AUTHOR,
	description = ST_DESCRIPTION,
	version = ST_VERSION,
	url = ST_URL
};

bool g_bDrug[MAXPLAYERS + 1];
bool g_bLateLoad;
bool g_bTankConfig[ST_MAXTYPES + 1];
float g_flDrugAngles[20] = {0.0, 5.0, 10.0, 15.0, 20.0, 25.0, 20.0, 15.0, 10.0, 5.0, 0.0, -5.0, -10.0, -15.0, -20.0, -25.0, -20.0, -15.0, -10.0, -5.0};
float g_flDrugDuration[ST_MAXTYPES + 1];
float g_flDrugDuration2[ST_MAXTYPES + 1];
float g_flDrugRange[ST_MAXTYPES + 1];
float g_flDrugRange2[ST_MAXTYPES + 1];
int g_iDrugAbility[ST_MAXTYPES + 1];
int g_iDrugAbility2[ST_MAXTYPES + 1];
int g_iDrugChance[ST_MAXTYPES + 1];
int g_iDrugChance2[ST_MAXTYPES + 1];
int g_iDrugHit[ST_MAXTYPES + 1];
int g_iDrugHit2[ST_MAXTYPES + 1];
UserMsg g_umFadeUserMsgId;

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	EngineVersion evEngine = GetEngineVersion();
	if (evEngine != Engine_Left4Dead && evEngine != Engine_Left4Dead2)
	{
		strcopy(error, err_max, "[ST++] Drug Ability only supports Left 4 Dead 1 & 2.");
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
	g_umFadeUserMsgId = GetUserMessageId("Fade");
}

public void OnMapStart()
{
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsValidClient(iPlayer))
		{
			g_bDrug[iPlayer] = false;
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
	g_bDrug[client] = false;
}

public void OnClientDisconnect(int client)
{
	SDKUnhook(client, SDKHook_OnTakeDamage, OnTakeDamage);
	g_bDrug[client] = false;
}

public void OnMapEnd()
{
	for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
	{
		if (bIsValidClient(iPlayer))
		{
			g_bDrug[iPlayer] = false;
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
		if (bIsTank(attacker) && bIsSurvivor(victim))
		{
			char sClassname[32];
			GetEntityClassname(inflictor, sClassname, sizeof(sClassname));
			if (strcmp(sClassname, "weapon_tank_claw") == 0 || strcmp(sClassname, "tank_rock") == 0)
			{
				int iDrugHit = !g_bTankConfig[ST_TankType(attacker)] ? g_iDrugHit[ST_TankType(attacker)] : g_iDrugHit2[ST_TankType(attacker)];
				vDrugHit(victim, attacker, iDrugHit);
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
			main ? (g_iDrugAbility[iIndex] = kvSuperTanks.GetNum("Drug Ability/Ability Enabled", 0)) : (g_iDrugAbility2[iIndex] = kvSuperTanks.GetNum("Drug Ability/Ability Enabled", g_iDrugAbility[iIndex]));
			main ? (g_iDrugAbility[iIndex] = iSetCellLimit(g_iDrugAbility[iIndex], 0, 1)) : (g_iDrugAbility2[iIndex] = iSetCellLimit(g_iDrugAbility2[iIndex], 0, 1));
			main ? (g_iDrugChance[iIndex] = kvSuperTanks.GetNum("Drug Ability/Drug Chance", 4)) : (g_iDrugChance2[iIndex] = kvSuperTanks.GetNum("Drug Ability/Drug Chance", g_iDrugChance[iIndex]));
			main ? (g_iDrugChance[iIndex] = iSetCellLimit(g_iDrugChance[iIndex], 1, 9999999999)) : (g_iDrugChance2[iIndex] = iSetCellLimit(g_iDrugChance2[iIndex], 1, 9999999999));
			main ? (g_flDrugDuration[iIndex] = kvSuperTanks.GetFloat("Drug Ability/Drug Duration", 5.0)) : (g_flDrugDuration2[iIndex] = kvSuperTanks.GetFloat("Drug Ability/Drug Duration", g_flDrugDuration[iIndex]));
			main ? (g_flDrugDuration[iIndex] = flSetFloatLimit(g_flDrugDuration[iIndex], 0.1, 9999999999.0)) : (g_flDrugDuration2[iIndex] = flSetFloatLimit(g_flDrugDuration2[iIndex], 0.1, 9999999999.0));
			main ? (g_iDrugHit[iIndex] = kvSuperTanks.GetNum("Drug Ability/Drug Hit", 0)) : (g_iDrugHit2[iIndex] = kvSuperTanks.GetNum("Drug Ability/Drug Hit", g_iDrugHit[iIndex]));
			main ? (g_iDrugHit[iIndex] = iSetCellLimit(g_iDrugHit[iIndex], 0, 1)) : (g_iDrugHit2[iIndex] = iSetCellLimit(g_iDrugHit2[iIndex], 0, 1));
			main ? (g_flDrugRange[iIndex] = kvSuperTanks.GetFloat("Drug Ability/Drug Range", 150.0)) : (g_flDrugRange2[iIndex] = kvSuperTanks.GetFloat("Drug Ability/Drug Range", g_flDrugRange[iIndex]));
			main ? (g_flDrugRange[iIndex] = flSetFloatLimit(g_flDrugRange[iIndex], 1.0, 9999999999.0)) : (g_flDrugRange2[iIndex] = flSetFloatLimit(g_flDrugRange2[iIndex], 1.0, 9999999999.0));
			kvSuperTanks.Rewind();
		}
	}
	delete kvSuperTanks;
}

public void ST_Ability(int client)
{
	if (bIsTank(client))
	{
		int iDrugAbility = !g_bTankConfig[ST_TankType(client)] ? g_iDrugAbility[ST_TankType(client)] : g_iDrugAbility2[ST_TankType(client)];
		float flDrugRange = !g_bTankConfig[ST_TankType(client)] ? g_flDrugRange[ST_TankType(client)] : g_flDrugRange2[ST_TankType(client)];
		float flTankPos[3];
		GetClientAbsOrigin(client, flTankPos);
		for (int iSurvivor = 1; iSurvivor <= MaxClients; iSurvivor++)
		{
			if (bIsSurvivor(iSurvivor))
			{
				float flSurvivorPos[3];
				GetClientAbsOrigin(iSurvivor, flSurvivorPos);
				float flDistance = GetVectorDistance(flTankPos, flSurvivorPos);
				if (flDistance <= flDrugRange)
				{
					vDrugHit(iSurvivor, client, iDrugAbility);
				}
			}
		}
	}
}

void vDrug(int client, bool toggle, UserMsg message, float angles[20])
{
	float flAngles[3];
	GetClientEyeAngles(client, flAngles);
	flAngles[2] = toggle ? angles[GetRandomInt(0, 100) % 20] : 0.0;
	TeleportEntity(client, NULL_VECTOR, flAngles, NULL_VECTOR);
	int iClients[2];
	iClients[0] = client;
	int iFlags = toggle ? 0x0002 : (0x0001|0x0010);
	int iColor[4] = {0, 0, 0, 128};
	int iColor2[4] = {0, 0, 0, 0};
	if (toggle)
	{
		iColor[0] = GetRandomInt(0, 255);
		iColor[1] = GetRandomInt(0, 255);
		iColor[2] = GetRandomInt(0, 255);
	}
	Handle hDrugTarget = StartMessageEx(message, iClients, 1);
	if (GetUserMessageType() == UM_Protobuf)
	{
		Protobuf pbSet = UserMessageToProtobuf(hDrugTarget);
		pbSet.SetInt("duration", toggle ? 255: 1536);
		pbSet.SetInt("hold_time", toggle ? 255 : 1536);
		pbSet.SetInt("flags", iFlags);
		pbSet.SetColor("clr", toggle ? iColor : iColor2);
	}
	else
	{
		BfWrite bfWrite = UserMessageToBfWrite(hDrugTarget);
		bfWrite.WriteShort(toggle ? 255 : 1536);
		bfWrite.WriteShort(toggle ? 255 : 1536);
		bfWrite.WriteShort(iFlags);
		bfWrite.WriteByte(toggle ? iColor[0] : iColor2[0]);
		bfWrite.WriteByte(toggle ? iColor[1] : iColor2[1]);
		bfWrite.WriteByte(toggle ? iColor[2] : iColor2[2]);
		bfWrite.WriteByte(toggle ? iColor[3] : iColor2[3]);
	}
	EndMessage();
}

void vDrugHit(int client, int owner, int enabled)
{
	int iDrugChance = !g_bTankConfig[ST_TankType(owner)] ? g_iDrugChance[ST_TankType(owner)] : g_iDrugChance2[ST_TankType(owner)];
	if (enabled == 1 && GetRandomInt(1, iDrugChance) == 1 && bIsSurvivor(client) && !g_bDrug[client])
	{
		g_bDrug[client] = true;
		DataPack dpDataPack;
		CreateDataTimer(1.0, tTimerDrug, dpDataPack, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
		dpDataPack.WriteCell(GetClientUserId(client));
		dpDataPack.WriteCell(GetClientUserId(owner));
		dpDataPack.WriteFloat(GetEngineTime());
	}
}

bool bIsValidClient(int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client) && !IsClientInKickQueue(client);
}

public Action tTimerDrug(Handle timer, DataPack pack)
{
	pack.Reset();
	int iSurvivor = GetClientOfUserId(pack.ReadCell());
	int iTank = GetClientOfUserId(pack.ReadCell());
	float flTime = pack.ReadFloat();
	float flDrugDuration = !g_bTankConfig[ST_TankType(iTank)] ? g_flDrugDuration[ST_TankType(iTank)] : g_flDrugDuration2[ST_TankType(iTank)];
	if (iTank == 0 || iSurvivor == 0 || !IsClientInGame(iTank) || !IsClientInGame(iSurvivor) || !IsPlayerAlive(iTank) || !IsPlayerAlive(iSurvivor) || (flTime + flDrugDuration) < GetEngineTime())
	{
		g_bDrug[iSurvivor] = false;
		if (bIsSurvivor(iSurvivor))
		{
			vDrug(iSurvivor, false, g_umFadeUserMsgId, g_flDrugAngles);
		}
		return Plugin_Stop;
	}
	if (bIsSurvivor(iSurvivor))
	{
		vDrug(iSurvivor, true, g_umFadeUserMsgId, g_flDrugAngles);
	}
	return Plugin_Handled;
}