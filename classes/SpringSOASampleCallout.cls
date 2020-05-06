/* Name: SpringSOASampleCallout
*  Description: SpringSOASampleCallout is used to make a sample Http callout to postman endpoint
*/
public class SpringSOASampleCallout {
    public static void sampleCallout() {
        HttpCalloutService httpService = new HttpCalloutService();
        HttpResponse response = httpService.getHttpCalloutResponse(Constants.PostmanEndpoint);
        if (response.getStatusCode() == 200) {
            String responseBody = response.getBody();
            SampleResponse responseModel = parse(responseBody);
            system.debug('Postman complete response: '+responseBody);
            if(responseModel != null && responseModel.args != null) {
                system.debug('foo1: '+responseModel.args.foo1);
                system.debug('foo2: '+responseModel.args.foo2);
            }
        } else {
            System.debug('Error Code: '+response.getStatusCode());
        }
    }
    
    //@ inner Class SampleResponse: Parse the Postman sample response
    class SampleResponse{
        //defined variable as per response contents
        public argumentResponse args; 
    }
	class argumentResponse {
		public String foo1;	
		public String foo2;	
	}
	public static SampleResponse parse(String json){
		return (SampleResponse) System.JSON.deserialize(json, SampleResponse.class);
	}

}