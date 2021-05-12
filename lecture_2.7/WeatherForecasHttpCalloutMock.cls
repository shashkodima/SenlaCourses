@IsTest
global class WeatherForecasHttpCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"data": [{"valid_date":"2021-07-02", "temp":25}]}');
        response.setStatusCode(Constants.STATUS_CODE_200);
        return response; 
    }
}