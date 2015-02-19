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
	
	new index = CreateEntityByName("weapon_at4");
	new Float:origin[3];
	origin[0] = 1421.0;
	origin[1] = -2453.0;
	origin[2] = -280.0;
	
	DispatchSpawn(index);
	TeleportEntity(index, origin, NULL_VECTOR, NULL_VECTOR);
}

public Event_RoundEnd(Handle:event, const String:name[], bool:dontBroadcast) 
{
	ServerCommand("exec roundend.cfg");
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
			SetEntProp(client, Prop_Data, "m_iMaxHealth", 150);
			SetEntProp(client, Prop_Send, "m_iHealth", 150);
			SetEntProp(client, Prop_Send, "m_flMaxspeed", 1.0);
			SetEntProp(client, Prop_Send, "m_flFriction", 0.0);
		}
		
		else if (client && currTeam !=INSURGENT)
		{	
			new clientz = GetEventInt(event, "userid");
			new Client = GetClientOfUserId(GetEventInt(event,"userid"));
			new Float:etime = GetEngineTime();
			new seed2 = RoundFloat((etime-RoundToZero(etime))*1000000)+GetTime();
			SetRandomSeed(seed2);
			ServerCommand("sm_teleport #%i %i", clientz, GetRandomInt(1,10));
			
			if(GetPlayerWeaponSlot(Client, 0) != -1) RemovePlayerItem(Client, GetPlayerWeaponSlot(Client, 0));
			if(GetPlayerWeaponSlot(Client, 3) != -1) RemovePlayerItem(Client, GetPlayerWeaponSlot(Client, 3));
			if(GetPlayerWeaponSlot(Client, 4) != -1) RemovePlayerItem(Client, GetPlayerWeaponSlot(Client, 4));
			if(GetPlayerWeaponSlot(Client, 5) != -1) RemovePlayerItem(Client, GetPlayerWeaponSlot(Client, 5));
			GivePlayerItem(client, "weapon_kabar");
			GivePlayerItem(client, "weapon_m9");
			new pistol = GetPlayerWeaponSlot(client, 1);
			SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", pistol);
			
			//Attila's Additions
			SetConVarFlags(FindConVar("sv_cheats"), GetConVarFlags(FindConVar("sv_cheats")) & ~FCVAR_NOTIFY);
			SetConVarBool(FindConVar("sv_cheats"), true, false, false);
			FakeClientCommand(client, "give_ammo 8");	
			SetConVarBool(FindConVar("sv_cheats"), false, false, false);
			
			//SetEntProp(pistol, Prop_Data, "m_iClip1", 99);
			//SetEntProp(pistol, Prop_Data, "m_iPrimaryAmmoCount", 99);
			SetEntProp(client, Prop_Data, "m_iMaxHealth", 125);
			SetEntProp(client, Prop_Send, "m_iHealth", 125);
			
		}
}
