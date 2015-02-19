#include <sourcemod>
#include <sdktools>
#include <loghelper>
#include <wstatshelper>
#include <clientprefs>
//#include <smlib>

#pragma semicolon 1

new g_kill_stats[MAXPLAYERS+1][15];


public Plugin:myinfo =
{
	name = "Killstreak Menu",
	author = "RIPPEDnFADED",
	description = "",
	version = "1.0.0",
	url = "http://info.420blaze.me"
}

public OnPluginStart()
{
	LoadTranslations("common.phrases");
	LoadTranslations("myplugin.phrases");
	HookEvent( "player_death", Event_PlayerDeath );
	RegConsoleCmd("sm_shotty", Cmd_sm_shotty);
}

public Action:Cmd_sm_shotty(client, args)
{
	if (client == 0)
	{
		ReplyToCommand(client, "%t", "Command is in-game only");
		return Plugin_Handled;
	}
	ShowMenuShotgun(client);
	return Plugin_Handled;
}

public Action:Event_PlayerDeath(Handle:event, const String:name[], bool:dontBroadcast)
{
	new victim   	= GetClientOfUserId(GetEventInt(event, "userid"));
	new attacker 	= GetClientOfUserId(GetEventInt(event, "attacker"));
	new hitgroup  = GetEventInt(event, "hitgroup");
	
	g_kill_stats[attacker][LOG_HIT_KILLS]++;
	g_kill_stats[victim][LOG_HIT_DEATHS]++;
	
	new killcount = g_kill_stats[attacker][LOG_HIT_KILLS];
	new headshots = g_kill_stats[attacker][LOG_HIT_HEADSHOTS];
	
	if (killcount == 10)
	{
		ShowMenuShotgun(attacker);
	}
	
	if (killcount == 20)
	{
		ShowMenuPrimary(attacker);
	}
	
	if (killcount == 30)
	{
		ShowMenuGrenade(attacker);
	}
	
	if (headshots == 10)
	{
		GivePlayerItem(attacker, "weapon_rpg");
		PrintToChat(attacker, "10 headshots for RPG");
	}
	g_kill_stats[victim][LOG_HIT_KILLS] = 0;
}


ShowMenuShotgun(client)
{
	new Handle:menu = CreateMenu(wShotty, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "wShotty");

	AddMenuItem(menu, "M590", "M590");
	AddMenuItem(menu, "TOZ", "TOZ");

	DisplayMenu(menu, client, MENU_TIME_FOREVER);
}

public wShotty(Handle:menu, MenuAction:action, param1, param2)
{
	switch (action)
	{
		case MenuAction_Select:
		{
			//param1 is client, param2 is item
			SetConVarFlags(FindConVar("sv_cheats"), GetConVarFlags(FindConVar("sv_cheats")) & ~FCVAR_NOTIFY);
			
			
			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));

			if (StrEqual(item, "M590"))
			{
				GivePlayerItem(param1, "weapon_m590");
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				
				//giving 20 ammo
				SetConVarBool(FindConVar("sv_cheats"), true, false, false);
				FakeClientCommand(param1, "give_ammo 20");	
				SetConVarBool(FindConVar("sv_cheats"), false, false, false);				
				
			}
			else if (StrEqual(item, "TOZ"))
			{
				GivePlayerItem(param1, "weapon_toz");
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				
				//giving 20 ammo
				SetConVarBool(FindConVar("sv_cheats"), true, false, false);
				FakeClientCommand(param1, "give_ammo 20");
				SetConVarBool(FindConVar("sv_cheats"), false, false, false);

			}
		}

		case MenuAction_End:
		{
			//param1 is MenuEnd reason, if canceled param2 is MenuCancel reason
			CloseHandle(menu);

		}

		case MenuAction_DisplayItem:
		{
			//param1 is client, param2 is item

			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));

			if (StrEqual(item, "M590"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "M590", param1);
				return RedrawMenuItem(translation);
			}
			else if (StrEqual(item, "TOZ"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "TOZ", param1);
				return RedrawMenuItem(translation);
			}
		}

	}
	return 0;
}

