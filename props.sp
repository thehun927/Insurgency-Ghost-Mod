#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <sdktools_functions>
#include <smlib/entities>

#undef REQUIRE_PLUGIN

#pragma semicolon 1

#define PLUGIN_VERSION "1"

public Plugin:myinfo =
{
	name = "Props",
	author = "MCXI",
	description = "",
	version = PLUGIN_VERSION,
	url = "http://info.420blaze.me"
};

public OnPluginStart()
{	
	PrecacheModel("models/vehicles/civ_bus.mdl", true);
	PrecacheModel("models/static_afghan/prop_panj_stairs.mdl", true);
	PrecacheModel("models/dynamic_props/mobile_toilet_stw_phys.mdl", true);
	PrecacheModel("models/static_fortifications/mog_metal_wall_01s.mdl", true);
	CreateConVar("sm_props_version", PLUGIN_VERSION, " Props Version", FCVAR_PLUGIN|FCVAR_SPONLY|FCVAR_REPLICATED|FCVAR_NOTIFY);
	RegConsoleCmd("sm_torch", Command_Torch, "Lighting");
	HookEvent("round_end", Event_RoundEnd);
}

public Event_RoundEnd(Handle:event, const String:name[], bool:dontBroadcast) 
{
		ServerCommand("sm_trigger torch kill");
}

public Action:Command_Torch(client,args)
{
        PerformTorchTime(client);  
}  

PerformTorchTime(client)
{
	CreateTimer(1.0, Launch, client);
}

