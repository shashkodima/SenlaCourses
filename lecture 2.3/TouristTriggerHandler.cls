public class TouristTriggerHandler {
    public static Boolean repeated = false;
  
    public static void onAfterUpdate(Map<Id, Tourist__c> newTourists) {
        List<Tourist__c> touristsWithFlights = new List<Tourist__c>();
        List<Flight__c> flightsToUpdate = new List<Flight__c>();
        
        touristsWithFlights = TouristManager.getTouristsWithFlights(newTourists);
        
        for (Tourist__c tour : touristsWithFlights) {
            if (!tour.Active__c) {
                for (Flight__c flight : tour.Flights__r) {
                    flight.Status__c = 'Declined';
                    flightsToUpdate.add(flight);
                }
            }
        }
        update flightsToUpdate;
    }
    
    public static void onBeforeInsert(List<Tourist__c> newTourists) {
        TouristService.markDuplicates(newTourists);
    }
}