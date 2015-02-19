#pragma semicolon 1
#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#define PLUGIN_VERSION 	"1.00"
#define SECURITY 2
#define INSURGENT 3
#include <core>

/* ChangeLog
1.00	Created
*/

public Plugin:myinfo =
{
	name = "RoundTriggers",
	author = "MCXI",
	description = "Triggers events at roundstart/end.",
	version = PLUGIN_VERSION,
	url = "http://Info.420Blaze.Me"
};

public OnPluginStart() 
{
	HookEvent("round_start", Event_RoundStart);
	HookEvent("round_end", Event_RoundEnd);
	HookEvent("player_spawn", Event_PlayerSpawn);
	PrecacheModel("models/characters/civilian_vip.mdl", true);
}

public Event_RoundStart(Handle:event, const String:name[], bool:dontBroadcast) 
{
	ServerCommand("exec roundstart.cfg");
}

public Event_RoundEnd(Handle:event, const String:name[], bool:dontBroadcast) 
{
	ServerCommand("exec roundend.cfg");
}

stock Float:GetMaxSpeed(client)
{
    return GetEntPropFloat(client, Prop_Send, "m_flFriction");
}


public Event_PlayerSpawn(Handle:event, const String:name[], bool:dontBroadcast) 
{
		new currTeam = GetEventInt(event, "team");
		new client = GetClientOfUserId(GetEventInt(event,"userid"));
		
		if (client && currTeam !=SECURITY)
		{
			new clientz = GetEventInt(event, "userid");
			new Client = GetClientOfUserId(GetEventInt(event,"userid"));
			new Float:etime = GetEngineTime();
			new seed = RoundFloat((etime-RoundToZero(etime))*1000000)+GetTime();
			SetRandomSeed(seed);
			ServerCommand("sm_teleport #%i %i", clientz, GetRandomInt(11,20));
			SetEntityModel(client, "models/characters/civilian_vip.mdl");

			if(GetPlayerWeaponSlot(Client, 0) != -1) RemovePlayerItem(Client, GetPlayerWeaponSlot(Client, 0));
			if(GetPlayerWeaponSlot(Client, 1) != -1) RemovePlayerItem(Client, GetPlayerWeaponSlot(Client, 1));
			if(GetPlayerWeaponSlot(Client, 3) != -1) RemovePlayerItem(Client, GetPlayerWeaponSlot(Client, 3));
			if(GetPlayerWeaponSlot(Client, 4) != -1) RemovePlayerItem(Client, GetPlayerWeaponSlot(Client, 4));
			if(GetPlayerWeaponSlot(Client, 5) != -1) RemovePlayerItem(Client, GetPlayerWeaponSlot(Client, 5));
			new knife = GetPlayerWeaponSlot(client, 2);
			SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", knife);
			SetEntProp(client, Prop_Data, "m_iMaxHealth", 200);
			SetEntProp(client, Prop_Send, "m_iHealth", 200);
			SetEntProp(client, Prop_Send, "m_flMaxspeed", 1.0);
			SetEntProp(client, Prop_Send, "m_flFriction", 0.0);
		}
		
		else if (client && currTeam !=INSURGENT)
		{	
			new clientz = GetEventInt(event, "userid");
			new Float:etime = GetEngineTime();
			new seed2 = RoundFloat((etime-RoundToZero(etime))*1000000)+GetTime();
			SetRandomSeed(seed2);
			ServerCommand("sm_teleport #%i %i", clientz, GetRandomInt(1,10));
		}
}
