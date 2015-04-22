#pragma semicolon 1
#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <smlib/clients>
#define PLUGIN_VERSION 	"1.00"
#include <core>
#include <advanced_motd>

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
	HookEvent("player_hurt", Event_PlayerHurt);
	HookEvent("player_disconnect", event_PlayerDisconnect, EventHookMode_Pre);
	PrecacheModel("models/characters/civilian_vip.mdl", true);
	RegConsoleCmd("sm_ghost", Ghost);
	RegConsoleCmd("sm_unghost", UnGhost);
	RegConsoleCmd("sm_info", Info);
	RegConsoleCmd("sm_doug", Me);
	CreateTimer( 100.0, CheckRestart, 0, TIMER_REPEAT );
}

public OnMapStart()
{
ServerCommand("ins_bot_add_t2");
}

public Action:CheckRestart( Handle:timer, any:ignore ) 
{
	for( new i = 1; i <= MaxClients; i++ ) {
		if( IsClientConnected( i ) && !IsFakeClient( i ) ) {
			return;
		}
	}

	// All good
	LogMessage( "Restarting..." );
	PrintToServer( "Restarting..." );
	ServerCommand( "quit" );
}

public Action:event_PlayerDisconnect(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	
	if( client && !IsFakeClient(client) && !dontBroadcast )
	{
		decl String:szText[128];
		decl String:szName[32];
		GetClientName(client, szName, sizeof(szName)-1);
		new String:reason[64];
		GetEventString(event, "reason", reason, sizeof(reason));
	
		Format(szText, sizeof(szText)-1, "%s has disconnected! ** %s **", szName, reason);
	
		PrintToChatAll(szText);
		PrintToServer(szText);
	}
}

public Event_RoundStart(Handle:event, const String:name[], bool:dontBroadcast) 
{
	ServerCommand("exec roundstart.cfg");	
}

public Event_RoundEnd(Handle:event, const String:name[], bool:dontBroadcast) 
{
	new client = GetClientOfUserId(GetEventInt(event,"userid"));
	
		decl String:classname[128];
		GetEdictClassname(client, classname, sizeof(classname));
	
		if (StrEqual(classname, "turned"))
		{
		DispatchKeyValue(client, "teamnumber","2");
		SetEntityModel(client, "models/characters/civilian_vip_02.mdl");
		DispatchKeyValue(client, "classname","playa");
		}
		
		ServerCommand("exec roundend.cfg");
}

public Event_PlayerHurt(Handle:event, const String:name[], bool:dontBroadcast) 
{
		new client = GetClientOfUserId(GetEventInt(event,"userid"));

	if(IsClientInGame(client) && GetClientTeam(client) == 2)
	{
		new attacker = GetClientOfUserId(GetEventInt(event, "attacker"));
		if (attacker >= 1)
		{
		PerformTrans(client);
		}
		else
		{
		PrintToChat(client, "Stop hurting yourself!");
		}
	}
}

PerformTrans(client)
{
	new health = GetEntProp(client, Prop_Data, "m_iHealth");
	
		if(health >= 30)
		{
		PerformTrans2(client);
		}
}

PerformTrans2(client)
{
	new numb = GetRandomInt(0,9);
		
		if(numb >= 9)
		{
		PerformTrans3(client);
		}
}

PerformTrans3(client)
{
	decl String:classname[128];
	GetEdictClassname(client, classname, sizeof(classname));
	
		if(StrEqual(classname, "playa"))
			{
			GhostLaunch(client);
			}
		if(StrEqual(classname, "doug"))
			{
			GhostLaunch(client);
			}
		else
			{
			PrintToServer("conflict avoided");
			SetEntProp(client, Prop_Data, "m_iMaxHealth", 0);
			SetEntProp(client, Prop_Send, "m_iHealth", 0);
			}
}

public Event_PlayerSpawn(Handle:event, const String:name[], bool:dontBroadcast) 
{
		new client = GetClientOfUserId(GetEventInt(event,"userid"));
		decl String:classname[128];
		GetEdictClassname(client, classname, sizeof(classname));
	
		if (StrEqual(classname, "turned"))
		{
		DispatchKeyValue(client, "teamnumber","2");
		SetEntityModel(client, "models/characters/civilian_vip_02.mdl");
		DispatchKeyValue(client, "classname","playa");
		PerformSpawny(client);
		}
		else 
		{
		PerformSpawny(client);
		}
}

