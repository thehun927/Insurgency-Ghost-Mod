#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#define LOG_HIT_KILLS      2

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
	HookEvent("player_death", Event_PlayerDeath);
	HookEvent("player_spawn", Event_PlayerSpawn);	
	SetConVarFlags(FindConVar("sv_cheats"), GetConVarFlags(FindConVar("sv_cheats")) & ~FCVAR_NOTIFY);
}

public Action:Event_PlayerSpawn(Handle:event, const String:name[], bool:dontBroadcast)
{ 
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	KillMenu(client);
}

public Action:Event_PlayerDeath(Handle:event, const String:name[], bool:dontBroadcast)
{ 
	new attacker 	= GetClientOfUserId(GetEventInt(event, "attacker"));
	new victim = GetClientOfUserId(GetEventInt(event, "userid"));
	g_kill_stats[attacker][LOG_HIT_KILLS] ++;
	new killcount = g_kill_stats[attacker][LOG_HIT_KILLS];
	if (killcount == 10)
	{
		ShowfirstMenuShotgun(attacker);
	}
	else if (killcount == 20)
	{
		ShowfirstMenuUpgrade(attacker);
	}
	else if (killcount == 30)
	{
		ShowUpgradeMenu(attacker);
	}
	else if (killcount == 50)
	{
		ShowUpgradeMenu(attacker);
	}
	else if (killcount == 75)
	{
		ShowUpgradeMenu(attacker);
	}
	else if (killcount == 90)
	{
		ShowUpgradeMenu(attacker);
	}
	
	g_kill_stats[victim][LOG_HIT_KILLS] = 0;
}

