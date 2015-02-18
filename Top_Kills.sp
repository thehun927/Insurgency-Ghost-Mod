#include <sourcemod>
#include <sdktools>
#include <loghelper>
#include <wstatshelper>

#pragma semicolon 1

#define PLUGIN_VERSION	"1.0"
#define PLUGIN_AUTHOR	"RIPPEDnFADED"

new g_kill_stats[MAXPLAYERS+1][15];

public Plugin:myinfo = 
{
	name = "Top Kills",
	author = PLUGIN_AUTHOR,
	description = "Live Kill Feed for top players",
	version = PLUGIN_VERSION,
	url = "info.420blaze.me"
};

public OnPluginStart()
{
	HookEvent( "player_death", Event_PlayerDeath );
	HookEvent( "player_hurt", Event_PlayerHurt );
	CreateConVar("sm_tkills", PLUGIN_VERSION, "Top Kills", FCVAR_PLUGIN | FCVAR_SPONLY | FCVAR_REPLICATED | FCVAR_NOTIFY );
}

public Action:Event_PlayerDeath(Handle:event, const String:name[], bool:dontBroadcast)
{
	new victim   	= GetClientOfUserId(GetEventInt(event, "userid"));
	new attacker 	= GetClientOfUserId(GetEventInt(event, "attacker"));
	
	g_kill_stats[attacker][LOG_HIT_KILLS]++;
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
		}
	}
	SendChatToAll(g_kill_stats[attacker][LOG_HIT_KILLS]);
}

SendChatToAll(client, const String:message[])
{
	new String:nameBuf[MAX_NAME_LENGTH];
	
	for (new i = 1; i <= MaxClients; i++)
	{
		if (!IsClientInGame(i) || IsFakeClient(i))
		{
			continue;
		}
		FormatActivitySource(client, i, nameBuf, sizeof(nameBuf));
		
		PrintToChat(i, "\x04(ALL) %s: \x01%s", nameBuf, message);
	}
}

SendPanelToAll(String:message[])
{
	decl String:title[100];
	Format(title, 64, "%N:", from);	
	
	ReplaceString(message, 192, "\\n", "\n");
	
	new Handle:mSayPanel = CreatePanel();
	SetPanelTitle(mSayPanel, title);
	DrawPanelItem(mSayPanel, "", ITEMDRAW_SPACER);
	DrawPanelText(mSayPanel, message);
	DrawPanelItem(mSayPanel, "", ITEMDRAW_SPACER);

	SetPanelCurrentKey(mSayPanel, 10);
	DrawPanelItem(mSayPanel, "Exit", ITEMDRAW_CONTROL);

	for(new i = 1; i <= MaxClients; i++)
	{
		if(IsClientInGame(i) && !IsFakeClient(i))
		{
			SendPanelToClient(mSayPanel, i, Handler_DoNothing, 10);
		}
	}

	CloseHandle(mSayPanel);
}

public Handler_DoNothing(Handle:menu, MenuAction:action, param1, param2)
{
	/* Do nothing */
}


