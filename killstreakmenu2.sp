#include <sourcemod>
#include <sdktools>
#include <loghelper>
#include <wstatshelper>

#pragma semicolon 1

new g_kill_stats[MAXPLAYERS+1][15];


public Plugin:myinfo =
{
	name = "Killstreak Menu",
	author = "RIPPEDnFADED",
	description = "",
	version = "2.0.0",
	url = "http://info.420blaze.me"
}

public OnPluginStart()
{
	HookEvent( "player_death", Event_PlayerDeath );
	HookEvent( "player_spawn", Event_PlayerSpawn);
}

public Action:Event_PlayerSpawn(Handle:event, const String:name[], bool:dontBroadcast)
{ 
	g_kill_stats[MAXPLAYERS][LOG_HIT_KILLS] = 0;
}

ShowfirstMenu(client)
{
	new Handle:menu = CreateMenu(firstMenuShotgun, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Select your first reward");
	AddMenuItem(menu, "M590", "M590");
	AddMenuItem(menu, "TOZ", "TOZ");
	DisplayMenu(menu, client, MENU_TIME_FOREVER);
}

public firstMenuShotgun(Handle:menu, MenuAction:action, SECclient, weapon)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			//SECclient is client, weapon is item chosen
			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));
			
			if (StrEqual(item, "M590"))
			{
				GivePlayerItem(param1, "weapon_m590");
				new prWeapon = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", prWeapon);
		}
	}
}
