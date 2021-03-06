#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#define LOG_HIT_KILLS      2

new g_kill_stats[MAXPLAYERS+1][15];
new g_WeaponParent;


public Plugin:myinfo =
{
	name = "Killstreak Menu",
	author = "RIPPEDnFADED",
	description = "",
	version = "1.8.0",
	url = "http://info.420blaze.me"
}

public OnPluginStart()
{
	HookEvent("player_death", Event_PlayerDeath);
	HookEvent("player_spawn", Event_PlayerSpawn);
	HookEvent("player_team", Event_ChangeTeam);
	SetConVarFlags(FindConVar("sv_cheats"), GetConVarFlags(FindConVar("sv_cheats")) & ~FCVAR_NOTIFY);
	RegConsoleCmd("sm_menu", Cmd_sm_menu);
	
	g_WeaponParent = FindSendPropOffs("CINSWeapon", "m_hOwnerEntity");
}

public Action:Cmd_sm_menu(client, args)
{
	ShowUpgradeMenu(client);
}

public Action:Event_ChangeTeam(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	KillMenu(client);
}

public Action:Event_PlayerSpawn(Handle:event, const String:name[], bool:dontBroadcast)
{ 
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	KillMenu(client);
	
	new ragdoll = GetEntPropEnt(client, Prop_Send, "m_hRagdoll");
	if (ragdoll == -1)
	{
		
	}
	else
	{
	RemoveEdict(ragdoll);
	}	
}

public Action:Event_PlayerDeath(Handle:event, const String:name[], bool:dontBroadcast)
{ 
	new attacker 	= GetClientOfUserId(GetEventInt(event, "attacker"));
	new victim = GetClientOfUserId(GetEventInt(event, "userid"));
	g_kill_stats[attacker][LOG_HIT_KILLS] ++;
	new killcount = g_kill_stats[attacker][LOG_HIT_KILLS];
	
	PrintToChat(attacker, "%i kills", killcount);
	
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
	else if (killcount == 70)
	{
		ShowUpgradeMenu(attacker);
	}
	else if (killcount == 90)
	{
		ShowUpgradeMenu(attacker);
	}
	else if (killcount == 100)
	{
		//ShowHunnidUpgradeMenu(attacker);
	}
	else if (killcount == 120)
	{
		ShowUpgradeMenu(attacker);
	}
	g_kill_stats[victim][LOG_HIT_KILLS] = 0;
	
	new vkillcount = g_kill_stats[victim][LOG_HIT_KILLS];
	
	PrintToChat(victim, "%i kills", vkillcount);
	
	new maxent = GetMaxEntities(), String:wepname[64];
	for (new i=GetMaxClients();i<maxent;i++)
	{
			if ( IsValidEdict(i) && IsValidEntity(i) )
			{
				GetEdictClassname(i, wepname, sizeof(wepname));
				if(StrContains(wepname, "weapon_") != -1 && GetEntDataEnt2(i, g_WeaponParent) == -1 )
					{
					RemoveEdict(i);
					}
			}
	}

		decl String:classname[128];
		GetEdictClassname(victim, classname, sizeof(classname));
	
		if (StrEqual(classname, "turned"))
		{
		DispatchKeyValue(victim, "teamnumber","2");
		SetEntityModel(victim, "models/characters/civilian_vip_02.mdl");
		DispatchKeyValue(victim, "classname","playa");
		}
}

