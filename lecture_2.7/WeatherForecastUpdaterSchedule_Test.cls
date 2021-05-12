@IsTest
public class WeatherForecastUpdaterSchedule_Test {
    
    @IsTest
    public static void testWeatherForecastUpdaterSchedule() {
        Test.startTest();
        WeatherForecastUpdaterSchedule newJob = new WeatherForecastUpdaterSchedule();
        String cron = '0 0 0 2 7 ? 2021';
        String jobId = System.schedule('Weather Forecast Update Process', cron, newJob);
        Test.stopTest();
        
        CronTrigger currentCronTrigger = [
            SELECT Id,
            CronExpression,
            TimesTriggered,
            NextFireTime
            FROM CronTrigger
            WHERE id = :jobId];        
        System.assertEquals(cron, currentCronTrigger.CronExpression);
        System.assertEquals('2021-07-02 00:00:00', String.valueOf(currentCronTrigger.NextFireTime));   
    }
}