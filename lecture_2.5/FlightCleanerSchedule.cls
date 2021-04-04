public class FlightCleanerSchedule implements Schedulable {
    public void execute(SchedulableContext ctx) {
        database.executeBatch(new FlightCleanerBatch());
    }    
}