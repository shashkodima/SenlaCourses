@IsTest
private class TouristManager_Test {
    
    private static List<tourist__c> getTestTourists() {
        List<Tourist__c> testTourists = [
            SELECT Id,
            Name,
            Tourist_EMail__c
            FROM Tourist__c
        ];
        return testTourists;
    }
    
    @testSetup
    private static void setup() {
        TestDataFactory.createTouristsWithFlightsTrips();
    }
    
    @IsTest
    private static void testGetByName() {
        List<Tourist__c> foundTourists = TouristManager.getByName('Test1');
        System.assertEquals(1, foundTourists.size());
    }
    
    @IsTest
    private static void testGetByBlankName() {
        List<Tourist__c> foundTourists = TouristManager.getByName('');
        System.assertEquals(0, foundTourists.size());
    }
    
    @IsTest
    private static void testGetByAge() {
        List<Tourist__c> foundTourists = TouristManager.getByAge(new Set<Integer>{1, 5});
        System.assertEquals(2, foundTourists.size());
    }
    
    @IsTest
    private static void testGetByEmptyAge() {
        List<Tourist__c> foundTouristsNull = TouristManager.getByAge(new Set<Integer>());
        System.assertEquals(0, foundTouristsNull.size());
    }
    
    @IsTest
    private static void testGetByStartYear() {
        List<Tourist__c> foundTourists = TouristManager.getByStartYear(2021);
        System.assertEquals(2, foundTourists.size());
    }
    
    @IsTest
    private static void testGetByNullStartYear() {
        Integer yearNull;
        List<Tourist__c> foundTouristsNull = TouristManager.getByStartYear(yearNull);
        System.assertEquals(0, foundTouristsNull.size());
    }
    
    @IsTest
    private static void testGetTouristTrip() {
        List<Tourist__c> TouristsWithTrips = TouristManager.getTouristTrip();
        List<Trip__c> trips = new List<Trip__c>();
        List<String> tripsNames = new List<String>();
        
        for (Tourist__c tourist : TouristsWithTrips) {
            for (Flight__c flight : tourist.Flights__r) {
                String tripName = flight.Trip__r.Name;
                tripsNames.add(tripName);
            }
        }
        System.assertEquals(3, tripsNames.size());
    }
    
    @IsTest
    private static void testGetNoFlight() {
        List<Tourist__c> TouristsNoFlight = TouristManager.getNoFlight();
        System.assertEquals(1, TouristsNoFlight.size());
    }
    
    @IsTest
    private static void testGetDuplicateNewTourists() {
        List<Tourist__c> newTourists = new List<Tourist__c> {
            new Tourist__c(Name = 'Test1', Tourist_EMail__c = 'Test1@outlook.com', Birthdate__c = Date.today() - 370),
            new Tourist__c(Name = 'NotDuplicate', Tourist_EMail__c = 'Test1@outlook.com', Birthdate__c = Date.today() - 370)
        };
                    insert newTourists;
        List<String> names = new List<String>();
        List<String> mails = new List<String>();
        Set<Id> newTouristIds = new Set<Id>();
        
        for (Tourist__c tourist : newTourists) {
            names.add(tourist.Name);
            mails.add(tourist.Tourist_EMail__c);
            newTouristIds.add(tourist.Id);               
        }
        List<Tourist__c> duplicateTourists = TouristManager.getDuplicate(names, mails, newTouristIds);         
        System.assertEquals(1, duplicateTourists.size());     
    }
    
    @IsTest
    private static void testGetDuplicateNewTouristsNullParam() {
        List<String> names = new List<String>();
        List<String> mails = new List<String>();
        Set<Id> newTouristIds = new Set<Id>();
        List<Tourist__c> duplicateTouristsNullParam = TouristManager.getDuplicate(names, mails, newTouristIds);         
        System.assertEquals(0, duplicateTouristsNullParam.size());
    }
    
    @IsTest
    private static void testGetDuplicateNewTourist() {
        Tourist__c duplicateTourist = new Tourist__c(Name = 'Test1', Tourist_EMail__c = 'Test1@outlook.com', Birthdate__c = Date.today() - 370);        
        List<Tourist__c> duplicateTourists = TouristManager.getDuplicate(duplicateTourist.Name, duplicateTourist.Tourist_EMail__c);
        System.assertEquals(1, duplicateTourists.size());
    }
    
