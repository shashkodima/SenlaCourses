public class TouristTriggerHandler {
	public static Boolean repeated = false;

	public static void onAfterUpdate(Map<Id, Tourist__c> newTourists) {
		List<Tourist__c> tourWithFli = [
		    SELECT Active__c, 
            (SELECT Id FROM Flights__r)
		    FROM Tourist__c
		    WHERE Id IN: newTourists.keyset()
        ];
		List<Flight__c> fliToUpdate = new List<Flight__c>();

		for (Tourist__c tour : tourWithFli) {
			if (!tour.Active__c) {
				for (Flight__c flight : tour.Flights__r) {
					flight.Status__c = 'Declined';
					fliToUpdate.add(flight);
				}
			}
		}
		update fliToUpdate;
	}
}