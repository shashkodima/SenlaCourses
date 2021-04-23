public class SpacePointManager {
    
    public static List<Space_Point__c> getAllSpacePoint() {
        List<Space_Point__c> allSpacePoints = [
            Select Id,
            Latitude__c,
            Longitude__c
            FROM Space_Point__c
        ];
        return allSpacePoints;
    }
}