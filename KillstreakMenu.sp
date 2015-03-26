#include <sourcemod>
#include <sdktools>
#include <loghelper>
#include <wstatshelper>
#include <clientprefs>

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
	HookEvent( "player_death", Event_PlayerDeath );
	HookEvent( "player_spawn", Event_PlayerSpawn);
	RegConsoleCmd("sm_shotty", Cmd_sm_shotty);
	RegConsoleCmd("sm_primary", Cmd_sm_primary);
	RegConsoleCmd("sm_explosive", Cmd_sm_grenade);
	RegConsoleCmd("sm_m9z", Cmd_sm_m9z);
	RegConsoleCmd("sm_test", test);
}

public Action:test(client, args)
{
    if(client != 0 && IsClientInGame(client) && IsPlayerAlive(client))
    {
        new ent_index = GetPlayerWeaponSlot(client, 0);

        if(ent_index == -1)
        {
            //No weapon
            return Plugin_Handled;
        }

        // weapon clip
        new clip1 = GetEntProp(ent_index, Prop_Send, "m_iClip1");

        //when clip1 return value 255, it's actually NULL, not in use. Grenades, knife. Set value then -1
        clip1 = clip1 == 255 ? -1:clip1;

        // player ammo
        new m_iAmmo_array_index = GetEntProp(ent_index, Prop_Send, "m_iPrimaryAmmoType");
        new m_iAmmo_array_ammo = -1; // default NULL value if weapon not have ammo type

        if(m_iAmmo_array_index != -1)
        {
            m_iAmmo_array_ammo = GetEntProp(client, Prop_Send, "m_iAmmo", _, m_iAmmo_array_index);
        }

        PrintToChat(client, "Weapon m_iClip1 %i / player m_iAmmo %i", clip1, m_iAmmo_array_ammo);
    }

    return Plugin_Handled;
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

public Action:Cmd_sm_primary(client, args)
{
	if (client == 0)
	{
		ReplyToCommand(client, "%t", "Command is in-game only");
		return Plugin_Handled;
	}
	ShowMenuPrimary(client);
	return Plugin_Handled;
}

public Action:Cmd_sm_grenade(client, args)
{
	if (client == 0)
	{
		ReplyToCommand(client, "%t", "Command is in-game only");
		return Plugin_Handled;
	}
	ShowMenuExplosive(client);
	return Plugin_Handled;
}

public Action:Cmd_sm_m9z(client, args)
{
	if (client == 0)
	{
		ReplyToCommand(client, "%t", "Command is in-game only");
		return Plugin_Handled;
	}
	ShowMenuM9Z(client);
	return Plugin_Handled;
}

public Action:Event_PlayerSpawn(Handle:event, const String:name[], bool:dontBroadcast)
{ 
	g_kill_stats[MAXPLAYERS][LOG_HIT_KILLS] = 0;
}

public Action:Event_PlayerDeath(Handle:event, const String:name[], bool:dontBroadcast)
{
	new victim   	= GetClientOfUserId(GetEventInt(event, "userid"));
	new attacker 	= GetClientOfUserId(GetEventInt(event, "attacker"));
	
	g_kill_stats[attacker][LOG_HIT_KILLS]++;
	g_kill_stats[victim][LOG_HIT_DEATHS]++;
	
	new killcount = g_kill_stats[attacker][LOG_HIT_KILLS];
	
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
		ShowMenuExplosive(attacker);
	}
	if (killcount == 50)
	{
		ShowMenuExplosive(attacker);
	}
	if (killcount == 70)
	{
		ShowMenuExplosive(attacker);
	}
	if (killcount == 90)
	{
		ShowMenuExplosive(attacker);
	}
	
	if (killcount == 100)
	{
		ShowMenuM9Z(attacker);
	}
	g_kill_stats[victim][LOG_HIT_KILLS] = 0;
}

ShowMenuM9Z(client)
{
	new Handle:menu = CreateMenu(wM9Z, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "CHOOSE THE M9Z");

	AddMenuItem(menu, "M9Z", "M9Z");

	DisplayMenu(menu, client, MENU_TIME_FOREVER);
}

public wM9Z(Handle:menu, MenuAction:action, param1, param2)
{
	switch (action)
	{
		case MenuAction_Select:
		{
			//param1 is client, param2 is item

			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));

			if (StrEqual(item, "M9Z"))
			{
				GivePlayerItem(param1, "weapon_m9z");
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
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

			if (StrEqual(item, "M9Z"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "M9Z", param1);
				return RedrawMenuItem(translation);
			}
		}

	}
	return 0;
}

