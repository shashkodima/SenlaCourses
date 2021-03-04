public class TouristService {
    
    public static void markDuplicates(List<Tourist__c> newTourists) {
        
        for (Integer i = 0; i < newTourists.size(); i++) {
            String compareName = newTourists[i].Name;         
            String compareEmail= newTourists[i].Tourist_EMail__c;
            
            List<Tourist__c> duplTourists = [
                SELECT Id
                FROM Tourist__c
                WHERE Tourist_EMail__c = :compareEmail
                AND Name = :compareName
            ];
            if (!duplTourists.isEmpty()) {
                newTourists[i].IsDuplicate__c = true;
            }
        }
        insert newTourists;
    }
}