ShowfirstMenuShotgun(client)
{
	new Handle:menu = CreateMenu(firstMenuShotgun, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Select your first reward");
	AddMenuItem(menu, "M590", "M590");
	AddMenuItem(menu, "TOZ", "TOZ");
	DisplayMenu(menu, client, MENU_TIME_FOREVER);
}

ShowfirstMenuUpgrade(client)
{
	new Handle:menu = CreateMenu(firstMenuUpgrade, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Select your upgrade path");
	AddMenuItem(menu, "Ammo", "Ammo");
	AddMenuItem(menu, "Attachments", "Attachments");
	AddMenuItem(menu, "Primary's", "Primary's");
	DisplayMenu(menu, client, MENU_TIME_FOREVER);
}

ShowShotgunUpgrades(client)
{
	new Handle:menu = CreateMenu(ShotgunUpgrades, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Select your upgrade");
	AddMenuItem(menu, "Flashlight", "Flashlight");
	AddMenuItem(menu, "Foregrip", "Foregrip");
	AddMenuItem(menu, "Suppressor", "Suppressor");
	DisplayMenu(menu, client, MENU_TIME_FOREVER);
	SetMenuExitBackButton(menu, true);
}

ShowPrimaryWeapons(client)
{
	new Handle:menu = CreateMenu(PrimaryWeapons, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Select a primary");
	AddMenuItem(menu, "MP5K", "MP5K");
	AddMenuItem(menu, "UMP45", "UMP45");
	AddMenuItem(menu, "AK74", "AK 74");
	AddMenuItem(menu, "AKM", "AKM");
	AddMenuItem(menu, "M16A4", "M16A4");
	AddMenuItem(menu, "M4A1", "M4A1");
	AddMenuItem(menu, "MK18", "MK18");
	DisplayMenu(menu, client, MENU_TIME_FOREVER);
	SetMenuExitBackButton(menu, true);
}

ShowUpgradeMenu(client)
{
	new Handle:menu = CreateMenu(UpgradeMenu, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Select your upgrade path");
	AddMenuItem(menu, "Ammo", "Ammo");
	AddMenuItem(menu, "Attachments", "Attachments");
	AddMenuItem(menu, "Primary's", "Primary's");
	AddMenuItem(menu, "Explosives", "Explosives");
	DisplayMenu(menu, client, MENU_TIME_FOREVER);
}

ShowExplosiveMenu(client)
{
	new Handle:menu = CreateMenu(ExplosiveMenu, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Select an explosive");
	AddMenuItem(menu, "AT4", "AT4");
	AddMenuItem(menu, "RPG", "RPG");
	AddMenuItem(menu, "Frag", "Frag");
	AddMenuItem(menu, "C4", "C4");
	DisplayMenu(menu, client, MENU_TIME_FOREVER);
	SetMenuExitBackButton(menu, true);
}

ShowMP5KUpgrades(client)
{
	new Handle:menu = CreateMenu(MP5KUpgrades, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Select your MP5 upgrade");
	AddMenuItem(menu, "Flashlight", "Flashlight");
	AddMenuItem(menu, "Red-Dot Sight", "Red-Dot Sight");
	AddMenuItem(menu, "Suppressor", "Suppressor");
	DisplayMenu(menu, client, MENU_TIME_FOREVER);
	SetMenuExitBackButton(menu, true);
}

ShowUMP45Upgrades(client)
{
	new Handle:menu = CreateMenu(UMP45Upgrades, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Select your UMP upgrade");
	AddMenuItem(menu, "Flashlight", "Flashlight");
	AddMenuItem(menu, "Red-Dot Sight", "Red-Dot Sight");
	AddMenuItem(menu, "Suppressor", "Suppressor");
	DisplayMenu(menu, client, MENU_TIME_FOREVER);
	SetMenuExitBackButton(menu, true);
}

ShowAK74Upgrades(client)
{
	new Handle:menu = CreateMenu(AK74Upgrades, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Select your AK74 upgrade");
	AddMenuItem(menu, "Flashlight", "Flashlight");
	AddMenuItem(menu, "Kobra Sight", "Kobra Sight");
	AddMenuItem(menu, "Suppressor", "Suppressor");
	DisplayMenu(menu, client, MENU_TIME_FOREVER);
	SetMenuExitBackButton(menu, true);
}

ShowAKMUpgrades(client)
{
	new Handle:menu = CreateMenu(AKMUpgrades, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Select your AKM upgrade");
	AddMenuItem(menu, "Flashlight", "Flashlight");
	AddMenuItem(menu, "Kobra Sight", "Kobra Sight");
	AddMenuItem(menu, "Suppressor", "Suppressor");
	DisplayMenu(menu, client, MENU_TIME_FOREVER);
	SetMenuExitBackButton(menu, true);
}

ShowM16A4Upgrades(client)
{
	new Handle:menu = CreateMenu(M16A4Upgrades, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Select your M16 upgrade");
	AddMenuItem(menu, "Flashlight", "Flashlight");
	AddMenuItem(menu, "Red-Dot Sight", "Red-Dot Sight");
	AddMenuItem(menu, "Suppressor", "Suppressor");
	DisplayMenu(menu, client, MENU_TIME_FOREVER);
	SetMenuExitBackButton(menu, true);
}

ShowM4A1Upgrades(client)
{
	new Handle:menu = CreateMenu(M4A1Upgrades, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Select your M4 upgrade");
	AddMenuItem(menu, "Flashlight", "Flashlight");
	AddMenuItem(menu, "Red-Dot Sight", "Red-Dot Sight");
	AddMenuItem(menu, "Suppressor", "Suppressor");
	DisplayMenu(menu, client, MENU_TIME_FOREVER);
	SetMenuExitBackButton(menu, true);
}

ShowMK18Upgrades(client)
{
	new Handle:menu = CreateMenu(MK18Upgrades, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Select your MK18 upgrade");
	AddMenuItem(menu, "Flashlight", "Flashlight");
	AddMenuItem(menu, "Red-Dot Sight", "Red-Dot Sight");
	AddMenuItem(menu, "Suppressor", "Suppressor");
	DisplayMenu(menu, client, MENU_TIME_FOREVER);
	SetMenuExitBackButton(menu, true);
}

KillMenu(client)
{
	new Handle:menu = CreateMenu(EmptyMenu, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu,"");
	SetMenuExitButton(menu, false);
	DisplayMenu(menu, client, 1);
}

ShotgunAmmo(client)
{
	new weapon = GetPlayerWeaponSlot(client, 0);
	decl String:classname[128];
	GetEdictClassname(weapon, classname, sizeof(classname));
	SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", weapon);
	if (StrEqual(classname, "weapon_m590"))
	{
		FakeClientCommand(client, "give_ammo 21");
	}
	else if (StrEqual(classname, "weapon_toz"))
	{
		FakeClientCommand(client, "give_ammo 21");
	}
	else
	{
		return;
	}
}

FindAttachmentMenu(client)
{
	new weapon = GetPlayerWeaponSlot(client, 0);
	decl String:classname[128];
	GetEdictClassname(weapon, classname, sizeof(classname));
	SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", weapon);
	if (StrEqual(classname, "weapon_mp5"))
	{
		ShowMP5KUpgrades(client);
	}
	else if (StrEqual(classname, "weapon_ump45"))
	{
		ShowUMP45Upgrades(client);
	}
	else if (StrEqual(classname, "weapon_ak74"))
	{
		ShowAK74Upgrades(client);
	}
	else if (StrEqual(classname, "weapon_akm"))
	{
		ShowAKMUpgrades(client);
	}
	else if (StrEqual(classname, "weapon_m16a4"))
	{
		ShowM16A4Upgrades(client);
	}
	else if (StrEqual(classname, "weapon_m4a1"))
	{
		ShowM4A1Upgrades(client);
	}
	else if (StrEqual(classname, "weapon_mk18"))
	{
		ShowMK18Upgrades(client);
	}
	else
	{
		PrintCenterText(client, "You don't have a gun, Stupid!");
	}
}

public firstMenuShotgun(Handle:menu, MenuAction:action, SECclient, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			//SECclient is client, param2 is item chosen
			OpenCheats();
			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));
			
			if (StrEqual(item, "M590"))
			{
				FakeClientCommand(SECclient, "give_weapon m590");
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				SetReserveAmmo(SECclient, 32);
			}
			else if (StrEqual(item, "TOZ"))
			{
				FakeClientCommand(SECclient, "give_weapon toz");
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				SetReserveAmmo(SECclient, 32);
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
		}
	}
	return 0;
}

public firstMenuUpgrade(Handle:menu, MenuAction:action, SECclient, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			OpenCheats();
			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));
			
			if (StrEqual(item, "Ammo"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				ShotgunAmmo(SECclient);
				FakeClientCommand(SECclient, "give_ammo 3");
			}
			if (StrEqual(item, "Attachments"))
			{
				ShowShotgunUpgrades(SECclient);
			}
			else if (StrEqual(item, "Primary's"))
			{
				ShowPrimaryWeapons(SECclient);
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
		}
	}
	return 0;
}

public ShotgunUpgrades(Handle:menu, MenuAction:action, SECclient, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			OpenCheats();
			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));
			
			if (StrEqual(item, "Flashlight"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade sec_flashlight_shotgun");
				FakeClientCommand(SECclient, "give_upgrade ins_flashlight_shotgun");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			if (StrEqual(item, "Foregrip"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade sec_foregrip2");
				FakeClientCommand(SECclient, "give_upgrade ins_foregrip2");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			else if (StrEqual(item, "Suppressor"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade sec_silencer_heavy");
				FakeClientCommand(SECclient, "give_upgrade ins_silencer_heavy");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
		}
	}
	return 0;
}

public PrimaryWeapons(Handle:menu, MenuAction:action, SECclient, param2)
{
	switch (action)
	{
		case MenuAction_Select:
		{
			OpenCheats();
			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));
			
			if (StrEqual(item, "MP5K"))
			{
				FakeClientCommand(SECclient, "give_weapon mp5");
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				SetReserveAmmo(SECclient, 3); //this is a bug and does not seem to set the magazine count
			}
			else if (StrEqual(item, "UMP45"))
			{
				FakeClientCommand(SECclient, "give_weapon ump45");
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				SetReserveAmmo(SECclient, 3);
			}
			else if (StrEqual(item, "AK74"))
			{
				FakeClientCommand(SECclient, "give_weapon ak74");
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				SetReserveAmmo(SECclient, 3);
			}
			else if (StrEqual(item, "AKM"))
			{
				FakeClientCommand(SECclient, "give_weapon akm");
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				SetReserveAmmo(SECclient, 3);
			}
			else if (StrEqual(item, "M16A4"))
			{
				FakeClientCommand(SECclient, "give_weapon m16a4");
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				SetReserveAmmo(SECclient, 3);
			}
			else if (StrEqual(item, "M4A1"))
			{
				FakeClientCommand(SECclient, "give_weapon m4a1");
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				SetReserveAmmo(SECclient, 3);
			}
			else if (StrEqual(item, "MK18"))
			{
				FakeClientCommand(SECclient, "give_weapon mk18");
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				SetReserveAmmo(SECclient, 3);
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
		}
	}
	return 0;
}

public UpgradeMenu(Handle:menu, MenuAction:action, SECclient, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			OpenCheats();
			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));
			
			if (StrEqual(item, "Ammo"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				ShotgunAmmo(SECclient);
				FakeClientCommand(SECclient, "give_ammo 3");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			else if (StrEqual(item, "Attachments"))
			{
				FindAttachmentMenu(SECclient);
			}
			else if (StrEqual(item, "Primary's"))
			{
				ShowPrimaryWeapons(SECclient);
			}
			else if (StrEqual(item, "Explosives"))
			{
				ShowExplosiveMenu(SECclient);
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
		}
	}
	return 0;
}

public ExplosiveMenu(Handle:menu, MenuAction:action, SECclient, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			OpenCheats();
			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));
			
			if (StrEqual(item, "AT4"))
			{
				FakeClientCommand(SECclient, "give_weapon at4");
			}
			else if (StrEqual(item, "RPG"))
			{
				FakeClientCommand(SECclient, "give_weapon rpg7");
			}
			else if (StrEqual(item, "Frag"))
			{
				FakeClientCommand(SECclient, "give_weapon m67");
			}
			else if (StrEqual(item, "C4"))
			{
				FakeClientCommand(SECclient, "give_weapon c4_clicker");
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
		}
	}
	return 0;
}

public MP5KUpgrades(Handle:menu, MenuAction:action, SECclient, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			OpenCheats();
			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));
			
			if (StrEqual(item, "Flashlight"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade sec_flashlight_band");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			if (StrEqual(item, "Red-Dot Sight"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade optic_aimpoint");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			else if (StrEqual(item, "Suppressor"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade sec_silencer");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
		}
	}
	return 0;
}

public UMP45Upgrades(Handle:menu, MenuAction:action, SECclient, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			OpenCheats();
			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));
			
			if (StrEqual(item, "Flashlight"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade sec_flashlight_rail");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			if (StrEqual(item, "Red-Dot Sight"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade optic_aimpoint");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			else if (StrEqual(item, "Suppressor"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade sec_silencer");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
		}
	}
	return 0;
}

public AK74Upgrades(Handle:menu, MenuAction:action, SECclient, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			OpenCheats();
			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));
			
			if (StrEqual(item, "Flashlight"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade ins_flashlight_band");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			if (StrEqual(item, "Kobra Sight"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade optic_kobra");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			else if (StrEqual(item, "Suppressor"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade ins_silencer");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
		}
	}
	return 0;
}

public AKMUpgrades(Handle:menu, MenuAction:action, SECclient, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			OpenCheats();
			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));
			
			if (StrEqual(item, "Flashlight"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade ins_flashlight_band");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			if (StrEqual(item, "Kobra Sight"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade optic_kobra");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			else if (StrEqual(item, "Suppressor"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade ins_silencer");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
		}
	}
	return 0;
}

public M16A4Upgrades(Handle:menu, MenuAction:action, SECclient, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			OpenCheats();
			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));
			
			if (StrEqual(item, "Flashlight"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade sec_flashlight_rail");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			if (StrEqual(item, "Red-Dot Sight"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade optic_aimpoint");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			else if (StrEqual(item, "Suppressor"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade sec_silencer");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
		}
	}
	return 0;
}

