state("Simpsons")
{
	string8 verCheck : 0x24AB28;
}

state("Simpsons", "FairLightENG")
{
	uint totalTime : "Simpsons.exe", 0x2C87B4, 0x24, 0x28, 0x0, 0x14, 0x8; //Stored in microseconds.
	byte lapsCompleted : "Simpsons.exe", 0x2C87B4, 0x24, 0x28, 0x0, 0x14, 0xC; //Self explanatory.
	uint carCheck : "Simpsons.exe", 0x2C87B4, 0x24, 0x28, 0x0, 0x10, 0x40; //ID of the second car in the race. Value of 1 while in race, otherwise 0 or 255.
}

state("Simpsons", "NonENGVarious")
{
	uint totalTime : 0x2C8774, 0x24, 0x28, 0x0, 0x14, 0x8; //Stored in microseconds.
	byte lapsCompleted : 0x2C8774, 0x24, 0x28, 0x0, 0x14, 0xC; //Self explanatory.
	uint carCheck : 0x2C8774, 0x24, 0x28, 0x0, 0x10, 0x40; //ID of the second car in the race. Value of 1 while in race, otherwise 0 or 255.
}

startup
{
	refreshRate = 30;
	
	//Event handler to catch manual timer resets and set the relevant vars to 0.
	vars.TimerReset = (LiveSplit.Model.Input.EventHandlerT<TimerPhase>) ((s, e) =>
	{
		print("Reset");
		vars.totalIGT = 0;
		vars.raceIGT = 0;
	});
	
	timer.OnReset += vars.TimerReset;
}

init
{
	//Initialises the variables innit.
	vars.totalIGT = 0;
	vars.raceIGT = 0;
	
	//Version checking
	switch (modules.First().ModuleMemorySize)
	{
		case 2965504:
			if (current.verCheck == "american")
				version = "FairLightENG";
			else
				version = "NonENGVarious"; // German No-CD
			break;
		case 2964216: // French No-CD
		case 3993600: // Spanish No-CD
			version = "NonENGVarious";
			break;
	}
}

start
{
	//Starts when the second car is loaded into the race by checking its ID.
	if(old.carCheck != 1 && current.carCheck == 1)
	{
		return true;
	}
}

update
{
	//carCheck is needed because without it, the code sometimes thinks you've completed a lap when you load into a race.
	if((current.lapsCompleted == old.lapsCompleted + 1) && (old.carCheck != 255 && current.carCheck != 255))
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
	//carCheck needed for aforementioned reasons.
	if((current.lapsCompleted == old.lapsCompleted + 1) && (old.carCheck != 255 && current.carCheck != 255))
		return true;
}

shutdown
{
	//Remove the event handler. Idk if this is needed but better safe than sorry.
	timer.OnReset -= vars.TimerReset;
}