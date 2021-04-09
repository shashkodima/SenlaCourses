public with sharing class FlightCleanerBatch implements Database.Batchable<SObject>, Database.RaisesPlatformEvents, Database.Stateful {
    private final Date CONTROL_DATE = Date.today() - Constants.FLIGHT_DELETION_PERIOD_DAYS;
    private final String query = 
        'SELECT Id, ' +
        'Name, ' +
        '(SELECT Id, CreatedDate, Status__c FROM Flights__r) ' +
        'FROM Tourist__c ' +
        'WHERE Id IN(SELECT Tourist__c FROM Flight__c WHERE CreatedDate < :CONTROL_DATE OR Status__c = \'' + Constants.FLIGHT_STATUS_DECLINED + '\')';
    private Map<Tourist__c, Integer> numberDeletedFlightsByTourist = new Map<Tourist__c, Integer>();
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Tourist__c> tourists) {
        List<Flight__c> flightsToDelete = new List<Flight__c>();
        
        for (Tourist__c tourist : tourists) {
            Integer countDeletedFlights = 0;
            
            for (Flight__c flight : tourist.Flights__r) {
                if ((flight.Status__c == Constants.FLIGHT_STATUS_DECLINED) || (flight.CreatedDate < CONTROL_DATE)) { 
                    flightsToDelete.add(flight);
                    ++countDeletedFlights;
                }
            }
            if (countDeletedFlights > 0) {
                numberDeletedFlightsByTourist.put(tourist, countDeletedFlights);
            }
        }
        delete flightsToDelete;
    }
    
    public void finish(Database.BatchableContext bc) {
        Set<String> adresses = EmailHelper.getCustomMetadataAdresses(Constants.EMAIL_SETTING_NAME_FLIGHT_CLEANER);
        String subject = Constants.EMAIL_SUBJECT_FLIGHT_CLEANER;
        String textBody = '';
        
        for (Tourist__c key : numberDeletedFlightsByTourist.keySet()) {
            String aditionalText = key + ' deleted records = ' + numberDeletedFlightsByTourist.get(key) + ' ';
            textBody = textBody + aditionalText;
        }
        EmailHelper.sendEmail(adresses, subject, textBody);             
    }
}