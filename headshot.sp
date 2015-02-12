#include <sourcemod>
#include <sdktools>
#include <regex>
#include <loghelper>
#include <wstatshelper>

#pragma semicolon 1
#define PLUGIN_VERSION	"1.0"
#define PLUGIN_AUTHOR	"thehun927"
#define headshot	"headshot.wav"

new Handle:g_cvar_headshots = INVALID_HANDLE;
new Handle:gPluginEnabled;

new bool:g_logheadshots = true;

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
	HookEvent( "player_hurt", Event_PlayerHurt );
	CreateConVar("sm_headshot", PLUGIN_VERSION, "HeadShot sounds", FCVAR_PLUGIN | FCVAR_SPONLY | FCVAR_REPLICATED | FCVAR_NOTIFY );
	gPluginEnabled = CreateConVar( "sm_headshot", "1" );
}
public OnMapStart() 
{
	PrecacheSound( headshot, true );
}
/*public Action:Event_PlayerDeath( Handle:event, const String:name[], bool:dontBroadcast )
{
	if( GetConVarInt( gPluginEnabled ) == 1 )
	{
		new victim = GetClientOfUserId( GetEventInt( event, "userid" ) );
		new attacker = GetClientOfUserId( GetEventInt( event, "attacker" ) );
		//EmitSoundToAll( headshot );
		
		if( victim == attacker )
		{
			return Plugin_Handled;
		}
				
		if ( GetEventBool( event, "headshot" ) )
		{
			EmitSoundToAll( headshot );
		}
	}
	return Plugin_Continue;
}*/
public Action:Event_PlayerHurt(Handle:event, const String:name[], bool:dontBroadcast)
{
	new victim   = GetClientOfUserId(GetEventInt(event, "victim"));
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
		}
	}
	return Plugin_Continue;
}