public M4A1Upgrades(Handle:menu, MenuAction:action, SECclient, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			OpenCheats();
			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));
			
			if (StrEqual(item, "Flashlight"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade sec_flashlight_rail");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			if (StrEqual(item, "Red-Dot Sight"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade optic_aimpoint");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			else if (StrEqual(item, "Suppressor"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade sec_silencer");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
		}
	}
	return 0;
}

public MK18Upgrades(Handle:menu, MenuAction:action, SECclient, param2)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			OpenCheats();
			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));
			
			if (StrEqual(item, "Flashlight"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade sec_flashlight_rail");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			if (StrEqual(item, "Red-Dot Sight"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade optic_aimpoint");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			else if (StrEqual(item, "Suppressor"))
			{
				new prWeapon = GetPlayerWeaponSlot(SECclient, 0);
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
				FakeClientCommand(SECclient, "give_upgrade sec_silencer2");
				SetEntPropEnt(SECclient, Prop_Send, "m_hActiveWeapon", prWeapon);
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
		}
	}
	return 0;
}

public EmptyMenu(Handle:menu, MenuAction:action, SECclient, param2)
{
	switch(action)
	{
		case MenuAction_End:
			{
				CloseHandle(menu);
			}
	}
}

stock SetReserveAmmo(client, ammo)
{
	OpenCheats();
	new weapon = GetEntPropEnt(client, Prop_Data, "m_hActiveWeapon");
	if(weapon < 1) return;
	new ammotype = GetEntProp(weapon, Prop_Send, "m_iPrimaryAmmoType");
	if(ammotype == -1) return;
	SetEntProp(client, Prop_Send, "m_iAmmo", ammo, _, ammotype);
	CloseCheats();
}  

stock OpenCheats()
{
	SetConVarBool(FindConVar("sv_cheats"), true, false);
}

stock CloseCheats()
{
	SetConVarBool(FindConVar("sv_cheats"), false, false);
	SetConVarBool(FindConVar("ins_bot_knives_only"), true, true);
}