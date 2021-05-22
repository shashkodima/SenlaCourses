@IsTest
private class TouristTrigger_Test {
    
    private static List<Tourist__c> getTestTourist() {
        List<Tourist__c> testTourists = [
            SELECT Id,
            Active__c
            FROM Tourist__c  
        ];
        return testTourists;
    }
    
    @testSetup
    private static void setup() {
        TestDataFactory.createTouristsWithFlightsTrips();
    }
    
    @IsTest
    private static void testOnAfterUpdateActiveChangedToFalse () {
        List<Tourist__c> testTourists = getTestTourist();
        testTourists[0].Active__c = false;
        update testTourists[0];
        Boolean allFlightsDeclined = true;
        List<Flight__c> testTouristFlights = [
            SELECT Status__c
            FROM Flight__c
            WHERE Tourist__c = :testTourists[0].Id
        ];
        
        for (Flight__c flight : testTouristFlights) {
            if (flight.Status__c != Constants.FLIGHT_STATUS_DECLINED) {
                allFlightsDeclined = false;
            }
        }
        System.assertEquals(true, allFlightsDeclined);
    }
    
    @IsTest
    private static void testOnAfterUpdateActiveNotChangedToFalse () {
        List<Tourist__c> testTourists = getTestTourist();
        testTourists[0].Active__c = true;
        update testTourists[0];
        Boolean allFlightsNotDeclined = true;
        List<Flight__c> testTouristFlights = [
            SELECT Status__c
            FROM Flight__c
            WHERE Tourist__c = :testTourists[0].Id
        ];
        
        for (Flight__c flight : testTouristFlights) {
            if (flight.Status__c == Constants.FLIGHT_STATUS_DECLINED) {
                allFlightsNotDeclined = false;
            }
        }
        System.assertEquals(true, allFlightsNotDeclined);
    }
}