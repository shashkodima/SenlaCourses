public class TouristService {

	public static void markDuplicates(List < Tourist__c > newTourists) {
		List < String > names = new List < String > ();
		List < String > mails = new List < String > ();

		for (Integer i = 0; i < newTourists.size(); i++) {
			String compareName = newTourists[i].Name;
			String compareEmail = newTourists[i].Tourist_EMail__c;
			names.add(compareName);
			mails.add(compareEmail);
		}
		List < Tourist__c > duplTourists = [
		SELECT Id, Name, Tourist_EMail__c
		FROM Tourist__c
		WHERE Tourist_EMail__c IN: mails
		AND Name IN: names];

		for (Integer newtour = 0; newtour < newTourists.size(); newtour++) {
			for (Integer dupltour = 0; dupltour < duplTourists.size(); dupltour++) {
				if (newTourists[newtour].Name == duplTourists[dupltour].Name && newTourists[newtour].Tourist_EMail__c == duplTourists[dupltour].Tourist_EMail__c) {
					newTourists[newtour].IsDuplicate__c = true;
				}
			}
		}
	}
}