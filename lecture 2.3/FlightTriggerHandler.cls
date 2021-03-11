public class FlightTriggerHandler {

	public static void onAfterInsert(Map<Id, Flight__c> newFlights) {
		List<Flight__c> fliWithFields = [
		    SELECT Tourist__r.Age__c, Trip__r.Start_Date__c, Trip__r.Minimum_Age__c
		    FROM Flight__c
		    WHERE ID IN: newFlights.keyset()
        ];

		for (Flight__c fliToCheck: fliWithFields) {
			Id checkFliId = fliToCheck.id;
			String inputDate = date.today().format();
			Date todayDate = date.parse(inputDate);

			if (fliToCheck.Tourist__r.Age__c < fliToCheck.Trip__r.Minimum_Age__c) {
				newFlights.get(checkFliId).Tourist__c.addError('Tourist`s age is less than required for this flight');
			}
			if (todayDate > fliToCheck.Trip__r.Start_Date__c) {
				newFlights.get(checkFliId).Trip__c.addError('The plane has already left');
			}
		}
	}
}