PerformSpawny(client)
{
		if(IsClientInGame(client) && GetClientTeam(client) == 2)
		{	
			SetEntProp(client, Prop_Data, "m_iMaxHealth", 125);
			SetEntProp(client, Prop_Send, "m_iHealth", 125);
			SetEntProp(client, Prop_Data, "m_takedamage", 2, 1);
			DispatchKeyValue(client, "targetname", "playa");
			DispatchKeyValue(client, "classname", "playa");
			SetEntityRenderMode(client, RENDER_NORMAL);
			SetEntityRenderColor(client, 255, 255, 255, 255);
			CreateTimer(0.10, TeleportS, client);
		}
		else
		{
			FakeClientCommand(client, "jointeam 3");
			SetEntityModel(client, "models/characters/civilian_vip.mdl");
			Client_RemoveAllWeapons(client, "weapon_kabar", true);
			new knife = GetPlayerWeaponSlot(client, 2);
			SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", knife);
			SetEntProp(client, Prop_Data, "m_takedamage", 2, 1);
			SetEntProp(client, Prop_Data, "m_iMaxHealth", 500);
			SetEntProp(client, Prop_Send, "m_iHealth", 500);
			SetEntityRenderMode(client, RENDER_NORMAL);
			SetEntityRenderColor(client, 255, 255, 255, 255);
			SetEntityRenderMode(client, RENDER_TRANSADD);
			SetEntityRenderColor(client, 0, 255, 0, 150);
			DispatchKeyValue(client, "targetname", "bot");
			DispatchKeyValue(client, "classname", "bot");
			CreateTimer(0.10, TeleportI, client);
		}
}
		
public Action:TeleportS(Handle:timer, any:client)
{
			TeleportPlayerS(client);
}

public Action:TeleportI(Handle:timer, any:client)
{
			AcceptEntityInput(client, "DisableShadow");
			AcceptEntityInput(client, "DisableDrawInFastReflection");
			AcceptEntityInput(client, "IgniteLifetime 666");
			AcceptEntityInput(client, "DisableReceivingFlashlight");
			TeleportPlayerI(client);
			new knife = GetPlayerWeaponSlot(client, 2);
			AcceptEntityInput(knife, "DisableDraw");
}

