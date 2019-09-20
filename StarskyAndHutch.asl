state("StarskyPC")
{
	//This always has a value of 0x54B38000 when on mission select and changes when you select an episode.
	//Not sure what the value actually represents but it works for this purpose.
	uint StartThing : "StarskyPC.exe", 0x2A55FC;
	
	uint SelectedEpisode : "StarskyPC.exe", 0x2A55EC;
	uint SelectedSeason : "StarskyPC.exe", 0x2A5548;
	
	//Text from the prefix of mission cars. Used to check which mission the player is currently on.
	string4 S1E1Text : "StarskyPC.exe", 0x28DC6C;
	string4 S1E2Text : "StarskyPC.exe", 0x28D84C;
	string4 S1E3Text : "StarskyPC.exe", 0x28F26C;
	string4 S1E4Text : "StarskyPC.exe", 0x28F52C;
	string4 S1E5Text : "StarskyPC.exe", 0x28D58C;
	string4 S1E6Text : "StarskyPC.exe", 0x28CA8C;
	
	string4 S2E1Text : "StarskyPC.exe", 0x2909CC;
	string4 S2E2Text : "StarskyPC.exe", 0x2910AC;
	string4 S2E3Text : "StarskyPC.exe", 0x28FC0C;
	string4 S2E4Text : "StarskyPC.exe", 0x28E8CC;
	string4 S2E5Text : "StarskyPC.exe", 0x28CD52;
	string4 S2E6Text : "StarskyPC.exe", 0x29002C;
	
	string4 S3E1Text : "StarskyPC.exe", 0x28F7EC;
	string4 S3E2Text : "StarskyPC.exe", 0x28DC6C;
	string4 S3E3Text : "StarskyPC.exe", 0x29044C;
	string4 S3E4Text : "StarskyPC.exe", 0x28E76C;
	string4 S3E5Text : "StarskyPC.exe", 0x28DF2C;
	string4 S3E6Text : "StarskyPC.exe", 0x28F26C;
	
	//Car status flags/enum thing. 0x40 means it is destroyed.
	byte S1E1CarStatus : "StarskyPC.exe", 0x28DC91;
	byte S1E3CarStatus : "StarskyPC.exe", 0x28F291;
	byte S1E2CarStatus : "StarskyPC.exe", 0x28D871;
	byte S1E4CarStatus : "StarskyPC.exe", 0x28F551;
	byte S1E5Car1Status : "StarskyPC.exe", 0x28D2F1;
	byte S1E5Car2Status : "StarskyPC.exe", 0x28D191;
	byte S1E6CarStatus : "StarskyPC.exe", 0x28CAB1;
	
	byte S2E1CarStatus : "StarskyPC.exe", 0x2909F1;
	byte S2E2CarStatus : "StarskyPC.exe", 0x2910D1;
	byte S2E4CarStatus : "StarskyPC.exe", 0x28E8F1;
	byte S2E6CarStatus : "StarskyPC.exe", 0x290051;
	
	byte S3E1CarStatus : "StarskyPC.exe", 0x28F811;
	byte S3E2Car1Status : "StarskyPC.exe", 0x28DC91;
	byte S3E2Car2Status : "StarskyPC.exe", 0x28DF51;
	byte S3E2Car3Status : "StarskyPC.exe", 0x28E0B1;
	byte S3E3CarStatus : "StarskyPC.exe", 0x290471;
	byte S3E5CarStatus : "StarskyPC.exe", 0x28DF51;
	byte S3E6CarStatus : "StarskyPC.exe", 0x28F291;
	
	//This works but I'm a bit skeptical of it.
	//TODO: Look into the mission script for a RouteStage value.
	byte S1E5SafeHouseStatus : "StarskyPC.exe", 0x28C3D0;
	
	//Increments over the course of the mission. Is set to 4 when the car reaches the airport waypoint.
	byte S2E3RouteStage : "StarskyPC.exe", 0x26FA88, 0x164, 0x64, 0x38, 0x4;
	
	//Set to 1 when the mincer is deactivated.
	byte S2E5MincerOff : "StarskyPC.exe", 0x26FA88, 0x1F8, 0x64, 0x14, 0x4;
	
	//Goes from 0-4 over the course of the mission, but reaches 4 before the senator arrives, so must be checked in conjunction with "repetitions".
	byte S3E4RouteStage : "StarskyPC.exe", 0x26FA88, 0x184, 0x64, 0xB0, 0x4;
	//Idk where "repetitions" comes from, that's just what the game calls it. Goes from 1 to 0 when the senator reaches her destination.
	byte S3E4Repetitions : "StarskyPC.exe", 0x26FA88, 0x184, 0x64, 0xB0, 0x164;
	
	//Set to 255 upon activating the 18 wheeler.
	byte S3E6GunmenLeft : "StarskyPC.exe", 0x292238;
}

