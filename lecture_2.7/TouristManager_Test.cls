@IsTest
public class TouristManager_Test {
    
    @testSetup
    static void setup() {
        TestDataFactory.createTouristsWithFlightsTrips();
    }
    
    @IsTest
    static void testGetByName() {
        List<Tourist__c> foundTourists = TouristManager.getByName('Test1');
        System.assertEquals(1, foundTourists.size());
    }
    
    @IsTest
    static void testGetByBlankName() {
        List<Tourist__c> foundTourists = TouristManager.getByName('');
        System.assertEquals(0, foundTourists.size());
    }
    
    @IsTest
    static void testGetByAge() {
        List<Tourist__c> foundTourists = TouristManager.getByAge(new Set<Integer>{1, 5});
        System.assertEquals(2, foundTourists.size());
    }
    
    @IsTest
    static void testGetByEmptyAge() {
        List<Tourist__c> foundTouristsNull = TouristManager.getByAge(new Set<Integer>());
        System.assertEquals(0, foundTouristsNull.size());
    }
    
    @IsTest
    static void testGetByStartYear() {
        List<Tourist__c> foundTourists = TouristManager.getByStartYear(2021);
        System.assertEquals(2, foundTourists.size());
    }
    
    @IsTest
    static void testGetByNullStartYear() {
        Integer yearNull;
        List<Tourist__c> foundTouristsNull = TouristManager.getByStartYear(yearNull);
        System.assertEquals(0, foundTouristsNull.size());
    }
    
    @IsTest
    static void testGetTouristTrip() {
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
    static void testGetNoFlight() {
        List<Tourist__c> TouristsNoFlight = TouristManager.getNoFlight();
        System.assertEquals(1, TouristsNoFlight.size());
    }
    
    @IsTest
    static void testGetDuplicateNewTourists() {
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
    static void testGetDuplicateNewTouristsNullParam() {
        List<String> names = new List<String>();
        List<String> mails = new List<String>();
        Set<Id> newTouristIds = new Set<Id>();
        List<Tourist__c> duplicateTouristsNullParam = TouristManager.getDuplicate(names, mails, newTouristIds);         
        System.assertEquals(0, duplicateTouristsNullParam.size());
    }
    
    @IsTest
    static void testGetDuplicateNewTourist() {
        Tourist__c duplicateTourist = new Tourist__c(Name = 'Test1', Tourist_EMail__c = 'Test1@outlook.com', Birthdate__c = Date.today() - 370);        
        List<Tourist__c> duplicateTourists = TouristManager.getDuplicate(duplicateTourist.Name, duplicateTourist.Tourist_EMail__c);
        System.assertEquals(1, duplicateTourists.size());
    }
    
    @IsTest
    static void testGetDuplicateNewTouristNullParam() {
        List<Tourist__c> duplicateTourists = TouristManager.getDuplicate('', '');
        System.assertEquals(0, duplicateTourists.size()); 
    }
    
    @IsTest
    static void testGetDuplicateNewTouristNoMatches() {
        Tourist__c notDuplicateTourist = new Tourist__c(Name = 'NotDuplicate', Tourist_EMail__c = 'Test1@outlook.com', Birthdate__c = Date.today() - 370);        
        List<Tourist__c> duplicateTouristsEmpty = TouristManager.getDuplicate(notDuplicateTourist.Name, notDuplicateTourist.Tourist_EMail__c);
        System.assertEquals(0, duplicateTouristsEmpty.size());
    }
    
    @IsTest
    static void testGetByFreeDateMinAge() {
        Date testDate = Date.newInstance(2021, 11, 01);
        List<Tourist__c> freeTourist = TouristManager.getByFreeDateMinAge(testDate, 0);
        System.assertEquals(2, freeTourist.size());
    }
    
    @IsTest
    static void testGetTouristsWithFlights() {
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
    static void testGetByIds() {
        List<Tourist__c> testTourists = [
            SELECT Id,
            Name,
            Tourist_EMail__c
            FROM Tourist__c
        ];
        Set<Id> testId = new Set<Id>();
        testId.add(testTourists[0].Id);
        List<Tourist__c> foundTourist = TouristManager.getByIds(testId);
        System.assertEquals(testTourists[0], foundTourist[0]);
    }
    
    @IsTest
    static void testGetTouristsByFuzzyNameAge() {
        List<Tourist__c> testTourists = [
            SELECT Id,
            Name,
            Tourist_EMail__c
            FROM Tourist__c
        ];
        Tourist__c testTourist = testTourists[0];
        Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = testTourist.Id;
        Test.setFixedSearchResults(fixedSearchResults);
        TouristManager.getTourists('Test', 1);
    }
    
    @IsTest
    static void testGetTouristsByFuzzyNameAgeNullParam() {
        List<Tourist__c> testTourists = [
            SELECT Id,
            Name,
            Tourist_EMail__c
            FROM Tourist__c
        ];
        Tourist__c testTourist = testTourists[0];
        Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = testTourist.Id;
        Test.setFixedSearchResults(fixedSearchResults);
        String fuzzyName;
        Integer age;
        TouristManager.getTourists(fuzzyName, age);
    }
    
    @IsTest
    static void testGetTouristsByFuzzyName() {
        List<Tourist__c> testTourists = [
            SELECT Id,
            Name,
            Tourist_EMail__c
            FROM Tourist__c
        ];
        Tourist__c testTourist = testTourists[0];
        Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = testTourist.Id;
        Test.setFixedSearchResults(fixedSearchResults);
        TouristManager.getTourists('Test');
    }
    
    @IsTest
    static void testGetTouristsByFuzzyNameNullParam() {
        List<Tourist__c> testTourists = [
            SELECT Id,
            Name,
            Tourist_EMail__c
            FROM Tourist__c
        ];
        Tourist__c testTourist = testTourists[0];
        Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = testTourist.Id;
        Test.setFixedSearchResults(fixedSearchResults);
        String fuzzyName;
        TouristManager.getTourists(fuzzyName);
    }
}