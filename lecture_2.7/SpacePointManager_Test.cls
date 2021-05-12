@IsTest
private class SpacePointManager_Test {
    
     @testSetup
    private static void setup() {
        TestDataFactory.createSpacePointsWithWeatherForecasts();
    }
    
    @IsTest
    private static void testGetAllSpacePoints() {
        List<Space_Point__c> testSpacePoints = SpacePointManager.getAllSpacePoints();
        System.assertEquals(3, testSpacePoints.size());
    }
}