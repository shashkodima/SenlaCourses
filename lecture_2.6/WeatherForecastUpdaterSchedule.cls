public class WeatherForecastUpdaterSchedule implements Schedulable {
    
    public void execute(SchedulableContext ctx) {
        WeatherForecastUpdater.updateForecasts();
    }    
}