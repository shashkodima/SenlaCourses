public class WeatherForecastService {
    private class WeatherForecastException extends Exception {}
    
    public static Map<Date, Decimal> getForecasts(Decimal latitude, Decimal longitude) {
        String apiKey = Constants.API_KEY_WEATHERBIT;
        String RequestEndPoint = Constants.BASE_URL_WEATHERBIT_FORECAST_16_DAYS + '?lat=' + latitude + '&lon=' + longitude + '&key=' + apiKey;
        Map<Date, Decimal> result = new Map<Date, Decimal>();
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(RequestEndPoint);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            result = CalloutHelper.processForecastsData(responseBody);                    
        } else {
            throw new WeatherForecastException(response.getStatusCode() + ' ' + response.getStatus());
        }
        return result;
    }
}