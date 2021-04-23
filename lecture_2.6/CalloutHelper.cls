public class CalloutHelper {
    
    public static Map<Date, Decimal> processForecastsData(Map<String, Object> responseBody) {
        Map<Date, Decimal> result = new Map<Date, Decimal>();        
        List<Object> forecastsAllDays = (List<Object>) responseBody.get(Constants.WEATHERBIT_JSON_RESPONSE_BODY_DATA_KEY);
        
        for (Object forecast : forecastsAllDays) {
            String serializedOneDayForecast = JSON.serialize(forecast);
            Map<String, Object> oneDayForecast = (Map<String, Object>) JSON.deserializeUntyped(serializedOneDayForecast);   
            String notProcessedDate = String.valueOf(oneDayForecast.get(Constants.WEATHERBIT_JSON_RESPONSE_BODY_FORECAST_DATE_KEY));
            String notProcessedAverageTemperature = String.valueOf(oneDayForecast.get(Constants.WEATHERBIT_JSON_RESPONSE_BODY_AVERAGE_TEMPERATURE_KEY));
            Date forecastDate = Date.valueOf(notProcessedDate);
            Decimal averageTemperature = Decimal.valueOf(notProcessedAverageTemperature);
            result.put(forecastDate, averageTemperature);
        }
        return result;
    }
}