public Action:Launch(Handle:timer, any:client)
{
		decl torch1;
		torch1 = CreateEntityByName("env_fire");
		DispatchSpawn(torch1);
		DispatchKeyValue(torch1, "origin","620 -1280 41");
		DispatchKeyValue(torch1, "targetname", "torch");
		DispatchKeyValue(torch1, "classname", "torch");
		
		decl torch2;
		torch2 = CreateEntityByName("env_fire");
		DispatchSpawn(torch2);
		DispatchKeyValue(torch2, "origin","380 -1220 41");
		DispatchKeyValue(torch2, "targetname", "torch");
		DispatchKeyValue(torch2, "classname", "torch");
		
		decl torch3;
		torch3 = CreateEntityByName("env_fire");
		DispatchSpawn(torch3);
		DispatchKeyValue(torch3, "origin","100 -1220 41");
		DispatchKeyValue(torch3, "targetname", "torch");
		DispatchKeyValue(torch3, "classname", "torch");
		
		decl torch4;
		torch4 = CreateEntityByName("env_fire");
		DispatchSpawn(torch4);
		DispatchKeyValue(torch4, "origin","-100 -1220 41");
		DispatchKeyValue(torch4, "targetname", "torch");
		DispatchKeyValue(torch4, "classname", "torch");
		
		decl torch5;
		torch5 = CreateEntityByName("env_fire");
		DispatchSpawn(torch5);
		DispatchKeyValue(torch5, "origin","-380 -1220 41");
		DispatchKeyValue(torch5, "targetname", "torch");
		DispatchKeyValue(torch5, "classname", "torch");
		
		decl torch6;
		torch6 = CreateEntityByName("env_fire");
		DispatchSpawn(torch6);
		DispatchKeyValue(torch6, "origin","-623 -1280 41");
		DispatchKeyValue(torch6, "targetname", "torch");
		DispatchKeyValue(torch6, "classname", "torch");
		
		ServerCommand("sm_trigger torch startfire");
		
		new shit = CreateEntityByName("light_dynamic");
		DispatchKeyValue(shit, "origin","599 618 311");
		DispatchKeyValue(shit, "_light", "200 255 200 255");
		DispatchKeyValue(shit, "brightness", "1");
		DispatchKeyValue(shit, "style", "10");
		DispatchKeyValue(shit, "spotlight_radius", "200");
		DispatchKeyValue(shit, "distance", "500");
		DispatchSpawn(shit);
		AcceptEntityInput(shit, "turnon");
		DispatchKeyValue(shit, "targetname","torch");
		DispatchKeyValue(shit, "classname", "torch");
		
		new shit2 = CreateEntityByName("light_dynamic");
		DispatchKeyValue(shit2, "origin","-611 631 238");
		DispatchKeyValue(shit2, "_light", "200 255 200 255");
		DispatchKeyValue(shit2, "brightness", "1");
		DispatchKeyValue(shit2, "style", "10");
		DispatchKeyValue(shit2, "spotlight_radius", "200");
		DispatchKeyValue(shit2, "distance", "500");
		DispatchSpawn(shit2);
		AcceptEntityInput(shit2, "turnon");
		DispatchKeyValue(shit2, "targetname","torch");
		DispatchKeyValue(shit2, "classname", "torch");
		
		new shit3 = CreateEntityByName("light_dynamic");
		DispatchKeyValue(shit3, "origin","4 191 280");
		DispatchKeyValue(shit3, "_light", "200 0 0 255");
		DispatchKeyValue(shit3, "brightness", "1");
		DispatchKeyValue(shit3, "style", "1");
		DispatchKeyValue(shit3, "spotlight_radius", "200");
		DispatchKeyValue(shit3, "distance", "500");
		DispatchSpawn(shit3);
		AcceptEntityInput(shit3, "turnon");
		DispatchKeyValue(shit3, "targetname","torch");
		DispatchKeyValue(shit3, "classname", "torch");
		
		new shit4 = CreateEntityByName("light_dynamic");
		DispatchKeyValue(shit4, "origin","4 191 -40");
		DispatchKeyValue(shit4, "_light", "200 0 0 255");
		DispatchKeyValue(shit4, "brightness", "1");
		DispatchKeyValue(shit4, "style", "1");
		DispatchKeyValue(shit4, "spotlight_radius", "200");
		DispatchKeyValue(shit4, "distance", "500");
		DispatchSpawn(shit4);
		AcceptEntityInput(shit4, "turnon");
		DispatchKeyValue(shit4, "targetname","torch");
		DispatchKeyValue(shit4, "classname", "torch");
		
		new torch21 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch21, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch21, "origin","960 -880 -45");
		AcceptEntityInput(torch21, "DisableCollision");
		AcceptEntityInput(torch21, "EnableCollision");
		DispatchKeyValue(torch21, "angles","0 90 0");
		DispatchKeyValue(torch21, "solid", "6");
		DispatchSpawn(torch21);
		DispatchKeyValue(torch21, "targetname", "torch");
		DispatchKeyValue(torch21, "classname", "torch");
		
		new torch22 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch22, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch22, "origin","-945 -880 -45");
		AcceptEntityInput(torch22, "DisableCollision");
		AcceptEntityInput(torch22, "EnableCollision");
		DispatchKeyValue(torch22, "angles","0 90 0");
		DispatchKeyValue(torch22, "solid", "6");
		DispatchSpawn(torch22);
		DispatchKeyValue(torch22, "targetname", "torch");
		DispatchKeyValue(torch22, "classname", "torch");
		
		new torch23 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch23, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch23, "origin","-945 -1275 -90");
		AcceptEntityInput(torch23, "DisableCollision");
		AcceptEntityInput(torch23, "EnableCollision");
		DispatchKeyValue(torch23, "angles","0 -90 0");
		DispatchKeyValue(torch23, "solid", "6");
		DispatchSpawn(torch23);
		DispatchKeyValue(torch23, "targetname", "torch");
		DispatchKeyValue(torch23, "classname", "torch");
		
		new torch24 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch24, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch24, "origin","945 -1275 -90");
		AcceptEntityInput(torch24, "DisableCollision");
		AcceptEntityInput(torch24, "EnableCollision");
		DispatchKeyValue(torch24, "angles","0 -90 0");
		DispatchKeyValue(torch24, "solid", "6");
		DispatchSpawn(torch24);
		DispatchKeyValue(torch24, "targetname", "torch");
		DispatchKeyValue(torch24, "classname", "torch");
		
		new torch25 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch25, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch25, "origin","-900 -940 -95");
		AcceptEntityInput(torch25, "DisableCollision");
		AcceptEntityInput(torch25, "EnableCollision");
		DispatchKeyValue(torch25, "angles","0 0 0");
		DispatchKeyValue(torch25, "solid", "6");
		DispatchSpawn(torch25);
		DispatchKeyValue(torch25, "targetname", "torch");
		DispatchKeyValue(torch25, "classname", "torch");
		
		new torch26 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch26, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch26, "origin","900 -940 -95");
		AcceptEntityInput(torch26, "DisableCollision");
		AcceptEntityInput(torch26, "EnableCollision");
		DispatchKeyValue(torch26, "angles","0 180 0");
		DispatchKeyValue(torch26, "solid", "6");
		DispatchSpawn(torch26);
		DispatchKeyValue(torch26, "targetname", "torch");
		DispatchKeyValue(torch26, "classname", "torch");
		
		new torch7 = CreateEntityByName("prop_dynamic");
		SetEntityModel(torch7, "models/vehicles/civ_bus.mdl");
		DispatchKeyValue(torch7, "origin","35 -1570 -10");
		AcceptEntityInput(torch7, "DisableCollision");
		AcceptEntityInput(torch7, "EnableCollision");
		DispatchKeyValue(torch7, "angles","0 90 0");
		DispatchKeyValue(torch7, "solid", "6");
		DispatchSpawn(torch7);
		DispatchKeyValue(torch7, "targetname", "torch");
		DispatchKeyValue(torch7, "classname", "torch");
		
		new torch8 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch8, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch8, "origin","90 -1625 0");
		AcceptEntityInput(torch8, "DisableCollision");
		AcceptEntityInput(torch8, "EnableCollision");
		DispatchKeyValue(torch8, "angles","0 -90 0");
		DispatchKeyValue(torch8, "solid", "6");
		DispatchSpawn(torch8);
		DispatchKeyValue(torch8, "targetname", "torch");
		DispatchKeyValue(torch8, "classname", "torch");
		
		new torch9 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch9, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch9, "origin","-60 -1625 0");
		AcceptEntityInput(torch9, "DisableCollision");
		AcceptEntityInput(torch9, "EnableCollision");
		DispatchKeyValue(torch9, "angles","0 -90 0");
		DispatchKeyValue(torch9, "solid", "6");
		DispatchSpawn(torch9);
		DispatchKeyValue(torch9, "targetname", "torch");
		DispatchKeyValue(torch9, "classname", "torch");
		
		new torch10 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch10, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch10, "origin","15 -1625 0");
		AcceptEntityInput(torch10, "DisableCollision");
		AcceptEntityInput(torch10, "EnableCollision");
		DispatchKeyValue(torch10, "angles","0 -90 0");
		DispatchKeyValue(torch10, "solid", "6");
		DispatchSpawn(torch10);
		DispatchKeyValue(torch10, "targetname", "torch");
		DispatchKeyValue(torch10, "classname", "torch");
		
		new torch11 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch11, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch11, "origin","-40 -1875 -90");
		AcceptEntityInput(torch11, "DisableCollision");
		AcceptEntityInput(torch11, "EnableCollision");
		DispatchKeyValue(torch11, "angles","0 -90 0");
		DispatchKeyValue(torch11, "solid", "6");
		DispatchSpawn(torch11);
		DispatchKeyValue(torch11, "targetname", "torch");
		DispatchKeyValue(torch11, "classname", "torch");
		
		new torch12 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch12, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch12, "origin","15 -1875 -90");
		AcceptEntityInput(torch12, "DisableCollision");
		AcceptEntityInput(torch12, "EnableCollision");
		DispatchKeyValue(torch12, "angles","0 -90 0");
		DispatchKeyValue(torch12, "solid", "6");
		DispatchSpawn(torch12);
		DispatchKeyValue(torch12, "targetname", "torch");
		DispatchKeyValue(torch12, "classname", "torch");
		
		new torch13 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch13, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch13, "origin","70 -1875 -90");
		AcceptEntityInput(torch13, "DisableCollision");
		AcceptEntityInput(torch13, "EnableCollision");
		DispatchKeyValue(torch13, "angles","0 -90 0");
		DispatchKeyValue(torch13, "solid", "6");
		DispatchSpawn(torch13);
		DispatchKeyValue(torch13, "targetname", "torch");
		DispatchKeyValue(torch13, "classname", "torch");
		
		new torch14 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch14, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch14, "origin","-40 -1530 0");
		AcceptEntityInput(torch14, "DisableCollision");
		AcceptEntityInput(torch14, "EnableCollision");
		DispatchKeyValue(torch14, "angles","0 90 0");
		DispatchKeyValue(torch14, "solid", "6");
		DispatchSpawn(torch14);
		DispatchKeyValue(torch14, "targetname", "torch");
		DispatchKeyValue(torch14, "classname", "torch");
		
		new torch15 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch15, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch15, "origin","15 -1530 0");
		AcceptEntityInput(torch15, "DisableCollision");
		AcceptEntityInput(torch15, "EnableCollision");
		DispatchKeyValue(torch15, "angles","0 90 0");
		DispatchKeyValue(torch15, "solid", "6");
		DispatchSpawn(torch15);
		DispatchKeyValue(torch15, "targetname", "torch");
		DispatchKeyValue(torch15, "classname", "torch");
		
		new torch16 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch16, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch16, "origin","70 -1530 0");
		AcceptEntityInput(torch16, "DisableCollision");
		AcceptEntityInput(torch16, "EnableCollision");
		DispatchKeyValue(torch16, "angles","0 90 0");
		DispatchKeyValue(torch16, "solid", "6");
		DispatchSpawn(torch16);
		DispatchKeyValue(torch16, "targetname", "torch");
		DispatchKeyValue(torch16, "classname", "torch");
		
		new torch17 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch17, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch17, "origin","-240 -1540 0");
		AcceptEntityInput(torch17, "DisableCollision");
		AcceptEntityInput(torch17, "EnableCollision");
		DispatchKeyValue(torch17, "angles","0 180 0");
		DispatchKeyValue(torch17, "solid", "6");
		DispatchSpawn(torch17);
		DispatchKeyValue(torch17, "targetname", "torch");
		DispatchKeyValue(torch17, "classname", "torch");
		
		new torch18 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch18, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch18, "origin","-240 -1600 0");
		AcceptEntityInput(torch18, "DisableCollision");
		AcceptEntityInput(torch18, "EnableCollision");
		DispatchKeyValue(torch18, "angles","0 180 0");
		DispatchKeyValue(torch18, "solid", "6");
		DispatchSpawn(torch18);
		DispatchKeyValue(torch18, "targetname", "torch");
		DispatchKeyValue(torch18, "classname", "torch");
		
		new torch19 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch19, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch19, "origin","350 -1540 0");
		AcceptEntityInput(torch19, "DisableCollision");
		AcceptEntityInput(torch19, "EnableCollision");
		DispatchKeyValue(torch19, "angles","0 0 0");
		DispatchKeyValue(torch19, "solid", "6");
		DispatchSpawn(torch19);
		DispatchKeyValue(torch19, "targetname", "torch");
		DispatchKeyValue(torch19, "classname", "torch");
		
		new torch20 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch20, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch20, "origin","350 -1600 0");
		AcceptEntityInput(torch20, "DisableCollision");
		AcceptEntityInput(torch20, "EnableCollision");
		DispatchKeyValue(torch20, "angles","0 0 0");
		DispatchKeyValue(torch20, "solid", "6");
		DispatchSpawn(torch20);
		DispatchKeyValue(torch20, "targetname", "torch");
		DispatchKeyValue(torch20, "classname", "torch");
		
		
		
		//doors blocked
		
		new blockade01 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade01, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade01, "origin","1800 -1780 35");
		AcceptEntityInput(blockade01, "DisableCollision");
		AcceptEntityInput(blockade01, "EnableCollision");
		DispatchKeyValue(blockade01, "angles","0 90 0");
		DispatchKeyValue(blockade01, "solid", "6");
		DispatchSpawn(blockade01);
		DispatchKeyValue(blockade01, "targetname", "ls");
		DispatchKeyValue(blockade01, "classname", "ls");
		
		new blockade02 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade02, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade02, "origin","1800 -2060 35");
		AcceptEntityInput(blockade02, "DisableCollision");
		AcceptEntityInput(blockade02, "EnableCollision");
		DispatchKeyValue(blockade02, "angles","0 -90 0");
		DispatchKeyValue(blockade02, "solid", "6");
		DispatchSpawn(blockade02);
		DispatchKeyValue(blockade02, "targetname", "ls");
		DispatchKeyValue(blockade02, "classname", "ls");
		
		new blockade03 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade03, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade03, "origin","915 -2600 45");
		AcceptEntityInput(blockade03, "DisableCollision");
		AcceptEntityInput(blockade03, "EnableCollision");
		DispatchKeyValue(blockade03, "angles","0 -90 0");
		DispatchKeyValue(blockade03, "solid", "6");
		DispatchSpawn(blockade03);
		DispatchKeyValue(blockade03, "targetname", "ls");
		DispatchKeyValue(blockade03, "classname", "ls");
		
		new blockade04 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade04, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade04, "origin","620 -2600 45");
		AcceptEntityInput(blockade04, "DisableCollision");
		AcceptEntityInput(blockade04, "EnableCollision");
		DispatchKeyValue(blockade04, "angles","0 -90 0");
		DispatchKeyValue(blockade04, "solid", "6");
		DispatchSpawn(blockade04);
		DispatchKeyValue(blockade04, "targetname", "ls");
		DispatchKeyValue(blockade04, "classname", "ls");
		
		new blockade05 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade05, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade05, "origin","500 -2460 45");
		AcceptEntityInput(blockade05, "DisableCollision");
		AcceptEntityInput(blockade05, "EnableCollision");
		DispatchKeyValue(blockade05, "angles","0 180 0");
		DispatchKeyValue(blockade05, "solid", "6");
		DispatchSpawn(blockade05);
		DispatchKeyValue(blockade05, "targetname", "ls");
		DispatchKeyValue(blockade05, "classname", "ls");
		
		new blockade06 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade06, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade06, "origin","380 -2330 45");
		AcceptEntityInput(blockade06, "DisableCollision");
		AcceptEntityInput(blockade06, "EnableCollision");
		DispatchKeyValue(blockade06, "angles","0 -90 0");
		DispatchKeyValue(blockade06, "solid", "6");
		DispatchSpawn(blockade06);
		DispatchKeyValue(blockade06, "targetname", "ls");
		DispatchKeyValue(blockade06, "classname", "ls");
		
		new blockade07 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade07, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade07, "origin","120 -2330 0");
		AcceptEntityInput(blockade07, "DisableCollision");
		AcceptEntityInput(blockade07, "EnableCollision");
		DispatchKeyValue(blockade07, "angles","0 -90 0");
		DispatchKeyValue(blockade07, "solid", "6");
		DispatchSpawn(blockade07);
		DispatchKeyValue(blockade07, "targetname", "ls");
		DispatchKeyValue(blockade07, "classname", "ls");
		
		new blockade08 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade08, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade08, "origin","-5 -2330 0");
		AcceptEntityInput(blockade08, "DisableCollision");
		AcceptEntityInput(blockade08, "EnableCollision");
		DispatchKeyValue(blockade08, "angles","0 -90 0");
		DispatchKeyValue(blockade08, "solid", "6");
		DispatchSpawn(blockade08);
		DispatchKeyValue(blockade08, "targetname", "ls");
		DispatchKeyValue(blockade08, "classname", "ls");
		
		new blockade09 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade09, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade09, "origin","-125 -2330 0");
		AcceptEntityInput(blockade09, "DisableCollision");
		AcceptEntityInput(blockade09, "EnableCollision");
		DispatchKeyValue(blockade09, "angles","0 -90 0");
		DispatchKeyValue(blockade09, "solid", "6");
		DispatchSpawn(blockade09);
		DispatchKeyValue(blockade09, "targetname", "ls");
		DispatchKeyValue(blockade09, "classname", "ls");
		
		new blockade10 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade10, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade10, "origin","-375 -2330 45");
		AcceptEntityInput(blockade10, "DisableCollision");
		AcceptEntityInput(blockade10, "EnableCollision");
		DispatchKeyValue(blockade10, "angles","0 -90 0");
		DispatchKeyValue(blockade10, "solid", "6");
		DispatchSpawn(blockade10);
		DispatchKeyValue(blockade10, "targetname", "ls");
		DispatchKeyValue(blockade10, "classname", "ls");

		new blockade11 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade11, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade11, "origin","-500 -2460 45");
		AcceptEntityInput(blockade11, "DisableCollision");
		AcceptEntityInput(blockade11, "EnableCollision");
		DispatchKeyValue(blockade11, "angles","0 0 0");
		DispatchKeyValue(blockade11, "solid", "6");
		DispatchSpawn(blockade11);
		DispatchKeyValue(blockade11, "targetname", "ls");
		DispatchKeyValue(blockade11, "classname", "ls");
		
		new blockade12 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade12, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade12, "origin","-620 -2600 45");
		AcceptEntityInput(blockade12, "DisableCollision");
		AcceptEntityInput(blockade12, "EnableCollision");
		DispatchKeyValue(blockade12, "angles","0 -90 0");
		DispatchKeyValue(blockade12, "solid", "6");
		DispatchSpawn(blockade12);
		DispatchKeyValue(blockade12, "targetname", "ls");
		DispatchKeyValue(blockade12, "classname", "ls");
		
		new blockade13 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade13, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade13, "origin","-915 -2600 45");
		AcceptEntityInput(blockade13, "DisableCollision");
		AcceptEntityInput(blockade13, "EnableCollision");
		DispatchKeyValue(blockade13, "angles","0 -90 0");
		DispatchKeyValue(blockade13, "solid", "6");
		DispatchSpawn(blockade13);
		DispatchKeyValue(blockade13, "targetname", "ls");
		DispatchKeyValue(blockade13, "classname", "ls");
		
		new blockade14 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade14, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade14, "origin","-1800 -2060 30");
		AcceptEntityInput(blockade14, "DisableCollision");
		AcceptEntityInput(blockade14, "EnableCollision");
		DispatchKeyValue(blockade14, "angles","0 -90 0");
		DispatchKeyValue(blockade14, "solid", "6");
		DispatchSpawn(blockade14);
		DispatchKeyValue(blockade14, "targetname", "ls");
		DispatchKeyValue(blockade14, "classname", "ls");		
		
		new blockade15 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade15, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade15, "origin","-1800 -1780 30");
		AcceptEntityInput(blockade15, "DisableCollision");
		AcceptEntityInput(blockade15, "EnableCollision");
		DispatchKeyValue(blockade15, "angles","0 90 0");
		DispatchKeyValue(blockade15, "solid", "6");
		DispatchSpawn(blockade15);
		DispatchKeyValue(blockade15, "targetname", "ls");
		DispatchKeyValue(blockade15, "classname", "ls");		
		
		
		new blockade16 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade16, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade16, "origin","-320 -390 -50");
		AcceptEntityInput(blockade16, "DisableCollision");
		AcceptEntityInput(blockade16, "EnableCollision");
		DispatchKeyValue(blockade16, "angles","0 90 0");
		DispatchKeyValue(blockade16, "solid", "6");
		DispatchSpawn(blockade16);
		DispatchKeyValue(blockade16, "targetname", "ls");
		DispatchKeyValue(blockade16, "classname", "ls");

		new blockade17 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade17, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade17, "origin","320 -390 -50");
		AcceptEntityInput(blockade17, "DisableCollision");
		AcceptEntityInput(blockade17, "EnableCollision");
		DispatchKeyValue(blockade17, "angles","0 90 0");
		DispatchKeyValue(blockade17, "solid", "6");
		DispatchSpawn(blockade17);
		DispatchKeyValue(blockade17, "targetname", "ls");
		DispatchKeyValue(blockade17, "classname", "ls");
		
		new blockade18 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade18, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade18, "origin","-320 -260 180");
		AcceptEntityInput(blockade18, "DisableCollision");
		AcceptEntityInput(blockade18, "EnableCollision");
		DispatchKeyValue(blockade18, "angles","0 90 0");
		DispatchKeyValue(blockade18, "solid", "6");
		DispatchSpawn(blockade18);
		DispatchKeyValue(blockade18, "targetname", "ls");
		DispatchKeyValue(blockade18, "classname", "ls");
		
		new blockade19 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade19, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade19, "origin","320 -260 180");
		AcceptEntityInput(blockade19, "DisableCollision");
		AcceptEntityInput(blockade19, "EnableCollision");
		DispatchKeyValue(blockade19, "angles","0 90 0");
		DispatchKeyValue(blockade19, "solid", "6");
		DispatchSpawn(blockade19);
		DispatchKeyValue(blockade19, "targetname", "ls");
		DispatchKeyValue(blockade19, "classname", "ls");
		
		new blockade20 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade20, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade20, "origin","380 -2330 -185");
		AcceptEntityInput(blockade20, "DisableCollision");
		AcceptEntityInput(blockade20, "EnableCollision");
		DispatchKeyValue(blockade20, "angles","0 90 0");
		DispatchKeyValue(blockade20, "solid", "6");
		DispatchSpawn(blockade20);
		DispatchKeyValue(blockade20, "targetname", "ls");
		DispatchKeyValue(blockade20, "classname", "ls");

		new blockade21 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(blockade21, "models/static_fortifications/mog_metal_wall_01s.mdl");
		DispatchKeyValue(blockade21, "origin","-380 -2330 -185");
		AcceptEntityInput(blockade21, "DisableCollision");
		AcceptEntityInput(blockade21, "EnableCollision");
		DispatchKeyValue(blockade21, "angles","0 90 0");
		DispatchKeyValue(blockade21, "solid", "6");
		DispatchSpawn(blockade21);
		DispatchKeyValue(blockade21, "targetname", "ls");
		DispatchKeyValue(blockade21, "classname", "ls");
		
		//ServerCommand("sm_trigger ls DisableCollision");
		ServerCommand("sm_trigger ls kill");
		
		//A Stairs
		
		new torch27 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch27, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch27, "origin","2140 -1845 30");
		AcceptEntityInput(torch27, "DisableCollision");
		AcceptEntityInput(torch27, "EnableCollision");
		DispatchKeyValue(torch27, "angles","0 90 0");
		DispatchKeyValue(torch27, "solid", "6");
		DispatchSpawn(torch27);
		DispatchKeyValue(torch27, "targetname", "torch");
		DispatchKeyValue(torch27, "classname", "torch");
		
		new torch28 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch28, "models/static_afghan/prop_panj_stairs.mdl");
		DispatchKeyValue(torch28, "origin","2140 -2050 165");
		AcceptEntityInput(torch28, "DisableCollision");
		AcceptEntityInput(torch28, "EnableCollision");
		DispatchKeyValue(torch28, "angles","0 90 0");
		DispatchKeyValue(torch28, "solid", "6");
		DispatchSpawn(torch28);
		DispatchKeyValue(torch28, "targetname", "torch");
		DispatchKeyValue(torch28, "classname", "torch");
		
		new torch29 = CreateEntityByName("prop_dynamic_override");
		SetEntityModel(torch29, "models/dynamic_props/mobile_toilet_stw_phys.mdl");
		DispatchKeyValue(torch29, "origin","2030 -2030 185");
		AcceptEntityInput(torch29, "DisableCollision");
		AcceptEntityInput(torch29, "EnableCollision");
		DispatchKeyValue(torch29, "angles","55 30 0");
		DispatchKeyValue(torch29, "solid", "6");
		SetEntityRenderColor(torch29, 0,0,0,0);
		DispatchSpawn(torch29);
		DispatchKeyValue(torch29, "targetname", "torch");
		DispatchKeyValue(torch29, "classname", "torch");
		
		new torch30 = CreateEntityByName("light_dynamic");
		DispatchKeyValue(torch30, "origin","2000 -2015 230");
		DispatchKeyValue(torch30, "_light", "200 255 200 255");
		DispatchKeyValue(torch30, "brightness", "1");
		DispatchKeyValue(torch30, "style", "1");
		DispatchKeyValue(torch30, "spotlight_radius", "200");
		DispatchKeyValue(torch30, "distance", "500");
		DispatchSpawn(torch30);
		AcceptEntityInput(torch30, "turnon");
		DispatchKeyValue(torch30, "targetname","torchy");
		DispatchKeyValue(torch30, "classname", "torchy");
}