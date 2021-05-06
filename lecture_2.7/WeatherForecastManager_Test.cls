@IsTest
public class WeatherForecastManager_Test {
    
    @testSetup
    static void setup() {
        TestDataFactory.createSpacePointsWithWeatherForecasts();
    }
    
    @IsTest
    static void testGetForecastsToDelete() {
        List<Weather_Daily_Forecast__c> testForecasts = WeatherForecastManager.getForecastsToDelete();
        System.assertEquals(3, testForecasts.size());
    }
}