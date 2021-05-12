@IsTest
private class TouristRestService_Test {
    
    @testSetup
    private static void setup() {
        TestDataFactory.createTouristsWithFlightsTrips();
    }
    
    @IsTest
    private static void testGetTourist() {
        
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestUri = '/services/apexrest/Tourist';
        RestContext.request.httpMethod = Constants.REQUEST_METHOD_GET;
        RestContext.request.addParameter('fuzzyname', 'Test');
        RestContext.request.addParameter('age', '1');
        
        Test.startTest();
        TouristRestService.getTourist();
        Test.stopTest();
        
        System.assertEquals(true, RestContext.response.responseBody.size() > 0);
        System.assertEquals(Constants.STATUS_CODE_200, RestContext.response.statusCode);
    }
    
    @IsTest
    private static void testGetTourist_FuzzyNameIsBlank() {
        
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestUri = '/services/apexrest/Tourist';
        RestContext.request.httpMethod = 'GET';
        RestContext.request.addParameter('fuzzyname', '');
        RestContext.request.addParameter('age', '1');
        
        Test.startTest();
        TouristRestService.getTourist();
        Test.stopTest();
        
        Blob responseBody = RestContext.response.responseBody;
        String responseBodyJSON = responseBody.toString();
        System.assertEquals(Constants.RESPONSE_BODY_NAME_EMPTY, responseBodyJSON);
        System.assertEquals(Constants.STATUS_CODE_404, RestContext.response.statusCode);
    }
    
    @IsTest
    private static void testGetTourist_AgeIsNotNumeric() {
        
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestUri = '/services/apexrest/Tourist';
        RestContext.request.httpMethod = 'GET';
        RestContext.request.addParameter('fuzzyname', 'Test');
        RestContext.request.addParameter('age', 'NotNumeric');
        
        Test.startTest();
        TouristRestService.getTourist();
        Test.stopTest();
        
        Blob responseBody = RestContext.response.responseBody;
        String responseBodyJSON = responseBody.toString();
        System.assertEquals(Constants.RESPONSE_BODY_AGE_NOT_NUMBER, responseBodyJSON);
        System.assertEquals(Constants.STATUS_CODE_404, RestContext.response.statusCode);
    }
    
    @IsTest
    private static void testGetTourist_ParamAgeEmpty() {
        
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestUri = '/services/apexrest/Tourist';
        RestContext.request.httpMethod = 'GET';
        RestContext.request.addParameter('fuzzyname', 'Test');
        RestContext.request.addParameter('age', '');
        
        Test.startTest();
        TouristRestService.getTourist();
        Test.stopTest();
        
        System.assertEquals(true, RestContext.response.responseBody.size() > 0);
        System.assertEquals(Constants.STATUS_CODE_200, RestContext.response.statusCode);
    }
    
    @IsTest
    private static void testCreateTourist() {
        String name = 'name';
        Date birthdate = Date.newInstance(2020, 11, 01);
        String email = 'test@gmail.com';
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestUri = '/services/apexrest/Tourist';
        RestContext.request.httpMethod = 'POST';
        
        Test.startTest();
        TouristRestService.createTourist(name, birthdate, email);
        Test.stopTest();
        
        List<Tourist__c> createdTourist = [
            SELECT Id,
            Name
            FROM Tourist__c
            WHERE Name = 'name'
        ];
        
        System.assertEquals(1, createdTourist.size());
        System.assertEquals(Constants.STATUS_CODE_200, RestContext.response.statusCode);
    }
    
    @IsTest
    private static void testCreateTourist_Duplicate() {
        String name = 'Test1';
        Date birthdate = Date.newInstance(2020, 11, 01);
        String email = 'Test1@outlook.com';
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestUri = '/services/apexrest/Tourist';
        RestContext.request.httpMethod = 'POST';
        
        Test.startTest();
        TouristRestService.createTourist(name, birthdate, email);
        Test.stopTest();
        
        List<Tourist__c> createdTourist = [
            SELECT Id,
            Name
            FROM Tourist__c
            WHERE Name = 'Test1'
        ];
        
        System.assertEquals(1, createdTourist.size());
        System.assertEquals(Constants.STATUS_CODE_409, RestContext.response.statusCode);
    }
}