public class TouristTriggerHandler {
    public static Boolean isRepeated = false;
    
    public static void onAfterUpdate(Map<Id, Tourist__c> newTourists, Map<Id, Tourist__c> oldTourists) {
        Map<Id, Tourist__c> touristIsActiveChangedToFalse = new Map<Id, Tourist__c>();
        touristIsActiveChangedToFalse = TouristService.findIsActiveChangedToFalse(newTourists, oldTourists);
        if(touristIsActiveChangedToFalse == null || touristIsActiveChangedToFalse.isEmpty()) {
            return;
        }
        
        List<Tourist__c> touristsWithFlights = new List<Tourist__c>();
        touristsWithFlights = TouristManager.getTouristsWithFlights(touristIsActiveChangedToFalse);
        List<Flight__c> flightsToUpdate = new List<Flight__c>();
        
        for (Tourist__c tour : touristsWithFlights) {
            if (!tour.Active__c) {
                for (Flight__c flight : tour.Flights__r) {
                    flight.Status__c = Constants.FLIGHT_STATUS_DECLINED;
                    flightsToUpdate.add(flight);
                }
            }
        }
        update flightsToUpdate;
    }
    
    public static void onAfterInsert(Map<Id, Tourist__c> newTourists) {
        TouristService.markDuplicatesAsync(newTourists.keyset());
    }
}