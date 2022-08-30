state("Simpsons")
{
	// Credits Lucas Cardellini
	uint verCheck : 0x193FFF;
}

state("Simpsons", "ReleaseEnglish")
{
	uint totalTime : "Simpsons.exe", 0x2C87B4, 0x24, 0x28, 0x0, 0x14, 0x8; //Stored in microseconds.
	byte lapsCompleted : "Simpsons.exe", 0x2C87B4, 0x24, 0x28, 0x0, 0x14, 0xC; //Self explanatory.
	uint carCheck : "Simpsons.exe", 0x2C87B4, 0x24, 0x28, 0x0, 0x10, 0x40; //ID of the second car in the race. Value of 1 while in race, otherwise 0 or 255.
	byte trackNumber : "Simpsons.exe", 0x2C894C, 0x28, 0x820;
	/*Goes from 0-6. This is actually the track you're hovering over in the menu, but the value stays during races.
	Must be used in conjunction with carCheck to prevent resets while in track select.*/
}

state("Simpsons", "ReleaseInternational")
{
	uint totalTime : "Simpsons.exe", 0x2C8774, 0x24, 0x28, 0x0, 0x14, 0x8;
	byte lapsCompleted : "Simpsons.exe", 0x2C8774, 0x24, 0x28, 0x0, 0x14, 0xC;
	uint carCheck : "Simpsons.exe", 0x2C8774, 0x24, 0x28, 0x0, 0x10, 0x40;
	byte trackNumber : "Simpsons.exe", 0x2C890C, 0x28, 0x820;
}

state("Simpsons", "BestSellersSeries")
{
	uint totalTime : "Simpsons.exe", 0x2C87AC, 0x24, 0x28, 0x0, 0x14, 0x8;
	byte lapsCompleted : "Simpsons.exe", 0x2C87AC, 0x24, 0x28, 0x0, 0x14, 0xC;
	uint carCheck : "Simpsons.exe", 0x2C87AC, 0x24, 0x28, 0x0, 0x10, 0x40;
	byte trackNumber : "Simpsons.exe", 0x2C8944, 0x28, 0x820;
}

startup
{
	refreshRate = 30;
	
	//Event handler to catch manual timer resets and set the relevant vars to 0.
	vars.TimerReset = (LiveSplit.Model.Input.EventHandlerT<TimerPhase>) ((s, e) =>
	{
		vars.totalIGT = 0;
		vars.raceIGT = 0;
		vars.startedRaces = 0;
		vars.delayedUpdate = false;
		vars.shouldSplit = false;
	});
	
	timer.OnReset += vars.TimerReset;
}

init
{
	//Initialises the variables innit.
	vars.totalIGT = 0;
	vars.raceIGT = 0;
	vars.startedRaces = 0;
	vars.delayedUpdate = false;
	vars.shouldSplit = false;
	
	// Version checking. Credits Lucas Cardellini
	switch (current.verCheck)
	{
		case 0xFAE804C5: // Demo
		case 0xC985ED33: // Release International
			version = "ReleaseInternational";
			break;
		case 0x4B8B2274: // Release English
			version = "ReleaseEnglish";
			break;
		case 0xFC468D05: // Best Sellers Series
			version = "BestSellersSeries";
			break;
	}
}

start
{
	//Starts when the second car is loaded into the race by checking its ID.
	if(old.carCheck != 1 && current.carCheck == 1)
	{
		vars.startedRaces |= (1 << current.trackNumber);
		return true;
	}
}

reset
{
	//Check this again to prevent resets while in track select.
	if(old.carCheck != 1 && current.carCheck == 1)
	{
		//If current track is already in list of started races, reset.
		if(((1 << current.trackNumber) & vars.startedRaces) > 0)
		{
			return true;
		}
		//Otherwise, add current track to the list.
		else
		{
			vars.startedRaces |= (1 << current.trackNumber);
		}
	}
}

update
{
	//carCheck is needed because without it, the code sometimes thinks you've completed a lap when you load into a race.
	if(((current.lapsCompleted == old.lapsCompleted + 1) && (old.carCheck != 4294967295 && current.carCheck != 4294967295)) || vars.delayedUpdate)
	{
		//Very rarely, livesplit will retreive the values after the number of laps increases but before the total time increases.
		//This just delays the timer update and split until the total time updates.
		if(current.totalTime == vars.raceIGT)
		{
			vars.delayedUpdate = true;
		}
		else
		{
			vars.raceIGT = current.totalTime;
		
			//When last lap finished, round the race IGT appropriately before adding to total.
			if(current.lapsCompleted == 5)
			{
				if(vars.raceIGT % 10000 >= 5000)
				{
					vars.raceIGT += 5000;
				}
				
				vars.raceIGT = (vars.raceIGT / 10000) * 10000;
				vars.totalIGT += vars.raceIGT;
				vars.raceIGT = 0;
			}
			
			vars.delayedUpdate = false;
			
			//Because every lap has a split, can simplify the split logic by just checking this :)
			vars.shouldSplit = true;
		}
	}
}

isLoading
{
	//Stops game timer from running on its own, only updates on lap completion.
	return true;
}

gameTime
{
	//Calculate total game time in milliseconds for the timer.
	int milliseconds = (int)((vars.totalIGT + vars.raceIGT) / 1000);
	return new TimeSpan(0, 0, 0, 0, milliseconds);
}

split
{
	//Simples :)
	if(vars.shouldSplit)
	{
		vars.shouldSplit = false;
		return true;
	}
}

shutdown
{
	//Remove the event handler. Idk if this is needed but better safe than sorry.
	timer.OnReset -= vars.TimerReset;
}