startup
{
	refreshRate = 30;
	
	settings.Add("season1", false, "Season 1");
	settings.Add("s1e1", true, "Fast Cars", "season1");
	settings.Add("s1e2", true, "Special Withdrawal", "season1");
	settings.Add("s1e3", true, "Bay City Heatwave", "season1");
	settings.Add("s1e4", true, "Middle Man", "season1");
	settings.Add("s1e5", true, "Squealing Piggy", "season1");
	settings.Add("s1e6", true, "A Little Mayhem", "season1");
	
	settings.Add("season2", false, "Season 2");
	settings.Add("s2e1", true, "Not So Easy Rider", "season2");
	settings.Add("s2e2", true, "Swann Dive", "season2");
	settings.Add("s2e3", true, "Departure Gates", "season2");
	settings.Add("s2e4", true, "Wheels With Wheels", "season2");
	settings.Add("s2e5", true, "The Big Score Part 1", "season2");
	settings.Add("s2e6", true, "The Big Score Part 2", "season2");
	
	settings.Add("season3", false, "Season 3");
	settings.Add("s3e1", true, "Breakout", "season3");
	settings.Add("s3e2", true, "Parking Ticket", "season3");
	settings.Add("s3e3", true, "Hot Tomato", "season3");
	settings.Add("s3e4", true, "Save the Senator", "season3");
	settings.Add("s3e5", true, "Bomb Surprise", "season3");
	settings.Add("s3e6", true, "18 Wheels of Trouble", "season3");
}

start
{
	if(settings["season1"] && current.SelectedSeason == 0 && current.SelectedEpisode == 0 && old.StartThing == 0x43B38000 && current.StartThing != 0x43B38000)
		return true;
	
	if(settings["season2"] && current.SelectedSeason == 1 && current.SelectedEpisode == 0 && old.StartThing == 0x43B38000 && current.StartThing != 0x43B38000)
		return true;
	
	if(settings["season3"] && current.SelectedSeason == 2 && current.SelectedEpisode == 0 && old.StartThing == 0x43B38000 && current.StartThing != 0x43B38000)
		return true;
}

reset
{
	if(settings["season1"] && current.SelectedSeason == 0 && current.SelectedEpisode == 0 && old.StartThing == 0x43B38000 && current.StartThing != 0x43B38000)
		return true;
	
	if(settings["season2"] && current.SelectedSeason == 1 && current.SelectedEpisode == 0 && old.StartThing == 0x43B38000 && current.StartThing != 0x43B38000)
		return true;
	
	if(settings["season3"] && current.SelectedSeason == 2 && current.SelectedEpisode == 0 && old.StartThing == 0x43B38000 && current.StartThing != 0x43B38000)
		return true;
}

