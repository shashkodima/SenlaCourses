public class SpacePointManager {
    
    public static List<Space_Point__c> getAllSpacePoints() {
        List<Space_Point__c> allSpacePoints = [
            SELECT Id,
            Latitude__c,
            Longitude__c
            FROM Space_Point__c
        ];
        return allSpacePoints;
    }
}