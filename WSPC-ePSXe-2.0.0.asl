//Autosplitter for version 2.0.0 of ePSXe.

state("ePSXe")
{
	/*-----Pursuit Mode-----*/
	//Bit field for the missions completed (Any%) and commendations earned (100%).
	uint missionsComplete : "ePSXe.exe", 0x9160E0;
	uint commendationsEarned : "ePSXe.exe", 0x9160CC;
	
	//Used for starting/resetting the timer when you press end after typing a name.
	//I don't know what the value is used for, but it works.
	uint endButtonPressed : "ePSXe.exe", 0x926920;
	
	
	/*-----Patrol Mode-----*/
	//Number of criminals caught.
	uint numCriminals : "ePSXe.exe", 0x952C5C;
	
	//Used for starting/resetting the timer when you choose your car.
	//No idea if this is what the value is actually used for, but it works.
	uint carSelected : "ePSXe.exe", 0x952C88;
}

startup
{
	//Pursuit Mode (Any%)
	settings.Add("pursuit_mode_any", false, "Pursuit Mode (Any%)");
	settings.Add("pursuit1a", true, "Pursuit Course", "pursuit_mode_any");
	settings.Add("pursuit2a", true, "Basic Pursuit", "pursuit_mode_any");
	settings.Add("pursuit3a", true, "Advanced Pursuit", "pursuit_mode_any");
	settings.Add("pursuit4a", true, "Expert Pursuit", "pursuit_mode_any");
	settings.Add("pursuit5a", true, "DUI Dummy", "pursuit_mode_any");
	settings.Add("pursuit6a", true, "Crazed Car Thief", "pursuit_mode_any");
	settings.Add("pursuit7a", true, "Gangbanger Deathmatch", "pursuit_mode_any");
	settings.Add("pursuit8a", true, "Bus Driver Gone Bad", "pursuit_mode_any");
	settings.Add("pursuit9a", true, "Drug Smuggling Scum", "pursuit_mode_any");
	settings.Add("pursuit10a", true, "Race Against Death", "pursuit_mode_any");
	settings.Add("pursuit11a", true, "Sentence of Fire", "pursuit_mode_any");
	settings.Add("pursuit12a", true, "Nosey News Van", "pursuit_mode_any");
	settings.Add("pursuit13a", true, "The Stool Pigeon", "pursuit_mode_any");
	settings.Add("pursuit14a", true, "Tank Rush", "pursuit_mode_any");
	settings.Add("pursuit15a", true, "Nothing Is Ever Routine", "pursuit_mode_any");
	settings.Add("pursuit16a", true, "Jacked-Up Jailbird", "pursuit_mode_any");
	settings.Add("pursuit17a", true, "Lou Ferris Returns", "pursuit_mode_any");
	settings.Add("pursuit18a", true, "Brazen Bank Bandits", "pursuit_mode_any");
	settings.Add("pursuit19a", true, "30 Minutes Or Less", "pursuit_mode_any");
	settings.Add("pursuit20a", true, "Final Showdown", "pursuit_mode_any");
	
	//Pursuit Mode (100%)
	settings.Add("pursuit_mode_100", false, "Pursuit Mode (100%)");
	settings.Add("pursuit1h", true, "Pursuit Course", "pursuit_mode_100");
	settings.Add("pursuit2h", true, "Basic Pursuit", "pursuit_mode_100");
	settings.Add("pursuit3h", true, "Advanced Pursuit", "pursuit_mode_100");
	settings.Add("pursuit4h", true, "Expert Pursuit", "pursuit_mode_100");
	settings.Add("pursuit5h", true, "DUI Dummy", "pursuit_mode_100");
	settings.Add("pursuit6h", true, "Crazed Car Thief", "pursuit_mode_100");
	settings.Add("pursuit7h", true, "Gangbanger Deathmatch", "pursuit_mode_100");
	settings.Add("pursuit8h", true, "Bus Driver Gone Bad", "pursuit_mode_100");
	settings.Add("pursuit9h", true, "Drug Smuggling Scum", "pursuit_mode_100");
	settings.Add("pursuit10h", true, "Race Against Death", "pursuit_mode_100");
	settings.Add("pursuit11h", true, "Sentence of Fire", "pursuit_mode_100");
	settings.Add("pursuit12h", true, "Nosey News Van", "pursuit_mode_100");
	settings.Add("pursuit13h", true, "The Stool Pigeon", "pursuit_mode_100");
	settings.Add("pursuit14h", true, "Tank Rush", "pursuit_mode_100");
	settings.Add("pursuit15h", true, "Nothing Is Ever Routine", "pursuit_mode_100");
	settings.Add("pursuit16h", true, "Jacked-Up Jailbird", "pursuit_mode_100");
	settings.Add("pursuit17h", true, "Lou Ferris Returns", "pursuit_mode_100");
	settings.Add("pursuit18h", true, "Brazen Bank Bandits", "pursuit_mode_100");
	settings.Add("pursuit19h", true, "30 Minutes Or Less", "pursuit_mode_100");
	settings.Add("pursuit20h", true, "Final Showdown", "pursuit_mode_100");
	
	//Patrol Mode (10, 25, 50, 100 Criminals and Tank%)
	settings.Add("patrol_mode", false, "Patrol Mode");
	settings.Add("criminals10", true, "10 Criminals", "patrol_mode");
	settings.Add("criminals25", true, "25 Criminals", "patrol_mode");
	settings.Add("criminals50", true, "50 Criminals", "patrol_mode");
	settings.Add("criminals100", true, "100 Criminals", "patrol_mode");
}

