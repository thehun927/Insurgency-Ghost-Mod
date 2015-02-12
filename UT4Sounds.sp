#include <sourcemod>
#include <sdktools>
#include <loghelper>
#include <wstatshelper>
#include <clientprefs>

#pragma semicolon 1

#define PLUGIN_VERSION	"1.0"
#define PLUGIN_AUTHOR	"RIPPEDnFADED"

#define headshot	"quake/headshot.wav"
#define monsterkill "quake/monsterkill.wav"
#define ludacriskill "quake/ludacriskill.wav"
#define holyshit "quake/holyshit.wav"
#define unstoppable "quake/unstoppable.wav"
#define rampage "quake/rampage.wav"
#define godlike "quake/godlike.wav"
#define dominating "quake/dominating.wav"
#define combowhore "quake/combowhore.wav"
#define multikill "quake/multikill.wav"
#define humiliation "quake/humiliation.wav"
#define killingspree "quake/killingspree.wav"
#define wickedsick "quake/wickedsick.wav"

new g_kill_stats[MAXPLAYERS+1][15];

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
	CreateConVar("sm_ut4sounds", PLUGIN_VERSION, "UT4 Sounds", FCVAR_PLUGIN | FCVAR_SPONLY | FCVAR_REPLICATED | FCVAR_NOTIFY );
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
	AddFileToDownloadsTable("sound/quake/multikill.wav");
	AddFileToDownloadsTable("sound/quake/humiliation.wav");
	AddFileToDownloadsTable("sound/quake/killingspree.wav");
	AddFileToDownloadsTable("sound/quake/wickedsick.wav");
	PrecacheSound( killingspree, true);
	PrecacheSound( wickedsick, true);
	PrecacheSound( humiliation, true);
	PrecacheSound( headshot, true );
	PrecacheSound( monsterkill, true );
	PrecacheSound( ludacriskill, true );
	PrecacheSound( holyshit, true );
	PrecacheSound( unstoppable, true );
	PrecacheSound( rampage, true );
	PrecacheSound( dominating, true );
	PrecacheSound( godlike, true );
	PrecacheSound( combowhore, true );
	PrecacheSound( multikill, true );
}

public Action:Event_PlayerDeath(Handle:event, const String:name[], bool:dontBroadcast)
{
	new victim   	= GetClientOfUserId(GetEventInt(event, "userid"));
	new attacker 	= GetClientOfUserId(GetEventInt(event, "attacker"));
	
	g_kill_stats[attacker][LOG_HIT_KILLS]++;
	g_kill_stats[victim][LOG_HIT_DEATHS]++;
	
	new killcount = g_kill_stats[attacker][LOG_HIT_KILLS];
	
	if (killcount == 5)
	{
		EmitSoundToClient (attacker, multikill, SOUND_FROM_PLAYER, SNDCHAN_STATIC);
		PrintHintTextToAll ("\%N 5 killstreak MULTIKILL", GetClientOfUserId(GetEventInt(event, "attacker")));
	}
	
	if (killcount == 10)
	{
		EmitSoundToClient (attacker, monsterkill, SOUND_FROM_PLAYER, SNDCHAN_STATIC);
		PrintHintTextToAll ("\%N is on a 10 killstreak MONSTER KILL", GetClientOfUserId(GetEventInt(event, "attacker")));
	}
	
	if (killcount == 15)
	{
		EmitSoundToClient (attacker, ludacriskill, SOUND_FROM_PLAYER, SNDCHAN_STATIC);
		PrintHintTextToAll ("%N is on a 15 killstreak, LUDICROUS KILL", GetClientOfUserId(GetEventInt(event, "attacker")));
	}
	
	if (killcount == 20)
	{
		EmitSoundToAll (holyshit);
		PrintHintTextToAll ("HOLY SHIT, %N is at a 20 killstreak", GetClientOfUserId(GetEventInt(event, "attacker")));
	}
	
	if (killcount == 25)
	{
		EmitSoundToAll (rampage);
		PrintHintTextToAll ("%N is on a RAMPAGE", GetClientOfUserId(GetEventInt(event, "attacker")));
	}
	
	if (killcount == 30)
	{
		EmitSoundToAll (unstoppable);
		PrintHintTextToAll ("30 kills, %N is UNSTOPPABLE", GetClientOfUserId(GetEventInt(event, "attacker")));
	}
	
	if (killcount == 50)
	{
		EmitSoundToAll (killingspree);
		PrintHintTextToAll ("50 kills, %N is on a Killing Spree", GetClientOfUserId(GetEventInt(event, "attacker")));
	}
	
	if (killcount == 100)
	{
		EmitSoundToAll (wickedsick);
		PrintHintTextToAll ("100 kills, %N is WICKEDSICK", GetClientOfUserId(GetEventInt(event, "attacker")));
	}
	
	if (g_kill_stats[victim][LOG_HIT_KILLS] > 10)
	{
		EmitSoundToAll (humiliation);
		PrintHintTextToAll ("%N was killed at a %d killstreak", victim, g_kill_stats[victim][LOG_HIT_KILLS]);
	}

	g_kill_stats[victim][LOG_HIT_KILLS] = 0;
	g_kill_stats[victim][LOG_HIT_HEADSHOTS] = 0;
}

public Action:Event_PlayerHurt(Handle:event, const String:name[], bool:dontBroadcast)
{
	new victim   = GetClientOfUserId(GetEventInt(event, "userid"));
	new attacker = GetClientOfUserId(GetEventInt(event, "attacker"));

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
			PrintHintTextToAll("A glorious headshot by %N",  GetClientOfUserId(GetEventInt(event, "attacker")));
			
				if (gHeadshots == 5)
				{
					EmitSoundToAll (dominating);
					PrintHintTextToAll ("5 Headshots, %N is DOMINATING", GetClientOfUserId(GetEventInt(event, "attacker")));
				}
	
				if (gHeadshots == 10)
				{
					EmitSoundToAll (godlike);
					PrintHintTextToAll ("10 headshots, %N is GODLIKE", GetClientOfUserId(GetEventInt(event, "attacker")));
				}
	
				if (gHeadshots == 15)
				{
					EmitSoundToAll (combowhore);
					PrintHintTextToAll ("%N is a combowhore with 15 headshots", GetClientOfUserId(GetEventInt(event, "attacker")));
				}
		}
	}
	return Plugin_Continue;
}

