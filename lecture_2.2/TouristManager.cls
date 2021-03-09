public class TouristManager {

    public static List<Tourist__c> getByName(String findName) {
        if (String.isBlank(findName)) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> foundTourists = [
            SELECT Name, Age__c
            FROM Tourist__c
            WHERE Name LIKE :findName
        ];
        System.debug(foundTourists);
        return foundTourists;   
    }
    
    public static List<Tourist__c> getByAge(List<Integer> findAge) {
        List<Tourist__c> foundTourists= [
            SELECT Name, Age__c
            FROM Tourist__c
            WHERE Age__c = :findAge
        ];
        System.debug(foundTourists);
        return foundTourists;      
    }
    
    public static List<Tourist__c> getByStartYear(Integer year) {
        List<Tourist__c> foundTourists = [
            SELECT Name, Age__c
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
             SELECT Name, Age__c, (SELECT Trip__r.Name, Trip__r.Start_Date__c FROM Flights__r) 
             FROM Tourist__c
         ];
        return touristWithTrip;
    }
    
    public static List<Tourist__c> getNoFlight() {
        List<Tourist__c> touristsNoFly = [
            SELECT Name, Age__c 
            FROM Tourist__c 
            WHERE Id NOT IN(SELECT Tourist__c 
                            FROM Flight__c)
        ];
        System.debug(touristsNoFly);
        return touristsNoFly;
    }
}