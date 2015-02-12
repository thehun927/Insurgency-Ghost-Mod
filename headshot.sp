#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#define PLUGIN_VERSION	"1.0"
#define PLUGIN_AUTHOR	"thehun927"
#define headshot	"headshot.wav"
#define:gHeadshot = (GetClientHealth(victim) <= 0 && hitgroup == HITGROUP_HEAD);

//new Handle:g_cvar_headshots = INVALID_HANDLE;
//new Handle:gPluginEnabled;

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
	CreateConVar("sm_headshot", PLUGIN_VERSION, "HeadShot sounds", FCVAR_PLUGIN | FCVAR_SPONLY | FCVAR_REPLICATED | FCVAR_NOTIFY );
	gPluginEnabled = CreateConVar( "sm_headshot", "1" );
}
public OnMapStart() 
{
	PrecacheSound( headshot, true );
}
public Action:Event_PlayerDeath( Handle:event, const String:name[], bool:dontBroadcast )
{
	if( GetConVarInt( gPluginEnabled ) == 1 )
	{
		new victim = GetClientOfUserId( GetEventInt( event, "userid" ) );
		new attacker = GetClientOfUserId( GetEventInt( event, "attacker" ) );
		EmitSoundToAll( headshot );
		
		if( victim == attacker )
		{
			return Plugin_Handled;
		}
				
		if ( gHeadshot )
		{
			EmitSoundToAll( headshot );
		}
	}
	return Plugin_Continue;
}
