@IsTest
public class TouristTrigger_Test {
    
    @testSetup
    static void setup() {
        TestDataFactory.createTouristsWithFlightsTrips();
    }
    
    @IsTest
    static void testOnAfterUpdateActiveChangedToFalse () {
        List<Tourist__c> testTourists = [
            SELECT Id,
            Active__c
            FROM Tourist__c  
        ];
        testTourists[0].Active__c = false;
        update testTourists[0];
        Boolean allFlightsDeclined = true;
        List<Flight__c> testTouristFlights = [
            SELECT Status__c
            FROM Flight__c
            WHERE Tourist__c = :testTourists[0].Id
        ];
        
        for (Flight__c flight : testTouristFlights) {
            if (flight.Status__c != 'Declined') {
                allFlightsDeclined = false;
            }
        }
        System.assert(allFlightsDeclined);
    }
    
    @IsTest
    static void testOnAfterUpdateActiveNotChangedToFalse () {
        List<Tourist__c> testTourists = [
            SELECT Id,
            Active__c
            FROM Tourist__c  
        ];
        testTourists[0].Active__c = true;
        update testTourists[0];
        Boolean allFlightsNotDeclined = true;
        List<Flight__c> testTouristFlights = [
            SELECT Status__c
            FROM Flight__c
            WHERE Tourist__c = :testTourists[0].Id
        ];
        
        for (Flight__c flight : testTouristFlights) {
            if (flight.Status__c == 'Declined') {
                allFlightsNotDeclined = false;
            }
        }
        System.assert(allFlightsNotDeclined);
    }
}