ShowMenuShotgun(client)
{
	new Handle:menu = CreateMenu(wShotty, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "CHOOSE A SHOTGUN");

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
				SetAmmo(param1, 0, 24);
			}
			else if (StrEqual(item, "TOZ"))
			{
				GivePlayerItem(param1, "weapon_toz");
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				SetAmmo(param1, 0, 24);
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
	SetMenuTitle(menu, "CHOOSE AN ASSAULT RIFLE");

	AddMenuItem(menu, "3 Mags", "3 Mags");
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
			if (StrEqual(item, "3 Mags"))
			{
				new weapon = GetPlayerWeaponSlot(param1, 0);
				new ammo = GetEntProp(weapon, Prop_Send, "m_iAmmo", 1);
				SetAmmo(param1, 0, 3);
			}
			if (StrEqual(item, "MP5K"))
			{
				GivePlayerItem(param1, "weapon_mp5");
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				SetAmmo(param1, 0, 3);
			}
			else if (StrEqual(item, "UMP45"))
			{
				GivePlayerItem(param1, "weapon_ump45");
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				SetAmmo(param1, 0, 3);
			}
			else if (StrEqual(item, "AK74"))
			{
				GivePlayerItem(param1, "weapon_ak74");
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				SetReserveAmmo(param1, 3);
			}
			else if (StrEqual(item, "AKM"))
			{
				GivePlayerItem(param1, "weapon_akm");
				new shotty = GetPlayerWeaponSlot(param1, 0);
				new ammo = GetEntProp(shotty, Prop_Data, "m_iPrimaryAmmoType");
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				GivePlayerAmmo(param1, 3, ammo, false);
				//SetAmmo(param1, 0, 3);
			}
			else if (StrEqual(item, "M16A4"))
			{
				GivePlayerItem(param1, "weapon_m16a4");
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				SetAmmo(param1, 0, 3);
			}
			else if (StrEqual(item, "M4A1"))
			{
				GivePlayerItem(param1, "weapon_m4a1");
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				SetAmmo(param1, 0, 3);
			}
			else if (StrEqual(item, "MK18"))
			{
				GivePlayerItem(param1, "weapon_mk18");
				new shotty = GetPlayerWeaponSlot(param1, 0);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
				SetAmmo(param1, 0, 3);
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

ShowMenuExplosive(client)
{
	new Handle:menu = CreateMenu(wExplosive, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "CHOOSE AN EXPLOSIVE");

	AddMenuItem(menu, "RPG", "RPG");
	AddMenuItem(menu, "AT4", "AT4");
	AddMenuItem(menu, "FRAG", "FRAG");
	AddMenuItem(menu, "ANM14", "ANM14");
	AddMenuItem(menu, "C4", "C4");
	AddMenuItem(menu, "IED", "IED");

	DisplayMenu(menu, client, MENU_TIME_FOREVER);
}

public wExplosive(Handle:menu, MenuAction:action, param1, param2)
{
	switch (action)
	{
		case MenuAction_Select:
		{
			//param1 is client, param2 is item

			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));

			if (StrEqual(item, "RPG"))
			{
				GivePlayerItem(param1, "weapon_rpg7");

			}
			else if (StrEqual(item, "AT4"))
			{
				GivePlayerItem(param1, "weapon_at4");

			}
			else if (StrEqual(item, "FRAG"))
			{
				GivePlayerItem(param1, "weapon_m67_frag");

			}
			else if (StrEqual(item, "ANM14"))
			{
				GivePlayerItem(param1, "weapon_anm14");
				new shotty = GetPlayerWeaponSlot(param1, 4);
				SetEntPropEnt(param1, Prop_Send, "m_hActiveWeapon", shotty);
			}
			else if (StrEqual(item, "C4"))
			{
				GivePlayerItem(param1, "weapon_c4_clicker");

			}
			else if (StrEqual(item, "IED"))
			{
				GivePlayerItem(param1, "weapon_c4_ied");

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

			if (StrEqual(item, "RPG"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "RPG", param1);
				return RedrawMenuItem(translation);
			}
			else if (StrEqual(item, "AT4"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "AT4", param1);
				return RedrawMenuItem(translation);
			}
			else if (StrEqual(item, "C4"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "C4", param1);
				return RedrawMenuItem(translation);
			}
			else if (StrEqual(item, "IED"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "IED", param1);
				return RedrawMenuItem(translation);
			}

		}

	}
	return 0;
}

stock SetAmmo(client, wepslot, newAmmo)
{
	new weapon = GetPlayerWeaponSlot(client, wepslot);
	if (IsValidEntity(weapon))
	{
		new iOffset = GetEntProp(weapon, Prop_Send, "m_iPrimaryAmmoType", 1)*4;
		new iAmmoTable = FindSendPropOffs("CINSPlayer", "m_iAmmo");
		SetEntData(client, iAmmoTable+iOffset, newAmmo, 4, true);
	}
}

stock SetReserveAmmo(client, ammo)
{
    new weapon = GetEntPropEnt(client, Prop_Data, "m_hActiveWeapon");
    if(weapon < 1) return;
    
    new ammotype = GetEntProp(weapon, Prop_Send, "m_iPrimaryAmmoType");
    if(ammotype == -1) return;
    
    SetEntProp(client, Prop_Send, "m_iAmmo", ammo, _, ammotype);
}  
