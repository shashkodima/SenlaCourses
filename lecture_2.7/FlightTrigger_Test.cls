@IsTest
public class FlightTrigger_Test {
    
    @IsTest
    static void testOnAfterInsertDateError () {
        Date touristBirthdate = Date.newInstance(2015, 11, 21);
        Double minAgeForTrip = 1;
        Date tripDate = Date.newInstance(2020, 11, 21);
        Flight__c testFlight = TestDataFactory.createDataForFlightTriggerTest(touristBirthdate, minAgeForTrip, tripDate);
        Database.SaveResult saveResult = Database.insert(testFlight, false);
        System.assert(!saveResult.isSuccess());
        System.assert(saveResult.getErrors().size() > 0);
        System.assertEquals('The plane has already left',
                            saveResult.getErrors()[0].getMessage());
    }
    
    @IsTest
    static void testOnAfterInsertMinAgeError () {
        Date touristBirthdate = Date.newInstance(2015, 11, 21);
        Double minAgeForTrip = 18;
        Date tripDate = Date.newInstance(2021, 11, 21);
        Flight__c testFlight = TestDataFactory.createDataForFlightTriggerTest(touristBirthdate, minAgeForTrip, tripDate);
        Database.SaveResult saveResult = Database.insert(testFlight, false);
        System.assert(!saveResult.isSuccess());
        System.assert(saveResult.getErrors().size() > 0);
        System.assertEquals('Tourist`s age is less than required for this flight',
                            saveResult.getErrors()[0].getMessage());
    }
    
    @IsTest
    static void testOnAfterInsert () {
        Date touristBirthdate = Date.newInstance(1990, 11, 21);
        Double minAgeForTrip = 1;
        Date tripDate = Date.newInstance(2021, 11, 21);
        Flight__c testFlight = TestDataFactory.createDataForFlightTriggerTest(touristBirthdate, minAgeForTrip, tripDate);
        insert testFlight;
        List<Flight__c> testFlights = [
            SELECT Id
            FROM Flight__c
        ];
        System.assertEquals(1, testFlights.size());
    }
}