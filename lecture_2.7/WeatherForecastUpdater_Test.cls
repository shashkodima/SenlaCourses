@IsTest
private class WeatherForecastUpdater_Test {
    
    @testSetup
    private static void setup() {
        TestDataFactory.createSpacePoints();
    }
    
    @IsTest
    private static void testUpdateForecasts() {
        Test.setMock(HttpCalloutMock.class, new WeatherForecasHttpCalloutMock());
        
        Test.startTest();
        WeatherForecastUpdater.updateForecasts();
        Test.stopTest();
        
        List<Weather_Daily_Forecast__c> createdForecasts =  [
            SELECT Id
            FROM Weather_Daily_Forecast__c
        ];
        System.assertEquals(3, createdForecasts.size());
    }
    
    @IsTest
    private static void testUpdateForecasts_BadResponse() {
        Test.setMock(HttpCalloutMock.class, new WeatherForecasHttpCalloutBadMock());
        
        Test.startTest();
        WeatherForecastUpdater.updateForecasts();
        Test.stopTest();
        
        List<Weather_Daily_Forecast__c> createdForecasts =  [
            SELECT Id
            FROM Weather_Daily_Forecast__c
        ];
        System.assertEquals(0, createdForecasts.size());
    }
}