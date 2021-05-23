public class TripInfoController {
    public Id tripId;
    public List<Tourist__c> notRegistredTourists {get;set;}
    
    public TripInfoController(ApexPages.StandardController stdController) {
        this.tripId = (Id)stdController.getId();
        this.notRegistredTourists = TouristManager.getNotRegistredTourists(tripId);
    }
}