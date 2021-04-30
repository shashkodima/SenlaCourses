public class RestRequestValidationException extends Exception {
    private Integer statusCode;
    private String message;
    
    public RestRequestValidationException(Integer statusCode, String message) {
        this.statusCode = statusCode;
        this.message = message;
    }
    
    public override String getMessage() {
        return message;
    }
    
    public Integer getStatusCode() {
        return statusCode;
    }   
}