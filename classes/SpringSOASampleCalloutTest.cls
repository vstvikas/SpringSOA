@isTest
public class SpringSOASampleCalloutTest {
    @isTest private static void TestSampleCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new HttpMockResponseGenerator());
        
        Test.startTest();
        SpringSOASampleCallout.sampleCallout(); 
        Test.stopTest();
    }
}