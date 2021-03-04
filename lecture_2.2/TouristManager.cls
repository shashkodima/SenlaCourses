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
    
     public static Map<Tourist__c, List<Trip__c>> getTouristTrip() {
         Map<Tourist__c, List<Trip__c>> touristTrip = new Map<Tourist__c, List<Trip__c>>();   
         List <Tourist__c> listTourist = [
            SELECT Name, Age__c, ID
            FROM Tourist__c
        ];
         
        for (Integer i = 0; i < listTourist.size(); i++) {
            String TouristId = listTourist[i].id;
            List<Trip__c> newTripList= [
                SELECT Name, Start_Date__c 
                FROM Trip__c 
                WHERE Id IN(SELECT Trip__c 
                            FROM Flight__c 
                            WHERE Tourist__r.Id = :TouristId)
            ];
            touristTrip.put(listTourist[i], newTripList);
        }
        System.debug(touristTrip);
        return touristTrip; 
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