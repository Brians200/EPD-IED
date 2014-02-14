Randomly generated roadside IED script for ARMA 3<br>
http://forums.bistudio.com/showthread.php?170703-Randomly-generated-roadside-IEDs


Hello,

I am here to release a script I created that randomly generates IEDs. It is based off of the original work from Tankbuster and Mantls's update on that.

VIDEOS<br>
Release v1.0 video - https://www.youtube.com/watch?v=_XRlKUd7d2k<br>
Release v1.1 video - https://www.youtube.com/watch?v=v7CZDESIw8g<br>
Release v1.2 video - https://www.youtube.com/watch?v=YZRS37J6CIY<br>
Release v1.5 video - https://www.youtube.com/watch?v=ZeyHyyuFawo<br>
Tutorial video - https://www.youtube.com/watch?v=E2EdlbSlcrc<br>
<br>
IMAGES<br>
http://i.imgur.com/tirV1Dk.jpg<br>
http://i.imgur.com/ttIV6LX.jpg<br>
http://i.imgur.com/ZayMpBw.jpg (361 kB)<br>
http://i.imgur.com/es7QeVD.jpg (182 kB)<br>

Adding the script to your mission file is pretty simple, all you need to do is put the folder into your mission folder and add the following to your init.sqf
Code:

	[] spawn {call compile preprocessFileLineNumbers "EPD\Ied_Init.sqf";};

If you want to change where or how many IEDs are spawned, modify the variable called iedArray in Ied_Settings.sqf.

