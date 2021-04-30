public class ParameterValidation {
    
    public static void checkFuzzyNameIsBlank(String fuzzyName) {
        if (String.isBlank(fuzzyName)) {    
            String message = Constants.RESPONSE_BODY_NAME_EMPTY;
            Integer statusCode = Constants.STATUS_CODE_404;
            throw new RestRequestValidationException(statusCode, message);
        } 
    }
    
    public static void checkAgeIsNotNumeric(String age) {
        if (!(String.isBlank(age) || age.isNumeric())) {
            String message = Constants.RESPONSE_BODY_AGE_NOT_NUMBER;
            Integer statusCode = Constants.STATUS_CODE_404;
            throw new RestRequestValidationException(statusCode, message);
        } 
    }
    
    public static void checkDuplicateTourists(String name, String email) {
        List<Tourist__c> duplicateTourists = TouristManager.getDuplicate(name, email);
        if (!duplicateTourists.isEmpty()) {
            String message;
            Integer statusCode = Constants.STATUS_CODE_409;
            throw new RestRequestValidationException(statusCode, message);
        }
    }
}