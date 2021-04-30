@RestResource(urlMapping='/Tourist')
global class TouristRestService {
    
    @HttpGet
    global static void getTourist() {
        List<Tourist__c> result = new List<Tourist__c>();
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String fuzzyName = request.params.get(Constants.URI_PARAMETER_FUZZYNAME);
        String parameterAge = request.params.get(Constants.URI_PARAMETER_AGE);
        
        try {
            ParameterValidation.checkFuzzyNameIsBlank(fuzzyName);
            ParameterValidation.checkAgeIsNotNumeric(parameterAge);           
            
            if (String.isBlank(parameterAge)) {
                result = TouristManager.getTourists(fuzzyName);
            } else {
                Integer age = Integer.valueof(parameterAge);
                result = TouristManager.getTourists(fuzzyName, age);
            }
            response.statusCode = Constants.STATUS_CODE_200;
            response.responseBody = Blob.valueOf(JSON.serializePretty(result));
        } catch(RestRequestValidationException ex) {
            response.statusCode = ex.getStatusCode();
            response.responseBody = Blob.valueOf(ex.getMessage());
        }
    }
    
    @HttpPost
    global static void createTourist(String name, Date birthdate, String email) {
        RestResponse response = RestContext.response;
        try {
            ParameterValidation.checkDuplicateTourists(name, email);
            Tourist__c newTourist = new Tourist__c();
            newTourist.Name = name;
            newTourist.Birthdate__c = birthdate;
            newTourist.Tourist_EMail__c = email;
            insert newTourist;
            response.statusCode = Constants.STATUS_CODE_200;
            response.responseBody = Blob.valueOf(JSON.serializePretty(newTourist.Id));
        } catch(RestRequestValidationException ex) {
            response.statusCode = ex.getStatusCode();
        }               
    }
}