/* Name: HttpCalloutService
*  Description: HttpCalloutService is used as a service for the Http Callout.
*/
public class HttpCalloutService {
    // Pass in the endpoint to be used using the string url
    public HttpResponse getHttpCalloutResponse(String endpoint) {
  
        // Instantiate a new http object
        Http http = new Http();
    
         // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod(Constants.RequestType_GET);
    
        // Send the request, and return a response
        HttpResponse res = http.send(req);
        return res;
      }
}