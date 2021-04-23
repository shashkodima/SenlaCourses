@RestResource(urlMapping='/Tourist')
global class TouristRestService {
    
    @HttpGet
    global static void getTourist() {
        List<Tourist__c> result = new List<Tourist__c>();
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String fuzzyName = request.params.get(Constants.URI_PARAMETER_FUZZYNAME);
        String parameterAge = request.params.get(Constants.URI_PARAMETER_AGE);
        Integer age; 
        
        if (String.isBlank(fuzzyName)) {
            String textResponseBody = Constants.RESPONSE_BODY_NAME_EMPTY;
            response.responseBody = Blob.valueOf(textResponseBody);
            response.statusCode = 404;
            return;        
        }        
        if (String.isBlank(parameterAge)) {
            result = TouristManager.getTourists(fuzzyName);
            response.statusCode = 200;
            response.responseBody = Blob.valueOf(JSON.serializePretty(result));
            return;
        }    
        try {
            age = Integer.valueof(parameterAge);
        } catch(Exception exc) {              
            String textResponseBody = Constants.RESPONSE_BODY_AGE_NOT_NUMBER;
            response.responseBody = Blob.valueOf(textResponseBody);
            response.statusCode = 404;
            return;
        }        
        result = TouristManager.getTourists(fuzzyName, age);
        response.statusCode = 200;
        response.responseBody = Blob.valueOf(JSON.serializePretty(result));
    }
    
    @HttpPost
    global static void createTourist(String name, Date birthdate, String email) {
        RestResponse response = RestContext.response;
        List<Tourist__c> duplicateTourists = TouristManager.getDuplicate(name, email);
        
        if (!duplicateTourists.isEmpty()) {
            response.statusCode = 409;
            return;
        }
        Tourist__c newTourist = new Tourist__c();
        newTourist.Name = name;
        newTourist.Birthdate__c = birthdate;
        newTourist.Tourist_EMail__c = email;
        insert newTourist;
        response.responseBody = Blob.valueOf(JSON.serializePretty(newTourist.Id));
    }
}