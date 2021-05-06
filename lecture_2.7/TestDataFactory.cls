@IsTest
public class TestDataFactory {
    
    public static void createTouristsWithFlightsTrips() {
        List<Tourist__c> newTourists = new List<Tourist__c> {
            new Tourist__c(Name = 'Test1', Tourist_EMail__c = 'Test1@outlook.com', Birthdate__c = Date.today() - 370),
            new Tourist__c(Name = 'Test2', Tourist_EMail__c = 'Test2@outlook.com', Birthdate__c = Date.today() - 370),
            new Tourist__c(Name = 'Test3', Tourist_EMail__c = 'Test3@outlook.com', Birthdate__c = Date.today() - 740),
            new Tourist__c(Name = 'Test4', Tourist_EMail__c = 'Test4@outlook.com', Birthdate__c = Date.today() - 740)    
        };
        insert newTourists;
        
        Date dateFirstTrip = Date.newInstance(2021, 11, 01);
        Date dateSecondTrip = Date.newInstance(2022, 11, 01);
        List<Trip__c> newTrips = new List<Trip__c> {
            new Trip__c(Start_Date__c = dateFirstTrip, Minimum_Age__c = 0),
            new Trip__c(Start_Date__c = dateSecondTrip, Minimum_Age__c = 0)
        };
        insert newTrips;
        
        List<Flight__c> newFlights = new List<Flight__c> {
            new Flight__c(Tourist__c = newTourists[0].Id, Trip__c = newTrips[0].Id),
            new Flight__c(Tourist__c = newTourists[1].Id, Trip__c = newTrips[0].Id),
            new Flight__c(Tourist__c = newTourists[2].Id, Trip__c = newTrips[1].Id)
        };
        insert newFlights;    
    }
    
    public static void createSpacePointsWithWeatherForecasts() {
        List<Space_Point__c> testSpacePoints = new List<Space_Point__c> {
            new Space_Point__c(Name = 'Test1', Latitude__c = 1, Longitude__c = 1),
            new Space_Point__c(Name = 'Test2', Latitude__c = 2, Longitude__c = 2),
            new Space_Point__c(Name = 'Test3', Latitude__c = 3, Longitude__c = 3)    
        };
        insert testSpacePoints;
        List<Weather_Daily_Forecast__c> testForecasts = new List<Weather_Daily_Forecast__c>();
        
        for (Space_Point__c spacePoint : testSpacePoints) {
            Weather_Daily_Forecast__c testForecast = new Weather_Daily_Forecast__c();
            testForecast.Space_Point__c = spacePoint.Id;
            testForecasts.add(testForecast);
        }
        insert testForecasts;
    }
    
    public static Flight__c createDataForFlightTriggerTest (Date touristBirthdate, Double minAgeForTrip, Date tripDate) {
        Tourist__c newTourist = new Tourist__c(Name = 'Test1', Birthdate__c = touristBirthdate);
        insert newTourist;
        Trip__c newTrip = new Trip__c(Start_Date__c = tripDate, Minimum_Age__c = minAgeForTrip);
        insert newTrip;
        Flight__c newFlight = new Flight__c(Tourist__c = newTourist.Id, Trip__c = newTrip.Id);
        return newFlight;
    }
    
    public static void createDataForFlightCleanerBatch(Integer numberDeclinedFlights, Integer numberRelevantFlights) {
        Tourist__c newTourist = new Tourist__c(Name = 'Test1');
        insert newTourist;
        Trip__c newTrip = new Trip__c(Start_Date__c = Date.today(), Minimum_Age__c = 0);
        insert newTrip;
        List<Flight__c> testFlights = new List<Flight__c>();
        
        for (Integer i = 0; i < numberDeclinedFlights; i++){
            Flight__c newFlight = new Flight__c();
            newFlight.Status__c = 'Declined';
            newFlight.Tourist__c = newTourist.Id;
            newFlight.Trip__c = newTrip.Id;
            testFlights.add(newFlight);
        }
        
        for (Integer i = 0; i < numberRelevantFlights; i++){
            Flight__c newFlight = new Flight__c();
            newFlight.Tourist__c = newTourist.Id;
            newFlight.Trip__c = newTrip.Id;
            testFlights.add(newFlight);
        }
        insert testFlights;
    }            
}