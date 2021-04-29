public class WeatherForecastService {
    public class WeatherForecastException extends Exception {}
    
    public static Map<Date, Decimal> getForecasts(Decimal latitude, Decimal longitude) {
        List<Object> parameters = new List<Object> {latitude, longitude, Constants.API_KEY_WEATHERBIT};
        Map<Date, Decimal> result = new Map<Date, Decimal>();
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:weatherbit_daily_forecast/' + String.format('?lat={0}&lon={1}&key={2}', parameters));
        request.setMethod(Constants.REQUEST_METHOD_GET);
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == Constants.STATUS_CODE_200) {
            Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            result = CalloutHelper.processForecastsData(responseBody);                    
        } else {
            throw new WeatherForecastException(response.getStatusCode() + ' ' + response.getStatus());
        }
        return result;
    }
}