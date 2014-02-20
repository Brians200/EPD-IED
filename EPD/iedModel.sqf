/********IED storage model********

iedDictionary = <sectionName, sectionDictionary>

sectionDictionary =   <infos, [iedsExploded, iedsDisarmed]>
					| <ieds, iedsDictionary>
					| <fakes, fakesDictionary>
					| <cleanUp, [disarmedobjects]>
					
iedsDictionary = <iedName, [ied, trigger, sides, size, markerName]>

fakesDictionary = <fakeName, [fake, fakeMarkerName]>


*********************************/