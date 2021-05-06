@IsTest
public class FlightCleanerBatch_Test {
    
    @testSetup
    static void setup() {
        TestDataFactory.createDataForFlightCleanerBatch(1000, 1000);
    }
    
    @IsTest
    static void testFlightCleanerBatch() {
        Test.startTest();
        FlightCleanerBatch newBatch = new FlightCleanerBatch();
        Id batchId = Database.executeBatch(newBatch);
        Test.stopTest();
        List<Flight__c> declinedFlights = [
            SELECT Id
            FROM Flight__c
            WHERE Status__c LIKE 'Declined'
        ];
        List<Flight__c> relevantFlights = [
            SELECT Id
            FROM Flight__c
        ];
        System.assert(declinedFlights.isEmpty());
        System.assertEquals(1000, relevantFlights.size());
    }
}