split
{
	if(settings["season1"])
	{
		if(settings["s1e1"] && current.S1E1Text.ToLower() == "s1e1" && current.S1E1CarStatus == (old.S1E1CarStatus + 0x40))
			return true;
		
		if(settings["s1e2"] && current.S1E2Text.ToLower() == "s1e2" && current.S1E2CarStatus == (old.S1E2CarStatus + 0x40))
			return true;
		
		if(settings["s1e3"] && current.S1E3Text.ToLower() == "s1e3" && current.S1E3CarStatus == (old.S1E3CarStatus + 0x40))
			return true;
		
		if(settings["s1e4"] && current.S1E4Text.ToLower() == "s1e4" && current.S1E4CarStatus == (old.S1E4CarStatus + 0x40))
			return true;
		
		if(settings["s1e5"] && current.S1E5Text.ToLower() == "s1e5" && (current.S1E5Car1Status & 0x40) != 0 && (current.S1E5Car2Status & 0x40) != 0 && old.S1E5SafeHouseStatus == 0x3C && current.S1E5SafeHouseStatus == 0x38)
			return true;
		
		if(settings["s1e6"] && current.S1E6Text.ToLower() == "s1e6" && current.S1E6CarStatus == (old.S1E6CarStatus + 0x40))
			return true;
	}
	
	if(settings["season2"])
	{
		if(settings["s2e1"] && current.S2E1Text.ToLower() == "s2e1" && current.S2E1CarStatus == (old.S2E1CarStatus + 0x40))
			return true;
		
		if(settings["s2e2"] && current.S2E2Text.ToLower() == "s2e2" && current.S2E2CarStatus == (old.S2E2CarStatus + 0x40))
			return true;
		
		if(settings["s2e3"] && current.S2E3Text.ToLower() == "s2e3")
		{
			print(current.S2E3RouteStage.ToString());
		}
		
		if(settings["s2e3"] && current.S2E3Text.ToLower() == "s2e3" && current.S2E3RouteStage == 4 && old.S2E3RouteStage == 3)
			return true;
		
		if(settings["s2e4"] && current.S2E4Text.ToLower() == "s2e4" && current.S2E4CarStatus == (old.S2E4CarStatus + 0x40))
			return true;
		
		if(settings["s2e5"] && current.S2E5Text.ToLower() == "s2e5" && current.S2E5MincerOff == 1 && old.S2E5MincerOff == 0)
			return true;
		
		if(settings["s2e6"] && current.S2E6Text.ToLower() == "s2e6" && current.S2E6CarStatus == (old.S2E6CarStatus + 0x40))
			return true;
	}
	
	if(settings["season3"])
	{
		if(settings["s3e1"] && current.S3E1Text.ToLower() == "s3e1" && current.S3E1CarStatus == (old.S3E1CarStatus + 0x40))
			return true;
		
		if(settings["s3e2"] && current.S3E2Text.ToLower() == "s3e2" && (current.S3E2Car1Status & 0x40) > 0 && (current.S3E2Car2Status & 0x40) > 0 && (current.S3E2Car3Status & 0x40) > 0)
		{
			if(current.S3E2Car1Status == (old.S3E2Car1Status + 0x40) || current.S3E2Car2Status == (old.S3E2Car2Status + 0x40) || current.S3E2Car3Status == (old.S3E2Car3Status + 0x40))
				return true;
		}
		
		if(settings["s3e3"] && current.S3E3Text.ToLower() == "s3e3" && current.S3E3CarStatus == (old.S3E3CarStatus + 0x40))
			return true;
		
		if(settings["s3e4"] && current.S3E4Text.ToLower() == "s3e4" && current.S3E4RouteStage == 4 && current.S3E4Repetitions == 0 && old.S3E4Repetitions == 1)
			return true;
		
		if(settings["s3e5"] && current.S3E5Text.ToLower() == "s3e5" && current.S3E5CarStatus == (old.S3E5CarStatus + 0x40))
			return true;
		
		if(settings["s3e6"] && current.S3E6Text.ToLower() == "s3e6" && current.S3E6GunmenLeft == 0xFF && current.S3E6CarStatus == (old.S3E6CarStatus + 0x40))
			return true;
	}
}
