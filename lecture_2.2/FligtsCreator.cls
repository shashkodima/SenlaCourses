public class FligtsCreator {

    @InvocableMethod(label='Auto search tourists' description='Сreates flights for free and suitable tourists for trip')
    
    public static void autoSearchTourist (List<Trip__c> selectedTrip) {
        Date compareDate = selectedTrip[0].Start_Date__c;
        Double compareAge = selectedTrip[0].Minimum_Age__c;
        
        List<Tourist__c> suitableTourists = [
            SELECT Id, Name
            FROM Tourist__c 
            WHERE (Age__c >= :compareAge 
            AND ID NOT IN (
                SELECT Tourist__c 
                FROM Flight__c 
                WHERE Trip__r.Start_Date__c = :compareDate))
        ];
        List<Flight__c> newFlights = new List<Flight__c>();        
        
        for (Integer i = 0; i < suitableTourists.size(); i++) {
            Id idTourist = suitableTourists[i].Id;
            Flight__c newFlight = new Flight__c(
                Tourist__c = idTourist,
                Trip__c = selectedTrip[0].Id
            );
            newFlights.add(newFlight);
        }
        insert newFlights; 
    }
}