ShowMenuPrimary(client)
{
	new Handle:menu = CreateMenu(wPrimary, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "wPrimary");

	AddMenuItem(menu, "MP5K", "MP5K");
	AddMenuItem(menu, "UMP45", "UMP45");
	AddMenuItem(menu, "AK74", "AK 74");
	AddMenuItem(menu, "AKM", "AKM");
	AddMenuItem(menu, "M16A4", "M16A4");
	AddMenuItem(menu, "M4A1", "M4A1");
	AddMenuItem(menu, "MK18", "MK18");

	DisplayMenu(menu, client, MENU_TIME_FOREVER);
}

public wPrimary(Handle:menu, MenuAction:action, param1, param2)
{
	switch (action)
	{
		case MenuAction_Select:
		{
			//param1 is client, param2 is item

			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));

			if (StrEqual(item, "MP5K"))
			{
				GivePlayerItem(param1, "weapon_mp5");
				//SetEntProp("weapon_m590", Prop_Data, "m_iClip1", 20);
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				
				//giving 20 ammo
				SetConVarBool(FindConVar("sv_cheats"), true, false, false);
				FakeClientCommand(param1, "give_ammo 3");	
				SetConVarBool(FindConVar("sv_cheats"), false, false, false);			

			}
			else if (StrEqual(item, "UMP45"))
			{
				GivePlayerItem(param1, "weapon_ump45");
				//SetEntProp("weapon_m590", Prop_Data, "m_iClip1", 20);
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				
				//giving 20 ammo
				SetConVarBool(FindConVar("sv_cheats"), true, false, false);
				FakeClientCommand(param1, "give_ammo 3");	
				SetConVarBool(FindConVar("sv_cheats"), false, false, false);			

			}
			else if (StrEqual(item, "AK74"))
			{
				GivePlayerItem(param1, "weapon_ak74");
				//SetEntProp("weapon_m590", Prop_Data, "m_iClip1", 20);
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				
				//giving 20 ammo
				SetConVarBool(FindConVar("sv_cheats"), true, false, false);
				FakeClientCommand(param1, "give_ammo 3");	
				SetConVarBool(FindConVar("sv_cheats"), false, false, false);			

			}
			else if (StrEqual(item, "AKM"))
			{
				GivePlayerItem(param1, "weapon_akm");
				//SetEntProp("weapon_m590", Prop_Data, "m_iClip1", 20);
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				
				//giving 20 ammo
				SetConVarBool(FindConVar("sv_cheats"), true, false, false);
				FakeClientCommand(param1, "give_ammo 3");	
				SetConVarBool(FindConVar("sv_cheats"), false, false, false);			

			}
			else if (StrEqual(item, "M16A4"))
			{
				GivePlayerItem(param1, "weapon_m16a4");
				//SetEntProp("weapon_m590", Prop_Data, "m_iClip1", 20);
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				
				//giving 20 ammo
				SetConVarBool(FindConVar("sv_cheats"), true, false, false);
				FakeClientCommand(param1, "give_ammo 3");	
				SetConVarBool(FindConVar("sv_cheats"), false, false, false);			

			}
			else if (StrEqual(item, "M4A1"))
			{
				GivePlayerItem(param1, "weapon_m4a1");
				//SetEntProp("weapon_m590", Prop_Data, "m_iClip1", 20);
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				
				//giving 20 ammo
				SetConVarBool(FindConVar("sv_cheats"), true, false, false);
				FakeClientCommand(param1, "give_ammo 3");	
				SetConVarBool(FindConVar("sv_cheats"), false, false, false);			

			}
			else if (StrEqual(item, "MK18"))
			{
				GivePlayerItem(param1, "weapon_mk18");
				//SetEntProp("weapon_m590", Prop_Data, "m_iClip1", 20);
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				
				//giving 20 ammo
				SetConVarBool(FindConVar("sv_cheats"), true, false, false);
				FakeClientCommand(param1, "give_ammo 3");	
				SetConVarBool(FindConVar("sv_cheats"), false, false, false);			

			}
		}

		case MenuAction_End:
		{
			//param1 is MenuEnd reason, if canceled param2 is MenuCancel reason
			CloseHandle(menu);

		}

		case MenuAction_DisplayItem:
		{
			//param1 is client, param2 is item

			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));

			if (StrEqual(item, "MP5K"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "MP5K", param1);
				return RedrawMenuItem(translation);
			}
			else if (StrEqual(item, "UMP45"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "UMP45", param1);
				return RedrawMenuItem(translation);
			}
			else if (StrEqual(item, "AK74"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "AK 74", param1);
				return RedrawMenuItem(translation);
			}
			else if (StrEqual(item, "AKM"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "AKM", param1);
				return RedrawMenuItem(translation);
			}
			else if (StrEqual(item, "M16A4"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "M16A4", param1);
				return RedrawMenuItem(translation);
			}
			else if (StrEqual(item, "M4A1"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "M4A1", param1);
				return RedrawMenuItem(translation);
			}
			else if (StrEqual(item, "MK18"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "MK18", param1);
				return RedrawMenuItem(translation);
			}
		}

	}
	return 0;
}