start
{
	if((settings["pursuit_mode_any"] || settings["pursuit_mode_100"]) && current.endButtonPressed == 0 && old.endButtonPressed == 2148635012)
		return true;
	
	if(settings["patrol_mode"] && current.numCriminals == 0 && current.carSelected == 1 && old.carSelected == 0)
		return true;
}

reset
{
	if((settings["pursuit_mode_any"] || settings["pursuit_mode_100"]) && current.endButtonPressed == 0 && old.endButtonPressed == 2148635012)
		return true;
	
	if(settings["patrol_mode"] && current.numCriminals == 0 && current.carSelected == 1 && old.carSelected == 0)
		return true;
}

split
{
	if(settings["pursuit_mode_any"])
	{
		//1. Pursuit Course
		if(settings["pursuit1a"] && current.missionsComplete == 0x1 && old.missionsComplete == 0x0)
			return true;
		
		//2. Basic Pursuit
		if(settings["pursuit2a"] && current.missionsComplete == 0x3 && old.missionsComplete == 0x1)
			return true;
		
		//3. Advanced Pursuit
		if(settings["pursuit3a"] && current.missionsComplete == 0x7 && old.missionsComplete == 0x3)
			return true;
		
		//4. Expert Pursuit
		if(settings["pursuit4a"] && current.missionsComplete == 0xF && old.missionsComplete == 0x7)
			return true;
		
		//5. DUI Dummy
		if(settings["pursuit5a"] && current.missionsComplete == 0x1F && old.missionsComplete == 0xF)
			return true;
		
		//6. Crazed Car Thief
		if(settings["pursuit6a"] && current.missionsComplete == 0x3F && old.missionsComplete == 0x1F)
			return true;
		
		//7. Gangbanger Deathmatch
		if(settings["pursuit7a"] && current.missionsComplete == 0x7F && old.missionsComplete == 0x3F)
			return true;
		
		//8. Bus Driver Gone Bad
		if(settings["pursuit8a"] && current.missionsComplete == 0xFF && old.missionsComplete == 0x7F)
			return true;
		
		//9. Drug Smuggling Scum
		if(settings["pursuit9a"] && current.missionsComplete == 0x1FF && old.missionsComplete == 0xFF)
			return true;
		
		//10. Race Against Death
		if(settings["pursuit10a"] && current.missionsComplete == 0x3FF && old.missionsComplete == 0x1FF)
			return true;
		
		//11. Sentence of Fire
		if(settings["pursuit11a"] && current.missionsComplete == 0x7FF && old.missionsComplete == 0x3FF)
			return true;
		
		//12. Nosey News Van
		if(settings["pursuit12a"] && current.missionsComplete == 0xFFF && old.missionsComplete == 0x7FF)
			return true;
		
		//13. The Stool Pigeon
		if(settings["pursuit13a"] && current.missionsComplete == 0x1FFF && old.missionsComplete == 0xFFF)
			return true;
		
		//14. Tank Rush
		if(settings["pursuit14a"] && current.missionsComplete == 0x3FFF && old.missionsComplete == 0x1FFF)
			return true;
		
		//15. Nothing Is Ever Routine
		if(settings["pursuit15a"] && current.missionsComplete == 0x7FFF && old.missionsComplete == 0x3FFF)
			return true;
		
		//16. Jacked-Up Jailbird
		if(settings["pursuit16a"] && current.missionsComplete == 0xFFFF && old.missionsComplete == 0x7FFF)
			return true;
		
		//17. Lou Ferris Returns
		if(settings["pursuit17a"] && current.missionsComplete == 0x1FFFF && old.missionsComplete == 0xFFFF)
			return true;
		
		//18. Brazen Bank Bandits
		if(settings["pursuit18a"] && current.missionsComplete == 0x3FFFF && old.missionsComplete == 0x1FFFF)
			return true;
		
		//19. 30 Minutes Or Less
		if(settings["pursuit19a"] && current.missionsComplete == 0x7FFFF && old.missionsComplete == 0x3FFFF)
			return true;
		
		//20. Final Showdown
		if(settings["pursuit20a"] && current.missionsComplete == 0xFFFFF && old.missionsComplete == 0x7FFFF)
			return true;
	}
	
	if(settings["pursuit_mode_100"])
	{
		//1. Pursuit Course
		if(settings["pursuit1h"] && current.commendationsEarned == 0x1 && old.commendationsEarned == 0x0)
			return true;
		
		//2. Basic Pursuit
		if(settings["pursuit2h"] && current.commendationsEarned == 0x3 && old.commendationsEarned == 0x1)
			return true;
		
		//3. Advanced Pursuit
		if(settings["pursuit3h"] && current.commendationsEarned == 0x7 && old.commendationsEarned == 0x3)
			return true;
		
		//4. Expert Pursuit
		if(settings["pursuit4h"] && current.commendationsEarned == 0xF && old.commendationsEarned == 0x7)
			return true;
		
		//5. DUI Dummy
		if(settings["pursuit5h"] && current.commendationsEarned == 0x1F && old.commendationsEarned == 0xF)
			return true;
		
		//6. Crazed Car Thief
		if(settings["pursuit6h"] && current.commendationsEarned == 0x3F && old.commendationsEarned == 0x1F)
			return true;
		
		//7. Gangbanger Deathmatch
		if(settings["pursuit7h"] && current.commendationsEarned == 0x7F && old.commendationsEarned == 0x3F)
			return true;
		
		//8. Bus Driver Gone Bad
		if(settings["pursuit8h"] && current.commendationsEarned == 0xFF && old.commendationsEarned == 0x7F)
			return true;
		
		//9. Drug Smuggling Scum
		if(settings["pursuit9h"] && current.commendationsEarned == 0x1FF && old.commendationsEarned == 0xFF)
			return true;
		
		//10. Race Against Death
		if(settings["pursuit10h"] && current.commendationsEarned == 0x3FF && old.commendationsEarned == 0x1FF)
			return true;
		
		//11. Sentence of Fire
		if(settings["pursuit11h"] && current.commendationsEarned == 0x7FF && old.commendationsEarned == 0x3FF)
			return true;
		
		//12. Nosey News Van
		if(settings["pursuit12h"] && current.commendationsEarned == 0xFFF && old.commendationsEarned == 0x7FF)
			return true;
		
		//13. The Stool Pigeon
		if(settings["pursuit13h"] && current.commendationsEarned == 0x1FFF && old.commendationsEarned == 0xFFF)
			return true;
		
		//14. Tank Rush
		if(settings["pursuit14h"] && current.commendationsEarned == 0x3FFF && old.commendationsEarned == 0x1FFF)
			return true;
		
		//15. Nothing Is Ever Routine
		if(settings["pursuit15h"] && current.commendationsEarned == 0x7FFF && old.commendationsEarned == 0x3FFF)
			return true;
		
		//16. Jacked-Up Jailbird
		if(settings["pursuit16h"] && current.commendationsEarned == 0xFFFF && old.commendationsEarned == 0x7FFF)
			return true;
		
		//17. Lou Ferris Returns
		if(settings["pursuit17h"] && current.commendationsEarned == 0x1FFFF && old.commendationsEarned == 0xFFFF)
			return true;
		
		//18. Brazen Bank Bandits
		if(settings["pursuit18h"] && current.commendationsEarned == 0x3FFFF && old.commendationsEarned == 0x1FFFF)
			return true;
		
		//19. 30 Minutes Or Less
		if(settings["pursuit19h"] && current.commendationsEarned == 0x7FFFF && old.commendationsEarned == 0x3FFFF)
			return true;
		
		//20. Final Showdown
		if(settings["pursuit20h"] && current.commendationsEarned == 0xFFFFF && old.commendationsEarned == 0x7FFFF)
			return true;
	}
	
	if(settings["patrol_mode"])
	{		
		if(settings["criminals10"] && current.numCriminals == 10 && old.numCriminals == 9)
			return true;
		
		if(settings["criminals25"] && current.numCriminals == 25 && old.numCriminals == 24)
			return true;
		
		if(settings["criminals50"] && current.numCriminals == 50 && old.numCriminals == 49)
			return true;
		
		if(settings["criminals100"] && current.numCriminals == 100 && old.numCriminals == 99)
			return true;
	}
}