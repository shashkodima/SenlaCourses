public class WeatherForecastUpdater {
    
    @future(callout=true)
    public static void updateForecasts() {
        List<Weather_Daily_Forecast__c> newForecasts = new List<Weather_Daily_Forecast__c>();
        List<Space_Point__c> allSpacePoints = SpacePointManager.getAllSpacePoint();
        
        for (Space_Point__c spacePoint : allSpacePoints) {
            Decimal latitude = spacePoint.Latitude__c;
            Decimal longitude = spacePoint.Longitude__c;
            Map<Date, Decimal> temperatureForecasts = new Map<Date, Decimal>();  
            
            try {
                temperatureForecasts = WeatherForecastService.getForecasts(latitude, longitude);
            } catch(Exception e) {
                System.debug(e.getMessage());
            }
            if(!temperatureForecasts.isEmpty() & temperatureForecasts != null) {
                
                for (Date forecastDate : temperatureForecasts.keyset()) {
                    Weather_Daily_Forecast__c newForecast = new Weather_Daily_Forecast__c (
                        Date__c = forecastDate,
                        Average_Temperature__c = temperatureForecasts.get(forecastDate),
                        Space_Point__c = spacePoint.Id
                    );
                    newForecasts.add(newForecast);
                } 
            }
        } 
        List<Weather_Daily_Forecast__c> oldForecasts = WeatherForecastManager.getForecastsToDelete();
        delete oldForecasts;
        insert newForecasts;
    }     
}