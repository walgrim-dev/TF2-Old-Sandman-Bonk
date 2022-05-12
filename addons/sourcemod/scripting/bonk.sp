#pragma semicolon 1

#include <clients>
#include <sdkhooks>
#include <tf2>
#pragma newdecls required

public Plugin myinfo =
{
	name        = "[TF2] Bonk",
	author      = "Walgrim",
	description = "Bonk is back on Sandman",
	version     = "1.0",
	url         = "http://steamcommunity.com/id/walgrim/"
};

public void OnClientPutInServer(int client)
{
	if (IsEntityConnectedAClient(client))
	{
		SDKHook(client, SDKHook_OnTakeDamage, OnClientTakeDamage);
	}
}

public Action OnClientTakeDamage(int victim, int& attacker, int& inflictor, float& damage, int& damagetype, int& weapon, float damageForce[3], float damagePosition[3])
{
	int wepIndex = (IsValidEntity(weapon) && weapon > MaxClients ? GetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex") : -1);
	if (wepIndex == 44)
	{
		float attackerOrigin[3];
		float victimOrigin[3];
		float distance[3];
		float finalDistance;
		GetClientAbsOrigin(attacker, attackerOrigin);
		GetClientAbsOrigin(victim, victimOrigin);
		MakeVectorFromPoints(attackerOrigin, victimOrigin, distance);
		finalDistance = GetVectorLength(distance);
		// Apply Bonk
		if (finalDistance >= 128.0 && finalDistance < 256.0)
		{
			TF2_StunPlayer(victim, 1.0, 0.0, TF_STUNFLAGS_SMALLBONK, attacker);
		}
		else if (finalDistance >= 256.0 && finalDistance < 512.0) {
			TF2_StunPlayer(victim, 2.0, 0.0, TF_STUNFLAGS_SMALLBONK, attacker);
		}
		else if (finalDistance >= 512.0 && finalDistance < 768.0) {
			TF2_StunPlayer(victim, 3.0, 0.0, TF_STUNFLAGS_SMALLBONK, attacker);
		}
		else if (finalDistance >= 768.0 && finalDistance < 1024.0) {
			TF2_StunPlayer(victim, 4.0, 0.0, TF_STUNFLAGS_SMALLBONK, attacker);
		}
		else if (finalDistance >= 1024.0 && finalDistance < 1280.0) {
			TF2_StunPlayer(victim, 5.0, 0.0, TF_STUNFLAGS_SMALLBONK, attacker);
		}
		else if (finalDistance >= 1280.0 && finalDistance < 1536.0) {
			TF2_StunPlayer(victim, 6.0, 0.0, TF_STUNFLAGS_SMALLBONK, attacker);
		}
		else if (finalDistance >= 1536.0 && finalDistance < 1792.0) {
			TF2_StunPlayer(victim, 7.0, 0.0, TF_STUNFLAGS_SMALLBONK, attacker);
		}
		else if (finalDistance >= 1792.0) {
			TF2_StunPlayer(victim, 7.0, 0.0, TF_STUNFLAGS_BIGBONK, attacker);
		}
	}
	return Plugin_Changed;
}

bool IsEntityConnectedAClient(int client)
{
	if (IsClientInGame(client) && 0 < client <= MaxClients)
	{
		return true;
	}
	return false;
}