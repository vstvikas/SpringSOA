@isTest
global class HttpMockResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        //Send a mock response for a specific endpoint
        if(Constants.PostmanEndpoint == req.getEndpoint()) {
            // return a mock response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"args":{"foo1":"bar1","foo2":"bar2"}');
            res.setStatusCode(200);
            return res;
        }
        return null;
    }
}