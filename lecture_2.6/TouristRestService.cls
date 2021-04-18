@RestResource(urlMapping='/Tourist')
global class TouristRestService {
    
    @HttpGet
    global static List<Tourist__c> getTourist() {
        List<Tourist__c> result = new List<Tourist__c>();
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String fuzzyname = request.params.get('fuzzyname');
        String ageString = request.params.get('age');
        Integer age;
        
        if (String.isBlank(fuzzyname)) {
            String textResponseBody = Constants.RESPONSE_BODY_NAME_EMPTY;
            response.responseBody = Blob.valueOf(textResponseBody);
            response.statusCode = 404;
            return new List<Tourist__c>();        
        }
        
        if (String.isBlank(ageString)) {
            result = TouristManager.getTourists(fuzzyname);
            return result;
        }
        
        try {
            age = Integer.valueof(ageString);
        } catch(Exception e) {              
            String textResponseBody = Constants.RESPONSE_BODY_AGE_NOT_NUMBER;
            response.responseBody = Blob.valueOf(textResponseBody);
            response.statusCode = 404;
            return new List<Tourist__c>();
        }
        System.debug(age);
        result = TouristManager.getTourists(fuzzyname, age);
        response.statusCode = 200;
        return result;
    }
}