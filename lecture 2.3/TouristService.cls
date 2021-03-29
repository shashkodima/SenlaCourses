public class TouristService {
    
    public static void markDuplicates(List <Tourist__c> newTourists) {
        List<String> names = new List<String>();
        List<String> mails = new List<String>();
        
        for (Tourist__c curTourist : newTourists) {
            names.add(curTourist.Name);
            mails.add(curTourist.Tourist_EMail__c);
        }
        List<Tourist__c> duplTourists = TouristManager.getDuplicate(names, mails);
        
        for (Tourist__c newTourist : newTourists) {
            for (Tourist__c duplTourist : duplTourists) {
                if (newTourist.Name == duplTourist.Name && newTourist.Tourist_EMail__c == duplTourist.Tourist_EMail__c) {
                    newTourist.IsDuplicate__c = true;
                }
            }
        }
    }
    
    public static Map<Id, Tourist__c> findIsActiveChangedToFalse (Map<Id, Tourist__c> newTourists, Map<Id, Tourist__c> oldTourists) {
        Map<Id, Tourist__c> touristIsActiveChanged = new Map<Id, Tourist__c>();
            
        for (Id idCurrentTourist : newTourists.keySet()) {
            Boolean isActiveNew = newTourists.get(idCurrentTourist).Active__c;
            Boolean isActiveOld = oldTourists.get(idCurrentTourist).Active__c;
            if (isActiveNew != isActiveOld && isActiveNew == false) {
                touristIsActiveChanged.put(idCurrentTourist, newTourists.get(idCurrentTourist));
            }
        }
        return touristIsActiveChanged;
    }
}