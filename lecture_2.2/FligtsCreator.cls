public class FligtsCreator {
    
    @InvocableMethod(label='Auto search tourists' description='Сreates flights for free and suitable tourists for trip')
    
    public static void autoSearchTourist(List<Trip__c> selectedTrip) {
        Date compareDate = selectedTrip[0].Start_Date__c;
        Double minAge = selectedTrip[0].Minimum_Age__c;
        
        List<Tourist__c> suitableTourists = TouristManager.getByFreeDateMinAge(compareDate, minAge);
        List<Flight__c> newFlights = new List<Flight__c>();        
        
        for (Tourist__c suitableTourist : suitableTourists) {
            Flight__c newFlight = new Flight__c(
                Tourist__c = suitableTourist.Id,
                Trip__c = selectedTrip[0].Id
            );
            newFlights.add(newFlight);
        }
        insert newFlights; 
    }
}