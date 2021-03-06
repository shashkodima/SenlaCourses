@IsTest
private class FlightCleanerSchedule_Test {
    
    @IsTest
    private static void testFlightCleanerSchedule() {
        
        Test.startTest();
        FlightCleanerSchedule newJob = new FlightCleanerSchedule();
        String cron = '0 0 0 2 7 ? 2021';
        String jobId = System.schedule('Flight Cleaner Process', cron, newJob);
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