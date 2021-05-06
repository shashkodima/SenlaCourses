public class FlightManager {
    
    public static List<Flight__c> getFlightsWithRelaitedFields(Map<Id, Flight__c> newFlights) {
        List<Flight__c> flightsWithFields = [
            SELECT Tourist__r.Age__c,
            Status__c,
            Trip__r.Minimum_Age__c,
            Trip__r.Start_Date__c
            FROM Flight__c
            WHERE ID IN: newFlights.keyset()
        ];
        return flightsWithFields;
    }
}