
/// base Url api
var baseUrl ="http://13.235.28.49:7002/api/v1/";


/// authentication api
var loginApi=Uri.parse("${baseUrl}auth/login");
var logoutApi = baseUrl+"auth/logout";

/// home page
var homeCountApi = baseUrl+"banker/getDashboardData";


/// claim data
var getBankerClaimApi= baseUrl + "banker/claim?claimDataFilter=SUBMITTED&page=1&limit=10" ;


// multipart testing
var multipartApi=baseUrl + "banker/claim/0/uploadDocument";