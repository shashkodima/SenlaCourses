@IsTest
public class TouristService_Test {
    
    @testSetup
    static void setup() {
        TestDataFactory.createTouristsWithFlightsTrips();
    }
    
    @IsTest
    static void testMarkDuplicatesAsync() {
        Tourist__c newTourist = new Tourist__c(Name = 'Test1', Tourist_EMail__c = 'Test1@outlook.com');
        insert newTourist;
        Set<Id> newTouristsIds = new Set<Id>();
        newTouristsIds.add(newTourist.Id);
        Test.startTest();
        TouristService.markDuplicatesAsync(newTouristsIds);
        Test.stopTest();
        List<Tourist__c> markedDuplicateTourist = [
            SELECT Id,
            IsDuplicate__c
            FROM Tourist__c
            WHERE Id IN :newTouristsIds AND IsDuplicate__c = true
        ];
        System.assertEquals(1, markedDuplicateTourist.size());
    }
    
    @IsTest
    static void testNotMarkDuplicatesAsync() {
        Tourist__c newTourist = new Tourist__c(Name = 'Test1', Tourist_EMail__c = 'noRepeat@mail.ru');
        insert newTourist;
        Set<Id> newTouristsIds = new Set<Id>();
        newTouristsIds.add(newTourist.Id);
        Test.startTest();
        TouristService.markDuplicatesAsync(newTouristsIds);
        Test.stopTest();
        List<Tourist__c> markedDuplicateTourist = [
            SELECT Id,
            IsDuplicate__c
            FROM Tourist__c
            WHERE Id IN :newTouristsIds AND IsDuplicate__c = true
        ];
        System.assertEquals(0, markedDuplicateTourist.size());
    }
    
    @IsTest
    static void testFindIsActiveChangedToFalse() {
        Map<Id, Tourist__c> oldTourists = new Map<Id, Tourist__c>([
            SELECT Id,
            Active__c
            FROM Tourist__c
        ]);
        Map<Id, Tourist__c> updatedTourists = new Map<Id, Tourist__c>();
        
        for (Tourist__c touristToUpdate : oldTourists.values()) {
            Tourist__c updatedTourist = new Tourist__c();
            updatedTourist.Active__c = false;
            updatedTourist.Id = touristToUpdate.Id;
            updatedTourists.put(updatedTourist.Id, updatedTourist);
        }
        Map<Id, Tourist__c> foundActiveChangedToFalse = TouristService.findIsActiveChangedToFalse(updatedTourists, oldTourists);
        System.assertEquals(updatedTourists.size(), foundActiveChangedToFalse.size());
    }
    
    @IsTest
    static void testFindIsActiveChangedToFalseNotAll() {
        Map<Id, Tourist__c> oldTourists = new Map<Id, Tourist__c>([
            SELECT Id,
            Active__c
            FROM Tourist__c
        ]);
        Map<Id, Tourist__c> updatedTourists = new Map<Id, Tourist__c>();
        Tourist__c touristIsNotActive = new Tourist__c(Name = 'Test', Active__c = false);
        insert touristIsNotActive;
        oldTourists.put(touristIsNotActive.Id, touristIsNotActive);
        
        for (Tourist__c touristToUpdate : oldTourists.values()) {
            Tourist__c updatedTourist = new Tourist__c();
            updatedTourist.Active__c = false;
            updatedTourist.Id = touristToUpdate.Id;
            updatedTourists.put(updatedTourist.Id, updatedTourist);
        }
        Map<Id, Tourist__c> foundActiveChangedToFalse = TouristService.findIsActiveChangedToFalse(updatedTourists, oldTourists);
        // One tourist Active__c changed from false to false
        System.assertEquals(updatedTourists.size()-1, foundActiveChangedToFalse.size());
    }    
}