ShowMenuGrenade(client)
{
	new Handle:menu = CreateMenu(wGrenade, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "wGrenade");

	AddMenuItem(menu, "ANM14", "ANM 14");
	AddMenuItem(menu, "Grenade", "Grenade");
	AddMenuItem(menu, "Molotov", "Molotov");
	AddMenuItem(menu, "Smoke", "Smoke Grenade");
	AddMenuItem(menu, "Flash", "Flash Grenade");

	DisplayMenu(menu, client, MENU_TIME_FOREVER);
}

public wGrenade(Handle:menu, MenuAction:action, param1, param2)
{
	switch (action)
	{
		case MenuAction_Select:
		{
			//param1 is client, param2 is item

			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));

			if (StrEqual(item, "ANM14"))
			{
				GivePlayerItem(param1, "sec_chest_carrier");
				GivePlayerItem(param1, "weapon_anm14");

			}
			else if (StrEqual(item, "Grenade"))
			{
				GivePlayerItem(param1, "sec_chest_carrier");
				GivePlayerItem(param1, "weapon_m67");

			}
			else if (StrEqual(item, "Molotov"))
			{
				GivePlayerItem(param1, "sec_chest_carrier");
				GivePlayerItem(param1, "weapon_molotov");

			}
			else if (StrEqual(item, "Smoke"))
			{
				GivePlayerItem(param1, "sec_chest_carrier");
				GivePlayerItem(param1, "weapon_m18");

			}
			else if (StrEqual(item, "Flash"))
			{
				GivePlayerItem(param1, "sec_chest_carrier");
				GivePlayerItem(param1, "weapon_m84");

			}
		}

		case MenuAction_End:
		{
			//param1 is MenuEnd reason, if canceled param2 is MenuCancel reason
			CloseHandle(menu);

		}

		case MenuAction_DisplayItem:
		{
			//param1 is client, param2 is item

			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));

			if (StrEqual(item, "ANM14"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "ANM 14", param1);
				return RedrawMenuItem(translation);
			}
			else if (StrEqual(item, "Grenade"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "Grenade", param1);
				return RedrawMenuItem(translation);
			}
			else if (StrEqual(item, "Molotov"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "Molotov", param1);
				return RedrawMenuItem(translation);
			}
			else if (StrEqual(item, "Smoke"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "Smoke Grenade", param1);
				return RedrawMenuItem(translation);
			}
			else if (StrEqual(item, "Flash"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "Flash Grenade", param1);
				return RedrawMenuItem(translation);
			}
		}

	}
	return 0;
}