ShowfirstMenuShotgun(client)
{
	new Handle:menu = CreateMenu(firstMenuShotgun, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Select your first reward");
	AddMenuItem(menu, "Health", "Health");
	AddMenuItem(menu, "M590", "M590");
	AddMenuItem(menu, "TOZ", "TOZ");
	DisplayMenu(menu, client, MENU_TIME_FOREVER);
}

ShowfirstMenuUpgrade(client)
{
	new Handle:menu = CreateMenu(firstMenuUpgrade, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Select your upgrade path");
	AddMenuItem(menu, "Health", "Health");
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
	AddMenuItem(menu, "Health", "Health");
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
	AddMenuItem(menu, "Hollow Point", "Hollow Point");
	AddMenuItem(menu, "Armor Piercing", "Armor Piercing");
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
	AddMenuItem(menu, "Hollow Point", "Hollow Point");
	AddMenuItem(menu, "Armor Piercing", "Armor Piercing");
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
	AddMenuItem(menu, "Hollow Point", "Hollow Point");
	AddMenuItem(menu, "Armor Piercing", "Armor Piercing");
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
	AddMenuItem(menu, "Hollow Point", "Hollow Point");
	AddMenuItem(menu, "Armor Piercing", "Armor Piercing");
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
	AddMenuItem(menu, "Hollow Point", "Hollow Point");
	AddMenuItem(menu, "Armor Piercing", "Armor Piercing");
	AddMenuItem(menu, "Heavy Barrel", "Heavy Barrel");
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
	AddMenuItem(menu, "Hollow Point", "Hollow Point");
	AddMenuItem(menu, "Armor Piercing", "Armor Piercing");
	AddMenuItem(menu, "Heavy Barrel", "Heavy Barrel");
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
	AddMenuItem(menu, "Hollow Point", "Hollow Point");
	AddMenuItem(menu, "Armor Piercing", "Armor Piercing");
	AddMenuItem(menu, "Heavy Barrel", "Heavy Barrel");
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
			
			if (StrEqual(item, "Health"))
			{
				new addhealth= 25;
				new health = GetEntProp(SECclient, Prop_Send, "m_iHealth") + addhealth;
				SetEntProp(SECclient, Prop_Send, "m_iHealth", health);
				PrintHintText(SECclient, "%i /125HP", health);	
			}
			
			if (StrEqual(item, "M590"))
			{
				FakeClientCommand(SECclient, "give_weapon m590");
				FakeClientCommand(SECclient, "slot1");
				SetZeroAmmo(SECclient, 0, 32);
			}
			else if (StrEqual(item, "TOZ"))
			{
				FakeClientCommand(SECclient, "give_weapon toz");
				FakeClientCommand(SECclient, "slot1");
				SetZeroAmmo(SECclient, 0, 32);
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
			
			if (StrEqual(item, "Health"))
			{
				new addhealth= 25;
				new health = GetEntProp(SECclient, Prop_Send, "m_iHealth") + addhealth;
				SetEntProp(SECclient, Prop_Send, "m_iHealth", health);
				PrintHintText(SECclient, "%i /125HP", health);
			}
			
			if (StrEqual(item, "Ammo"))
			{
				FakeClientCommand(SECclient, "slot1");
				ShotgunAmmo(SECclient);
				FakeClientCommand(SECclient, "give_ammo 3");
				FakeClientCommand(SECclient, "slot1");
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
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade sec_flashlight_shotgun");
				FakeClientCommand(SECclient, "give_upgrade ins_flashlight_shotgun");
			}
			if (StrEqual(item, "Foregrip"))
			{

				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade sec_foregrip2");
				FakeClientCommand(SECclient, "give_upgrade ins_foregrip2");
			}
			else if (StrEqual(item, "Suppressor"))
			{

				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade sec_silencer_heavy");
				FakeClientCommand(SECclient, "give_upgrade ins_silencer_heavy");
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
			FakeClientCommand(SECclient, "slot1");
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
				new ent = GetPlayerWeaponSlot(SECclient, 0); // What weapon is currently in primary
				FakeClientCommand(SECclient, "give_weapon mp5"); // Give new weapon
				FakeClientCommand(SECclient, "slot1"); // This sometimes doesn't work
				new ent2 = GetPlayerWeaponSlot(SECclient, 0); // What new weapon is in primary
				if (ent == ent2) // If the weapons are the same don't delete but continue otherwise T Pose
				{
				SetZeroAmmo(SECclient, 0, 3); // Clears clips and set at 3 clips
				}
				else // The weapons are different so continue
				{
				SetZeroAmmo(SECclient, 0, 3); // Clears clips and set at 3 clips
				RemoveEdict(ent);	// Remove old gun ent
				}
			}
			else if (StrEqual(item, "UMP45"))
			{
				new ent = GetPlayerWeaponSlot(SECclient, 0);
				FakeClientCommand(SECclient, "give_weapon ump45");
				FakeClientCommand(SECclient, "slot1");
				new ent2 = GetPlayerWeaponSlot(SECclient, 0);
				if (ent == ent2)
				{
				SetZeroAmmo(SECclient, 0, 3); //this is a bug and does not seem to set the magazine count
				}
				else
				{
				SetZeroAmmo(SECclient, 0, 3); //this is a bug and does not seem to set the magazine count
				RemoveEdict(ent);
				}
			}
			else if (StrEqual(item, "AK74"))
			{
				new ent = GetPlayerWeaponSlot(SECclient, 0);
				FakeClientCommand(SECclient, "give_weapon ak74");
				FakeClientCommand(SECclient, "slot1");
				new ent2 = GetPlayerWeaponSlot(SECclient, 0);
				if (ent == ent2)
				{
				SetZeroAmmo(SECclient, 0, 3); //this is a bug and does not seem to set the magazine count
				}
				else
				{
				SetZeroAmmo(SECclient, 0, 3); //this is a bug and does not seem to set the magazine count
				RemoveEdict(ent);
				}
			}
			else if (StrEqual(item, "AKM"))
			{
				new ent = GetPlayerWeaponSlot(SECclient, 0);
				FakeClientCommand(SECclient, "give_weapon akm");
				FakeClientCommand(SECclient, "slot1");
				new ent2 = GetPlayerWeaponSlot(SECclient, 0);
				if (ent == ent2)
				{
				SetZeroAmmo(SECclient, 0, 3); //this is a bug and does not seem to set the magazine count
				}
				else
				{
				SetZeroAmmo(SECclient, 0, 3); //this is a bug and does not seem to set the magazine count
				RemoveEdict(ent);
				}
			}
			else if (StrEqual(item, "M16A4"))
			{
				new ent = GetPlayerWeaponSlot(SECclient, 0);
				FakeClientCommand(SECclient, "give_weapon m16a4");
				FakeClientCommand(SECclient, "slot1");
				new ent2 = GetPlayerWeaponSlot(SECclient, 0);
				if (ent == ent2)
				{
				SetZeroAmmo(SECclient, 0, 3); //this is a bug and does not seem to set the magazine count
				}
				else
				{
				SetZeroAmmo(SECclient, 0, 3); //this is a bug and does not seem to set the magazine count
				RemoveEdict(ent);
				}
			}
			else if (StrEqual(item, "M4A1"))
			{
				new ent = GetPlayerWeaponSlot(SECclient, 0);
				FakeClientCommand(SECclient, "give_weapon m4a1");
				FakeClientCommand(SECclient, "slot1");
				new ent2 = GetPlayerWeaponSlot(SECclient, 0);
				if (ent == ent2)
				{
				SetZeroAmmo(SECclient, 0, 3); //this is a bug and does not seem to set the magazine count
				}
				else
				{
				SetZeroAmmo(SECclient, 0, 3); //this is a bug and does not seem to set the magazine count
				RemoveEdict(ent);
				}
			}
			else if (StrEqual(item, "MK18"))
			{
				new ent = GetPlayerWeaponSlot(SECclient, 0);
				FakeClientCommand(SECclient, "give_weapon mk18");
				FakeClientCommand(SECclient, "slot1");
				new ent2 = GetPlayerWeaponSlot(SECclient, 0);
				if (ent == ent2)
				{
				SetZeroAmmo(SECclient, 0, 3); //this is a bug and does not seem to set the magazine count
				}
				else
				{
				SetZeroAmmo(SECclient, 0, 3); //this is a bug and does not seem to set the magazine count
				RemoveEdict(ent);
				}
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
			
			if (StrEqual(item, "Health"))
			{
				new addhealth= 25;
				new health = GetEntProp(SECclient, Prop_Send, "m_iHealth") + addhealth;
				SetEntProp(SECclient, Prop_Send, "m_iHealth", health);
				PrintHintText(SECclient, "%i /125HP", health);
			}
			
			if (StrEqual(item, "Ammo"))
			{
				FakeClientCommand(SECclient, "slot1");
				ShotgunAmmo(SECclient);
				FakeClientCommand(SECclient, "give_ammo 3");
				FakeClientCommand(SECclient, "slot1");
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
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade sec_flashlight_band");
			}
			else if (StrEqual(item, "Red-Dot Sight"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade optic_aimpoint");
			}
			else if (StrEqual(item, "Suppressor"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade sec_silencer");
			}
			else if (StrEqual(item, "Hollow Point"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ammo_hp_mp5");
			}
			else if (StrEqual(item, "Armor Piercing"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ammo_ap_mp5");
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
			FakeClientCommand(SECclient, "slot1");
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
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade sec_flashlight_rail");
			}
			else if (StrEqual(item, "Red-Dot Sight"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade optic_aimpoint");
			}
			else if (StrEqual(item, "Suppressor"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade sec_silencer");
			}
			else if (StrEqual(item, "Hollow Point"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ammo_hp_ump45");
			}
			else if (StrEqual(item, "Armor Piercing"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ammo_ap_ump45");
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
			FakeClientCommand(SECclient, "slot1");
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
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ins_flashlight_band");
			}
			if (StrEqual(item, "Kobra Sight"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade optic_kobra");
			}
			else if (StrEqual(item, "Suppressor"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ins_silencer");
			}
			else if (StrEqual(item, "Hollow Point"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ammo_hp_ak74");
			}
			else if (StrEqual(item, "Armor Piercing"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ammo_ap_ak74");
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
			FakeClientCommand(SECclient, "slot1");
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
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ins_flashlight_band");
			}
			if (StrEqual(item, "Kobra Sight"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade optic_kobra");
			}
			else if (StrEqual(item, "Suppressor"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ins_silencer");
			}
			else if (StrEqual(item, "Hollow Point"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ammo_hp_akm");
			}
			else if (StrEqual(item, "Armor Piercing"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ammo_ap_akm");
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
			FakeClientCommand(SECclient, "slot1");
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
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade sec_flashlight_rail");
			}
			else if (StrEqual(item, "Red-Dot Sight"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade optic_aimpoint");
			}
			else if (StrEqual(item, "Suppressor"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade sec_silencer");
			}
			else if (StrEqual(item, "Hollow Point"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ammo_hp_m16a4");
			}
			else if (StrEqual(item, "Armor Piercing"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ammo_ap_m16a4");
			}
			else if (StrEqual(item, "Heavy Barrel"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade heavybarrel");
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
			FakeClientCommand(SECclient, "slot1");
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
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade sec_flashlight_rail");
			}
			else if (StrEqual(item, "Red-Dot Sight"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade optic_aimpoint");
			}
			else if (StrEqual(item, "Suppressor"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade sec_silencer");
			}
			else if (StrEqual(item, "Hollow Point"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ammo_hp_m4");
			}
			else if (StrEqual(item, "Armor Piercing"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ammo_ap_m4");
			}
			else if (StrEqual(item, "Heavy Barrel"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade heavybarrel");
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
			FakeClientCommand(SECclient, "slot1");
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
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade sec_flashlight_rail");
			}
			else if (StrEqual(item, "Red-Dot Sight"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade optic_aimpoint");
			}
			else if (StrEqual(item, "Suppressor"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade sec_silencer2");
			}
			else if (StrEqual(item, "Hollow Point"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ammo_hp_m4");
			}
			else if (StrEqual(item, "Armor Piercing"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade ammo_ap_m4");
			}
			else if (StrEqual(item, "Heavy Barrel"))
			{
				FakeClientCommand(SECclient, "slot1");
				FakeClientCommand(SECclient, "give_upgrade heavybarrel");
			}
			CloseCheats();
		}
		case MenuAction_End:
		{
			CloseHandle(menu);
			FakeClientCommand(SECclient, "slot1");
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

stock SetZeroAmmo(client, slot, ammo)
{
	new weapon = GetPlayerWeaponSlot(client, slot);
	new iOffset = GetEntProp(weapon, Prop_Send, "m_iPrimaryAmmoType", 1)*4;
	new iAmmoTable = FindSendPropInfo("CINSPlayer", "m_iAmmo");
	SetEntData(client, iAmmoTable+iOffset, ammo, 4, true);
	SetEntData(weapon, iAmmoTable+iOffset, ammo, 4, true);
}  

stock RemovePrimary(client)
{
	new ent = GetPlayerWeaponSlot(client, 0);
	RemovePlayerItem(client, ent);
	RemoveEdict(ent);
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