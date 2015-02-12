#include <sourcemod>
#include <sdktools>
#include <loghelper>
#include <wstatshelper>

#pragma semicolon 1
#define PLUGIN_VERSION	"1.0"
#define PLUGIN_AUTHOR	"RIPPEDnFADED"
//#define MAX_DEFINABLE_WEAPONS 100
#define headshot	"quake/headshot.wav"
#define monsterkill "quake/monsterkill.wav"
#define ludacriskill "quake/ludacriskill.wav"
#define holyshit "quake/holyshit.wav"
#define unstoppable "quake/unstoppable.wav"
#define rampage "quake/rampage.wav"
#define godlike "quake/godlike.wav"
#define dominating "quake/dominating.wav"
#define combowhore "quake/combowhore.wav"

new g_kill_stats[MAXPLAYERS+1][15];
//new g_client_last_weapon[MAXPLAYERS+1] = {-1, ...};


public Plugin:myinfo = 
{
	name = "UT4 Sounds",
	author = PLUGIN_AUTHOR,
	description = "Unreal Tournament Sound Effects",
	version = PLUGIN_VERSION,
	url = "info.420blaze.me"
};
public OnPluginStart()
{
	HookEvent( "player_death", Event_PlayerDeath );
	HookEvent( "player_hurt", Event_PlayerHurt );
	CreateConVar("sm_headshot", PLUGIN_VERSION, "UT4 Sounds", FCVAR_PLUGIN | FCVAR_SPONLY | FCVAR_REPLICATED | FCVAR_NOTIFY );
}
public OnMapStart() 
{	
	AddFileToDownloadsTable("sound/quake/headshot.wav");
	AddFileToDownloadsTable("sound/quake/monsterkill.wav");
	AddFileToDownloadsTable("sound/quake/ludacriskill.wav");
	AddFileToDownloadsTable("sound/quake/holyshit.wav");
	AddFileToDownloadsTable("sound/quake/unstoppable.wav");
	AddFileToDownloadsTable("sound/quake/rampage.wav");
	AddFileToDownloadsTable("sound/quake/dominating.wav");
	AddFileToDownloadsTable("sound/quake/godlike.wav");
	AddFileToDownloadsTable("sound/quake/combowhore.wav");
	PrecacheSound( headshot, true );
	PrecacheSound( monsterkill, true );
	PrecacheSound( ludacriskill, true );
	PrecacheSound( holyshit, true );
	PrecacheSound( unstoppable, true );
	PrecacheSound( rampage, true );
	PrecacheSound( dominating, true );
	PrecacheSound( godlike, true );
	PrecacheSound( combowhore, true );
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
		EmitSoundToClient (attacker, monsterkill, SOUND_FROM_PLAYER, SNDCHAN_STATIC);
		PrintToChatAll ("\x05 5 kills by %N, MONSTER KILL", GetClientOfUserId(GetEventInt(event, "attacker")));
	}
	
	if (killcount == 10)
	{
		EmitSoundToClient (attacker, ludacriskill, SOUND_FROM_PLAYER, SNDCHAN_STATIC);
		PrintToChatAll ("\x05 10 kills by %N, LUDICROUS KILL", GetClientOfUserId(GetEventInt(event, "attacker")));
	}
	
	if (killcount == 15)
	{
		EmitSoundToClient (attacker, holyshit, SOUND_FROM_PLAYER, SNDCHAN_STATIC);
		PrintToChatAll ("\x05 15 kills by %N, HOLY SHIT", GetClientOfUserId(GetEventInt(event, "attacker")));
	}
	
	if (killcount == 20)
	{
		EmitSoundToAll (rampage);
		PrintToChatAll ("\x05 20 kills by %N, RAMPAGE", GetClientOfUserId(GetEventInt(event, "attacker")));
	}
	
	if (killcount == 25)
	{
		EmitSoundToAll (unstoppable);
		PrintToChatAll ("\x05 25 kills by %N, UNSTOPPABLE", GetClientOfUserId(GetEventInt(event, "attacker")));
	}

	g_kill_stats[victim][LOG_HIT_KILLS] = 0;
	g_kill_stats[victim][LOG_HIT_HEADSHOTS] = 0;
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
			g_kill_stats[attacker][LOG_HIT_HEADSHOTS]++;
			new gHeadshots = g_kill_stats[attacker][LOG_HIT_HEADSHOTS];
			gHeadshots++;
			EmitSoundToClient (attacker, headshot, SOUND_FROM_PLAYER, SNDCHAN_STATIC);
			PrintToChatAll("\x04 A glorious headshot by %N",  GetClientOfUserId(GetEventInt(event, "attacker")));
			
				if (gHeadshots == 5)
				{
					EmitSoundToClient (attacker, dominating, SOUND_FROM_PLAYER, SNDCHAN_STATIC);
					PrintToChatAll ("\x05 5 Headshots by %N, DOMINATING", GetClientOfUserId(GetEventInt(event, "attacker")));
				}
	
				if (gHeadshots == 10)
				{
					EmitSoundToClient (attacker, godlike, SOUND_FROM_PLAYER, SNDCHAN_STATIC);
					PrintToChatAll ("\x05 10 headshots by %N, GODLIKE", GetClientOfUserId(GetEventInt(event, "attacker")));
				}
	
				if (gHeadshots == 15)
				{
					EmitSoundToAll (combowhore);
					PrintToChatAll ("\x05 15 headshots by %N, COMBOWHORE", GetClientOfUserId(GetEventInt(event, "attacker")));
				}
		}
	}
	return Plugin_Continue;
}