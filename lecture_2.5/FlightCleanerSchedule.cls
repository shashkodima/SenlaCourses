public class FlightCleanerSchedule implements Schedulable {
    
    public void execute(SchedulableContext ctx) {
        Database.executeBatch(new FlightCleanerBatch());
    }    
}