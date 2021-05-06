@IsTest
public class SpacePointManager_Test {
    
     @testSetup
    static void setup() {
        TestDataFactory.createSpacePointsWithWeatherForecasts();
    }
    
    @IsTest
    static void testGetAllSpacePoints() {
        List<Space_Point__c> testSpacePoints = SpacePointManager.getAllSpacePoints();
        System.assertEquals(3, testSpacePoints.size());
    }
}