public class WeatherForecastManager {
    
    public static List<Weather_Daily_Forecast__c> getForecastsToDelete() {
        List<Weather_Daily_Forecast__c> oldForecasts = [
            SELECT Id
            FROM Weather_Daily_Forecast__c
        ];
        return oldForecasts;
    } 
}