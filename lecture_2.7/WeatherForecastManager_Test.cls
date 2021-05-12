@IsTest
private class WeatherForecastManager_Test {
    
    @testSetup
    private static void setup() {
        TestDataFactory.createSpacePointsWithWeatherForecasts();
    }
    
    @IsTest
    private static void testGetForecastsToDelete() {
        List<Weather_Daily_Forecast__c> testForecasts = WeatherForecastManager.getForecastsToDelete();
        System.assertEquals(3, testForecasts.size());
    }
}