There are several ways to define where you want the IEDs placed.
Code:

	//These are the actual IEDs that will spawn. Add them using one of the following formats.
	//mapLocations that have their type defined as one of "NameCityCapital","NameCity","NameVillage", "NameLocal" will be grabbed out of the map config.
	["All", side]     //This is a combination of Cities, Villages, and Locals
	["AllCities", side]
	["AllVillages", side]
	["AllLocals", side]
	["mapLocation", side]
	["mapLocation", amountToPlace, side];
	["mapLocation", iedsToPlace, fakesToPlace, side]
	["predefinedLocation", side]
	["predefinedLocation", amountToPlace, side];
	["predefinedLocation", iedsToPlace, fakesToPlace, side]
	/*********Marker size > 1**********************/
	["marker", iedsToPlace, fakesToPlace, side]
	["marker", amountToPlace, side]
	["marker", side]
	/*********Marker size = 1**********************/
	["marker", side]
	["marker", chanceToBeReal, side]

	The side can be a single side, or an array of sides
	Ex. "West"   or ["West,"East"]
	http://community.bistudio.com/wiki/side

The way it works is that it will use the markerName as the center and find all the roads within the radius of the marker (make sure you set it!), then it will randomly place real and fake IEDs somewhere within it.
There are several predefined locations for Altis in EPD\Ied_Settings.sqf that you can use if you don't feel like making your own markers. As of version 1.3, you can also use the names of locations in the game. If you want to share your predefined locations for other maps for others to use, feel free to, and I will post them here on the front post.
Here is a map of where each AltisRandom corresponds to.
If you do not specify how many to place, it will calculate an amount based on the size of the marker you gave it. If the marker has a size of 1, it will place exactly 1 IED in that exact spot, allowing you to pick where the IED is at, rather than a random road near the marker. There is an example of each type in EPD\Ied_Settings.sqf.

There are currently 4 types of IEDs

    Secondary IED - Designed to kill first responders after the other IEDs goes off.
    Infantry IED - Will kill the person who sets it off and injure most other squad members near him
    Light Armor IED - Will destroy vehicles up to apc types. Will track or destroy a tank, depending on how far away it is
    Heavy Armor IED - Will destroy all vehicles and cause lots of mayhem


The type of IED also determines what size the object it is hiding in is. Heavy Armor IEDs will be hidden in things like trash piles and wrecked vehicles. Infantry IEDs will be hidden in things like buckets and tires.

IEDs are set off based on speed and proximity. If your horizontal velocity squared is higher than 2.8, and you are within 11 meters of it, you will set it off.
The IEDs can be disarmed if you have the appropriate items and are within 3 meters. If you fail while trying to disarm an IED, you will set it off.

As of version 1.3, there are now several options that can be changed in Ied_Settings.sqf

    debug - If this is set to true, it will create map markers indicating where the IEDs and fakes are. It will create a message showing if a player is near an IED and give their distance and speed (see picture 2). It will also create a message if there are secondaries incoming. These will only show up to the person who is the server. This is mostly useful for testing while developing a map.
    hideIedMarker - Set this to true if you want it to hide the marker you used to position the IED circle.
    itemsRequiredToDisarm - A player must have all of these items in order to have a disarm option.
    betterDisarmers - Players of these classes have an increased chance of disarming IEDs
    baseDisarmChance - Default chance of successfully disarming an IED
    bonusDisarmChance - Players who are in the betterDisarmers array will have this amount added to their baseDisarmChance
    secondaryChance - Chance that secondary explosions will spawn
    smallChance - Chance that an IED will be small sized
    mediumChance - Chance that an IED will be medium sized
    largeChance - Chance that an IED will be large sized
    iedSecondaryItems - Items secondary IEDs will hide in
    iedSmallItems - Items Infantry IEDs will hide in
    iedMediumItems - Items Light Armor IEDs will hide in
    iedLargeItems - Items Heavy Armor IEDs will hide in
    predefinedLocations - If you want to use the same locations over lots of missions without having to create markers over and over, define them here using the following format ["Name",[LocationX,LocationY,LocationZ],size]. Most of Altis has been provided as an example.
    allowExplosiveToTriggerIEDs - If this is set to true explosions can set off the IEDs.
    iedArray - This is where you actually pick where the IEDs are spawned and how many. See the code above for the format
    safeZones - Place the mapLocations, predefinedLocations, and markerNames of places you don't want any random IEDs spawning



Explosives Requirements

    Planted explosives and Bombs have a 100% chance of setting off IEDs if they are within 6 meters
    Hand grenades have a 35% chance of setting off IEDs if they are within 6 meters
    Rockets, Missiles, Shells, and Submunitions have a 100% chance of setting off IEDS if they are a direct hit
    Launched grenades have a 50% chance of setting off IEDs if they are a direct hit
    Explosive bullets have a 40% chance of setting off IEDs if they are a direct hit



Checking the status of a section of IEDs
As of version 1.4, you can now use the auto generated strings to check if an IED from a section has gone off or if ALL IEDs from a section have been disarmed.
For example, assume you started with these 2 towns

Code:

	iedArray = [
		["Gravia", 3, 8, "West" ],
		["Lakka", 2, 8, "West" ]
		];

If we want to check if any IED has been set off in Gravia, we can use the following.
Code:

	call compile (explodedSections select 0)

If we want check if all the IEDS in Lakka have been disarmed, we can use the following.
Code:

	call compile (disarmedSections select 1)

Change Log:
Version 1.6

    Added a tinnitus and disorientation effect, based on how far away you are from the IED. Special Thanks to IndeedPete
    Renamed the debug variable so it is unique to the script to prevent conflicts with other scripts. 

Version 1.5

    Multiple sides can now set off IEDs
    In an attempt to overcome the inaccurate reporting of speed in the game, players crawling will not be able to set it off, even if the game inaccurately reports them going over the max speed.



Version 1.4

    The script now generates strings of code that you can use to check if an IED from a section has exploded
    The script now generates strings of code that you can use to check if ALL IEDs from a section have been disarmed


Version 1.3

    You can now reference places in the game without making markers or having to define them. Hat tip to KevsnoTrev for pointing me to the config.
    Added a safeZone section to the settings. Randomly created IEDs will not spawn in here, but specific ones will. Large safeZones and lots of safeZones will slow down the initialization.


Version 1.2

    IEDs can now be set off by explosives
    Secondaries now create a secondary IED, rather than just randomly making an explosion a short time later
    Changed the predefined location setup to make it easier to edit
    Added percentage sized options
    Tweaked smoke particle effects
    Fixed a bug with the speed check that allowed you to go as fast as you wanted backwards
    Moved all the settings out of the init to make it easier to modify
    Added a percentage chance to the single IED creation mode


Version 1.1

    New smoke cloud particles that produce significantly less particles than the original.
    New smoke plume effects
    Your screen will now only shake if you are within 200 meters of the explosion
    Fixed JIP issue where they could disarm already disarmed IEDs
    Disarm option is now colored and has a higher priority in the list
    Fixed a bug with the detection of the road direction
    Added more variance with where IEDs spawn along the road
    You can now specify how many real IEDs and fake IEDs you want in an area
    Added a check to see if the marker exists before attempting to place IEDs there
    Added option to hide the marker used to place the IEDs
    Added option to set what items are required to disarm the IED
    Added option to set the percentage regular players can disarm at
    Added option to set what classes are better at disarming
    Added option to set the percentage increase knowledgeable players get while disarming
    Moved the items that IEDs hide in to Ied_Init.sqf for easier editing



Known Issues:

    Sometimes the IEDs will spawn behind a wall.
    Deactivating a charge near an IED will set off the IED.
