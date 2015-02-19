#include <sourcemod>
#include <sdktools>
#include <loghelper>
#include <wstatshelper>
#include <clientprefs>
#include <smlib>

#pragma semicolon 1

//new g_kill_stats[MAXPLAYERS+1][15];


public Plugin:myinfo =
{
	name = "Perks5",
	author = "RIPPEDnFADED",
	description = "",
	version = "1.0.0",
	url = "https://forums.alliedmods.net/"
}

public OnPluginStart()
{
	LoadTranslations("common.phrases");
	LoadTranslations("myplugin.phrases");
	RegConsoleCmd("sm_perks5", Cmd_sm_perks5);
}

public Action:Cmd_sm_perks5(client, args)
{
	if (client == 0)
	{
		ReplyToCommand(client, "%t", "Command is in-game only");
		return Plugin_Handled;
	}
	ShowMenu(client);
	return Plugin_Handled;
}

ShowMenu(client)
{
	new Handle:menu = CreateMenu(mh_Perks5, MENU_ACTIONS_DEFAULT | MenuAction_DisplayItem);
	SetMenuTitle(menu, "Perks5");

	AddMenuItem(menu, "AT4", "AT4");
	AddMenuItem(menu, "C4", "C4");

	DisplayMenu(menu, client, MENU_TIME_FOREVER);
}

public mh_Perks5(Handle:menu, MenuAction:action, param1, param2)
{
	switch (action)
	{
		case MenuAction_Select:
		{
			//param1 is client, param2 is item

			new String:item[64];
			GetMenuItem(menu, param2, item, sizeof(item));

			if (StrEqual(item, "AT4"))
			{
				PrintHintTextToAll("Gave AT4");
				GivePlayerItem(param1, "weapon_at4");

			}
			else if (StrEqual(item, "C4"))
			{
				PrintHintTextToAll("Gave C4");
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
			else if (StrEqual(item, "C4"))
			{
				new String:translation[128];
				Format(translation, sizeof(translation), "%T", "C4", param1);
				return RedrawMenuItem(translation);
			}
		}

	}
	return 0;
}
