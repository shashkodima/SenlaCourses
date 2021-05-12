@IsTest
global class WeatherForecasHttpCalloutBadMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('Not Found');
        response.setStatusCode(Constants.STATUS_CODE_404);
        return response; 
    }
}