#include <sourcemod>
#include <sdktools>
#include <regex>
#include <loghelper>
#include <wstatshelper>

#pragma semicolon 1
#define PLUGIN_VERSION	"1.0"
#define PLUGIN_AUTHOR	"thehun927"
//#define MAX_DEFINABLE_WEAPONS 100
#define headshot	"quake/headshot.wav"
#define monsterkill "quake/monsterkill.wav"
#define ludacriskill "quake/ludacriskill.wav"
#define holyshit "quake/holyshit.wav"

new g_kill_stats[MAXPLAYERS+1][15];
//new g_client_last_weapon[MAXPLAYERS+1] = {-1, ...};


public Plugin:myinfo = 
{
	name = "HeadShot sounds",
	author = PLUGIN_AUTHOR,
	description = "Headshot Sound Effect.",
	version = PLUGIN_VERSION,
	url = "info.420blaze.me"
};
public OnPluginStart()
{
	HookEvent( "player_death", Event_PlayerDeath );
	HookEvent( "player_hurt", Event_PlayerHurt );
	CreateConVar("sm_headshot", PLUGIN_VERSION, "HeadShot sounds", FCVAR_PLUGIN | FCVAR_SPONLY | FCVAR_REPLICATED | FCVAR_NOTIFY );
}
public OnMapStart() 
{	
	AddFileToDownloadsTable("sound/quake/headshot.wav");
	AddFileToDownloadsTable("sound/quake/monsterkill.wav");
	AddFileToDownloadsTable("sound/quake/ludacriskill.wav");
	AddFileToDownloadsTable("sound/quake/holyshit.wav");
	PrecacheSound( headshot, true );
	PrecacheSound( monsterkill, true );
	PrecacheSound( ludacriskill, true );
	PrecacheSound( holyshit, true );
}
public Action:Event_PlayerDeath(Handle:event, const String:name[], bool:dontBroadcast)
{
	new victim   = GetClientOfUserId(GetEventInt(event, "userid"));
	new attacker = GetClientOfUserId(GetEventInt(event, "attacker"));
	//decl String:weapon[32];
	//GetEventString(event, "weapon", weapon, sizeof(weapon));
	
	g_kill_stats[attacker][LOG_HIT_KILLS]++;
	g_kill_stats[victim][LOG_HIT_DEATHS]++;
	
	new killcount = g_kill_stats[attacker][LOG_HIT_KILLS];
	
	if (killcount == 5)
	{
		EmitSoundToAll (monsterkill);
		PrintToChatAll ("5 kills by %s", attacker);
	}
	
	if (killcount == 10)
	{
		EmitSoundToAll (ludacriskill);
		PrintToChatAll ("10 kills by %s", attacker);
	}
	
	if (killcount == 15)
	{
		EmitSoundToAll (holyshit);
		PrintToChatAll ("15 kills by %s", attacker);
	}
	g_kill_stats[victim][LOG_HIT_KILLS] = 0;
}
public Action:Event_PlayerHurt(Handle:event, const String:name[], bool:dontBroadcast)
{
	new victim   = GetClientOfUserId(GetEventInt(event, "userid"));
	new attacker = GetClientOfUserId(GetEventInt(event, "attacker"));
	//PrintToServer("[LOGGER] PlayerHurt attacher %d victim %d weapon %s ghws: %s", attacker, victim, weapon,g_client_hurt_weaponstring[victim]);
	if (attacker > 0 && attacker != victim)
	{
		new hitgroup  = GetEventInt(event, "hitgroup");
		if (hitgroup < 8)
		{
			hitgroup += LOG_HIT_OFFSET;
		}
		if (hitgroup == (HITGROUP_HEAD+LOG_HIT_OFFSET))
		{
			LogPlayerEvent(attacker, "triggered", "headshot");
			EmitSoundToAll (headshot);
			PrintToChatAll("A glorious headshot by %s", attacker);
		}
	}
	return Plugin_Continue;
}