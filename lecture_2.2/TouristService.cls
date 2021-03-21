public class TouristService {

	public static void markDuplicates(List < Tourist__c > newTourists) {
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
        insert newTourists;
	}
}