public class ExceptionsPlayground {
    
    private class phoneException extends Exception {}
    
    private static void generateRegularException() {
        Contact newCont = new Contact();
        newCont.FirstName = 'Victorya';
        insert newCont;
    }
    
    private static void generateCustomException() {
        Contact foundCont = [
            SELECT Id
            FROM Contact
            WHERE Name LIKE 'John Solo'
        ];
        foundCont.Phone = '22';
        if (foundCont.Phone.length() < 3) throw new phoneException('Phone number less than 3 digits');
        update foundCont;     
    }
    
    public static void handleExceptions() {
        try {
            generateRegularException();
            generateCustomException();
        } catch(Exception e) {
            System.debug('exceptions caught on line ' + e.getLineNumber());
        }
        System.debug('Method completed successfully!');
    }
}