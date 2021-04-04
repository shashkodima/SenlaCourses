public class FlightCleanerBatch implements Database.Batchable<sObject>, Database.Stateful, Database.RaisesPlatformEvents {
    private String query = 'SELECT Id, Name, (SELECT Id, CreatedDate, Status__c FROM Flights__r) FROM Tourist__c';
    private Date controlDate = date.today() - 30;
    private Map<Tourist__c, Integer> numberDeletedFlightsByTourist = new Map<Tourist__c, Integer>();
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Tourist__c> tourists) {
        List<Flight__c> flightsToDelete = new List<Flight__c>();
        
        for (Tourist__c tourist : tourists) {
            Integer countDeletedFlights = 0;
            
            for (Flight__c flight : tourist.Flights__r) {
                if ((flight.Status__c == 'Declined') || (flight.CreatedDate < controlDate)) { 
                    flightsToDelete.add(flight);
                    countDeletedFlights = countDeletedFlights + 1;
                }
            }
            if (countDeletedFlights > 0) {
                numberDeletedFlightsByTourist.put(tourist, countDeletedFlights);
            }
        }
        delete flightsToDelete;
    }
    
    public void finish(Database.BatchableContext bc) {
        List<String> adresses = EmailHelper.getCustomMetadataAdresses('settings FlightCleanerBatch');
        String subject = 'Batch Process Completed';
        String textBody = '';
        
        for (Tourist__c key : numberDeletedFlightsByTourist.keySet()) {
            String aditionalText = key + ' deleted records = ' + numberDeletedFlightsByTourist.get(key) + ' ';
            textBody = textBody + aditionalText;
        }
        EmailHelper.sendEmail(adresses, subject, textBody);             
    }
}