TeleportPlayerS(client)
{
		new Float:etime = GetEngineTime();
		new seed = RoundFloat((etime-RoundToZero(etime))*1000000)+GetTime();
		SetRandomSeed(seed);
		new numbs = GetRandomInt(0,9);

		if(numbs == 0)
		{
			new Float:origin[3];
			origin[0] = 1228.0;
			origin[1] = -2227.0;
			origin[2] = -152.0;
			
			new Float:angle[3];
			angle[0] = 25.0;
			angle[1] = -85.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
		
		if(numbs == 1)
		{
			new Float:origin[3];
			origin[0] = 1482.0;
			origin[1] = -2206.0;
			origin[2] = 10.0;
			
			new Float:angle[3];
			angle[0] = 2.0;
			angle[1] = 160.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
		
		if(numbs == 2)
		{
			new Float:origin[3];
			origin[0] = 1922.0;
			origin[1] = -4294.0;
			origin[2] = 0.0;
			
			new Float:angle[3];
			angle[0] = 1.0;
			angle[1] = 137.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
		if(numbs == 3)
		{
			new Float:origin[3];
			origin[0] = 926.0;
			origin[1] = -4009.0;
			origin[2] = 199.0;
			
			new Float:angle[3];
			angle[0] = 45.0;
			angle[1] = 23.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
		
		if(numbs == 4)
		{
			new Float:origin[3];
			origin[0] = 1860.0;
			origin[1] = -625.0;
			origin[2] = 260.0;
			
			new Float:angle[3];
			angle[0] = 5.0;
			angle[1] = 63.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
		if(numbs == 5)
		{
			new Float:origin[3];
			origin[0] = 2617.0;
			origin[1] = -2587.0;
			origin[2] = 10.0;
			
			new Float:angle[3];
			angle[0] = 1.0;
			angle[1] = -179.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
		
		if(numbs == 6)
		{
			new Float:origin[3];
			origin[0] = 2820.0;
			origin[1] = -578.0;
			origin[2] = 40.0;
			
			new Float:angle[3];
			angle[0] = 4.0;
			angle[1] = 179.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
				
		if(numbs == 7)
		{
			new Float:origin[3];
			origin[0] = 2245.0;
			origin[1] = -410.0;
			origin[2] = -305.0;
			
			new Float:angle[3];
			angle[0] = 3.0;
			angle[1] = -171.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
		if(numbs == 8)
		{
			new Float:origin[3];
			origin[0] = 521.0;
			origin[1] = 442.0;
			origin[2] = 178.0;
			
			new Float:angle[3];
			angle[0] = 11.0;
			angle[1] = -18.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
		if(numbs == 9)
		{
			new Float:origin[3];
			origin[0] = 4821.0;
			origin[1] = -702.0;
			origin[2] = 10.0;
			
			new Float:angle[3];
			angle[0] = -4.0;
			angle[1] = 171.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
}

TeleportPlayerI(client)
{
		new Float:etime = GetEngineTime();
		new seed = RoundFloat((etime-RoundToZero(etime))*1000000)+GetTime();
		SetRandomSeed(seed);
		new numbs = GetRandomInt(0,9);

		if(numbs == 0)
		{
			new Float:origin[3];
			origin[0] = -1543.0;
			origin[1] = -2437.0;
			origin[2] = -300.0;
			
			new Float:angle[3];
			angle[0] = 8.0;
			angle[1] = 75.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
		
		if(numbs == 1)
		{
			new Float:origin[3];
			origin[0] = -1482.0;
			origin[1] = -2206.0;
			origin[2] = 10.0;
			
			new Float:angle[3];
			angle[0] = 8.0;
			angle[1] = 12.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
		
		if(numbs == 2)
		{
			new Float:origin[3];
			origin[0] = -1922.0;
			origin[1] = -4294.0;
			origin[2] = 0.0;
			
			new Float:angle[3];
			angle[0] = 12.0;
			angle[1] = 29.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
		if(numbs == 3)
		{
			new Float:origin[3];
			origin[0] = -920.0;
			origin[1] = -3963.0;
			origin[2] = 199.0;
			
			new Float:angle[3];
			angle[0] = 43.0;
			angle[1] = 11.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
		
		if(numbs == 4)
		{
			new Float:origin[3];
			origin[0] = -1860.0;
			origin[1] = -625.0;
			origin[2] = 260.0;
			
			new Float:angle[3];
			angle[0] = 7.0;
			angle[1] = 121.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
		if(numbs == 5)
		{
			new Float:origin[3];
			origin[0] = -2617.0;
			origin[1] = -2587.0;
			origin[2] = 10.0;
			
			new Float:angle[3];
			angle[0] = 4.0;
			angle[1] = -2.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
		
		if(numbs == 6)
		{
			new Float:origin[3];
			origin[0] = -2820.0;
			origin[1] = -578.0;
			origin[2] = 40.0;
			
			new Float:angle[3];
			angle[0] = 10.0;
			angle[1] = -3.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
				
		if(numbs == 7)
		{
			new Float:origin[3];
			origin[0] = -2245.0;
			origin[1] = -410.0;
			origin[2] = -305.0;
			
			new Float:angle[3];
			angle[0] = 10.0;
			angle[1] = -12.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
		if(numbs == 8)
		{
			new Float:origin[3];
			origin[0] = -521.0;
			origin[1] = 442.0;
			origin[2] = 178.0;
			
			new Float:angle[3];
			angle[0] = 16.0;
			angle[1] = 174.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
		if(numbs == 9)
		{
			new Float:origin[3];
			origin[0] = -4821.0;
			origin[1] = -702.0;
			origin[2] = 10.0;
			
			new Float:angle[3];
			angle[0] = 4.0;
			angle[1] = -18.0;
			angle[2] = 0.0;
			
			TeleportEntity(client, origin, angle, NULL_VECTOR);
		}
}

GhostLaunch(client)
{
			new health = GetEntProp(client, Prop_Data, "m_iHealth");
	
			if(health >= 30)
			{
			Client_Shake(client, SHAKE_START, 540.0, 150.0, 1.0);
			Client_ScreenFade(client, 720, FFADE_PURGE|FFADE_MODULATE, 30, 0, 255, 0);
			PrintHintText(client, "YOU HAVE TURNED INTO A GHOST");
			DispatchKeyValue(client, "teamnumber","3");
			DispatchKeyValue(client, "classname","turned");
			DispatchKeyValue(client, "targetname","turned");
			SetEntityModel(client, "models/characters/civilian_vip.mdl");
			Client_RemoveAllWeapons(client, "weapon_kabar", true);
			new knife = GetPlayerWeaponSlot(client, 2);
			SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", knife);
			SetEntProp(client, Prop_Data, "m_takedamage", 2, 1);
			SetEntProp(client, Prop_Data, "m_iMaxHealth", 500);
			SetEntProp(client, Prop_Send, "m_iHealth", 500);
			SetEntityRenderMode(client, RENDER_NORMAL);
			SetEntityRenderColor(client, 255, 255, 255, 255);
			SetEntityRenderMode(client, RENDER_TRANSADD);
			SetEntityRenderColor(client, 0, 255, 0, 150);
			PrintHintText(client, "YOU HAVE TURNED INTO A GHOST");
			}
			else
			{
			PrintToServer("conflict avoided");
			SetEntProp(client, Prop_Data, "m_iMaxHealth", 0);
			SetEntProp(client, Prop_Send, "m_iHealth", 0);
			}
}

UnGhostLaunch(client)
{
		decl String:classname[128];
		GetEdictClassname(client, classname, sizeof(classname));
	
		if (StrEqual(classname, "turned"))
		{
		DispatchKeyValue(client, "teamnumber","2");
		SetEntityModel(client, "models/characters/civilian_vip_02.mdl");
		SetEntProp(client, Prop_Data, "m_iMaxHealth", 125);
		SetEntProp(client, Prop_Send, "m_iHealth", 125);
		SetEntProp(client, Prop_Data, "m_takedamage", 2, 1);
		DispatchKeyValue(client, "targetname", "playa");
		DispatchKeyValue(client, "classname", "playa");
		SetEntityRenderMode(client, RENDER_NORMAL);
		SetEntityRenderColor(client, 255, 255, 255, 255);
		FakeClientCommand(client, "sm_menu");
		}
		else
		{
		PrintToChat(client, "You aren't a ghost!");
		}
}


public Action:Ghost(client, args)
{
	PerformTrans3(client);
}

public Action:UnGhost(client, args)
{
	UnGhostLaunch(client);
}

public Action:Me(client, args)
{
	DispatchKeyValue(client, "targetname", "doug");
	DispatchKeyValue(client, "classname", "doug");
}

public Action:Info(client, args)
{
	new Float:origin[3];
	origin[0] = 1905.0;
	origin[1] = -2009.0;
	origin[2] = 225.0;
			
	new Float:angle[3];
	angle[0] = -29.0;
	angle[1] = -179.0;
	angle[2] = 0.0;
			
	TeleportEntity(client, origin, angle, NULL_VECTOR);
			
	PrintHintText(client, "Loading....");
    AdvMOTD_ShowMOTDPanel(client, "420Blaz.in", "http://420Blaz.in", MOTDPANEL_TYPE_URL, true, false, true, OnMOTDFailure); 
	
	//Client_Shake(client, SHAKE_START, 20.0, 150.0, 2.0);
	Client_ScreenFade(client, 3000, FFADE_PURGE|FFADE_MODULATE, 0, 0, 0, 30);
    return Plugin_Handled; 
} 

public OnMOTDFailure(client, MOTDFailureReason:reason) { 
    if(reason == MOTDFailure_Disabled) { 
        PrintToChat(client, "[SM] You have HTML MOTDs disabled."); 
    } else if(reason == MOTDFailure_Matchmaking) { 
        PrintToChat(client, "[SM] You cannot view HTML MOTDs because you joined via Quickplay."); 
    } else if(reason == MOTDFailure_QueryFailed) { 
        PrintToChat(client, "[SM] Unable to verify that you can view HTML MOTDs."); 
    } else { 
        PrintToChat(client, "[SM] Unable to verify that you can view HTML MOTDs for an unknown reason."); 
    } 
} 
