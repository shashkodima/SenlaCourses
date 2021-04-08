public class TouristManager {
    
    public static List<Tourist__c> getByName(String findName) {
        if (String.isBlank(findName)) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> foundTourists = [
            SELECT Name, 
            Age__c
            FROM Tourist__c
            WHERE Name LIKE :findName
        ];
        System.debug(foundTourists);
        return foundTourists;   
    }
    
    public static List<Tourist__c> getByAge(Set<Integer> findAge) {
        if(findAge.isEmpty() || findAge == null) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> foundTourists = [
            SELECT Name,
            Age__c
            FROM Tourist__c
            WHERE Age__c = :findAge
        ];
        System.debug(foundTourists);
        return foundTourists;      
    }
    
    public static List<Tourist__c> getByStartYear(Integer year) {
        if(year == null) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> foundTourists = [
            SELECT Name,
            Age__c
            FROM Tourist__c
            WHERE Id IN(SELECT Tourist__c 
                        FROM Flight__c 
                        WHERE CALENDAR_YEAR(Trip__r.Start_Date__c) = :year)
        ];
        System.debug(foundTourists);
        return foundTourists;
    }
    
    public static List<Tourist__c> getTouristTrip() {
        List<Tourist__c> touristWithTrip = [
            SELECT Name, 
            Age__c, 
            (SELECT Trip__r.Name, Trip__r.Start_Date__c FROM Flights__r) 
            FROM Tourist__c
        ];
        return touristWithTrip;
    }
    
    public static List<Tourist__c> getNoFlight() {
        List<Tourist__c> touristsNoFly = [
            SELECT Name, 
            Age__c 
            FROM Tourist__c 
            WHERE Id NOT IN(SELECT Tourist__c 
                            FROM Flight__c)
        ];
        System.debug(touristsNoFly);
        return touristsNoFly;
    }
    
    public static List<Tourist__c> getDuplicate(List<String> names, List<String> mails, Set<Id> newTouristsId) {
        if((names.isEmpty() && mails.isEmpty() && newTouristsId.isEmpty()) || (names == null && mails == null && newTouristsId == null)) {
            return new List<Tourist__c>();
        }
        List < Tourist__c > duplicateTourists = [
            SELECT Id, 
            Name, 
            Tourist_EMail__c
            FROM Tourist__c
            WHERE Tourist_EMail__c IN: mails
            AND Name IN: names
            AND Id NOT IN :newTouristsId
        ];
        return duplicateTourists;
    }
    
    public static List<Tourist__c> getByFreeDateMinAge(Date freeDate, Double minAge) {
        List<Tourist__c> suitableTourists = [
            SELECT Id, 
            Name
            FROM Tourist__c 
            WHERE (Age__c >= :minAge 
                   AND ID NOT IN (
                       SELECT Tourist__c 
                       FROM Flight__c 
                       WHERE Trip__r.Start_Date__c = :freeDate))
        ];
        return suitableTourists;
    }
    
    public static List<Tourist__c> getTouristsWithFlights(Map<Id, Tourist__c> newTourists) {
        List<Tourist__c> tourWithFlihts = [
            SELECT Active__c, 
            (SELECT Id FROM Flights__r)
            FROM Tourist__c
            WHERE Id IN: newTourists.keyset()
        ];
        return tourWithFlihts;
    }
    
    public static List<Tourist__c> getByIds (Set<Id> touristsId) {
        List<Tourist__c> newTourists = [
            SELECT Id,
            Name,
            Tourist_EMail__c
            FROM Tourist__c
            WHERE Id IN :touristsId
        ];
        return newTourists;
    }
}