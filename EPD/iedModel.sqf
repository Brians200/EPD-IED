/********IED storage model********

iedDictionary = <sectionName, sectionDictionary>

sectionDictionary =   <infos, [iedsExploded, iedsDisarmed]>
					| <ieds, iedsDictionary>
					| <fakes, fakesDictionary>
					| <cleanUp, [disarmedobjects]>
					
iedsDictionary = <iedName, [ied, trigger, sides, size, markerName, projectileDetectionHandle, triggerStatusHandle]>

fakesDictionary = <fakeName, [fake, fakeMarkerName]>


*********************************/

/*------ stops a tank
Bo_GBU12_LGB_MI10
Bo_GBU12_LGB
Bo_Mk82
------ stops a marshall
HelicopterExploSmall

------stops a hunter
M_Mo_82mm_AT_LG
HelicopterExploBig
M_Air_AA_MI02 

------ low damage
M_Titan_AA_long
M_Zephyr
M_Air_AT
M_Titan_AA
M_Titan_AT
R_80mm_HE
M_PG_AT

------ white smoke glows bright at night
R_230mm_HE*/