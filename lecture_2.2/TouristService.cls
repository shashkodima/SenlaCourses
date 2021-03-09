public class TouristService {

	public static void markDuplicates(List<Tourist__c> newTourists) {
		List<String> names = new List<String> ();
		List<String> mails = new List<String> ();

		for (Integer i = 0; i < newTourists.size(); i++) {
			String compareName = newTourists[i].Name;
			String compareEmail = newTourists[i].Tourist_EMail__c;
			names.add(compareName);
			mails.add(compareEmail);
		}
		List<Tourist__c> duplTourists = [
		    SELECT Id, Name, IsDuplicate__c
		    FROM Tourist__c
		    WHERE Tourist_EMail__c IN: mails
		    AND Name IN: names];
        insert newTourists;

		for (Integer dupl = 0; dupl < duplTourists.size(); dupl++) {
			duplTourists[dupl].IsDuplicate__c = true;
		}
        update duplTourists;
	}
}