    @IsTest
    private static void testGetDuplicateNewTouristNullParam() {
        List<Tourist__c> duplicateTourists = TouristManager.getDuplicate('', '');
        System.assertEquals(0, duplicateTourists.size()); 
    }
    
    @IsTest
    private static void testGetDuplicateNewTouristNoMatches() {
        Tourist__c notDuplicateTourist = new Tourist__c(Name = 'NotDuplicate', Tourist_EMail__c = 'Test1@outlook.com', Birthdate__c = Date.today() - 370);        
        List<Tourist__c> duplicateTouristsEmpty = TouristManager.getDuplicate(notDuplicateTourist.Name, notDuplicateTourist.Tourist_EMail__c);
        System.assertEquals(0, duplicateTouristsEmpty.size());
    }
    
    @IsTest
    private static void testGetByFreeDateMinAge() {
        Date testDate = Date.newInstance(2021, 11, 01);
        List<Tourist__c> freeTourist = TouristManager.getByFreeDateMinAge(testDate, 0);
        System.assertEquals(2, freeTourist.size());
    }
    
    @IsTest
    private static void testGetTouristsWithFlights() {
        Map<Id, Tourist__c> testMap = new Map<Id, Tourist__c>([
            SELECT Id
            FROM Tourist__c
        ]);
        List<Tourist__c> tourWithFlihts = TouristManager.getTouristsWithFlights(testMap);
        List<Flight__c> flights = new List<Flight__c>();
        
        for (Tourist__c touristWithFlights : tourWithFlihts) {
            for (Flight__c flight : touristWithFlights.Flights__r) {
                flights.add(flight);
            }
        }
        System.assertEquals(3, flights.size());
    }
    
    @IsTest
    private static void testGetByIds() {
        List<Tourist__c> testTourists = getTestTourists();
        Set<Id> testId = new Set<Id>();
        testId.add(testTourists[0].Id);
        List<Tourist__c> foundTourist = TouristManager.getByIds(testId);
        System.assertEquals(testTourists[0], foundTourist[0]);
    }
    
    @IsTest
    private static void testGetTouristsByFuzzyNameAge() {
        List<Tourist__c> testTourists = getTestTourists();
        List<Id> fixedSearchResults = new List<Id>();
        
        for (Tourist__c tourist : testTourists){
            fixedSearchResults.add(tourist.Id);
        }
        Test.setFixedSearchResults(fixedSearchResults);
        List<Tourist__c> foundTourists = TouristManager.getTourists('Test', 1);
        System.assertEquals(2, foundTourists.size());
    }
    
    @IsTest
    private static void testGetTouristsByFuzzyNameAgeNullParam() {
        List<Tourist__c> testTourists = getTestTourists();
        List<Id> fixedSearchResults = new List<Id>();
        
        for (Tourist__c tourist : testTourists){
            fixedSearchResults.add(tourist.Id);
        }
        Test.setFixedSearchResults(fixedSearchResults);
        String fuzzyName;
        Integer age;
        List<Tourist__c> foundTourists = TouristManager.getTourists(fuzzyName, age);
        System.assertEquals(true, foundTourists.isEmpty());
    }
    
    @IsTest
    private static void testGetTouristsByFuzzyName() {
        List<Tourist__c> testTourists = getTestTourists();
        List<Id> fixedSearchResults = new List<Id>();
        
        for (Tourist__c tourist : testTourists){
            fixedSearchResults.add(tourist.Id);
        }
        Test.setFixedSearchResults(fixedSearchResults);
        List<Tourist__c> foundTourists = TouristManager.getTourists('Test');
        System.assertEquals(4, foundTourists.size());
    }
    
    @IsTest
    private static void testGetTouristsByFuzzyNameNullParam() {
        List<Tourist__c> testTourists = getTestTourists();
        List<Id> fixedSearchResults = new List<Id>();
        
        for (Tourist__c tourist : testTourists){
            fixedSearchResults.add(tourist.Id);
        }
        Test.setFixedSearchResults(fixedSearchResults);
        String fuzzyName;
        List<Tourist__c> foundTourists = TouristManager.getTourists(fuzzyName);
        System.assertEquals(true, foundTourists.isEmpty());
    }
}