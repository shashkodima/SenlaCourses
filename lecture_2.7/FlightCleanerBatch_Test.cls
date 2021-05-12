@IsTest
private class FlightCleanerBatch_Test {
    
    @testSetup
    private static void setup() {
        TestDataFactory.createDataForFlightCleanerBatch(1000, 1000);
    }
    
    @IsTest
    private static void testFlightCleanerBatch() {
        
        Test.startTest();
        FlightCleanerBatch newBatch = new FlightCleanerBatch();
        Id batchId = Database.executeBatch(newBatch);
        Test.stopTest();
        
        List<Flight__c> declinedFlights = [
            SELECT Id
            FROM Flight__c
            WHERE Status__c = :Constants.FLIGHT_STATUS_DECLINED
        ];
        List<Flight__c> relevantFlights = [
            SELECT Id
            FROM Flight__c
        ];
        System.assertEquals(true, declinedFlights.isEmpty());
        System.assertEquals(1000, relevantFlights.size());
    }
}