@IsTest
public class FlightManager_Test {
    
    @testSetup
    static void setup() {
        TestDataFactory.createTouristsWithFlightsTrips();
    }
    
    @IsTest 
    static void testGetFlightsWithRelaitedFields() {
        List <Double> minAgesTrips = new List<Double>();
        List <Double> touristsAges = new List<Double>();
        Map<Id, Flight__c> flights = new Map<Id, Flight__c>([
            SELECT Id
            FROM Flight__c
        ]);
        List<Flight__c> flightsWithFields = FlightManager.getFlightsWithRelaitedFields(flights);
        
        for (Flight__c flight : flightsWithFields) {
            Double minAge = flight.Trip__r.Minimum_Age__c;
            Double age = flight.Tourist__r.Age__c;
            minAgesTrips.add(minAge);
            touristsAges.add(age);
        }
        System.assertEquals(3, minAgesTrips.size());
        System.assertEquals(3, touristsAges.size());
    }
}