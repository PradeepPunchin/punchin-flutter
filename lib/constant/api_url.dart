/// base Url api
var baseUrl = "http://13.235.28.49:7002/api/v1/";

/// authentication api
var loginApi = Uri.parse("${baseUrl}auth/login");
var logoutApi = baseUrl + "auth/logout";

/// home page
var homeCountApi = baseUrl + "agent/getDashboardData";

/// claim data
var getBankerClaimApi = baseUrl + "agent/claim?claimDataFilter=";

// multipart testing
var multipartApi = baseUrl + "banker/claim/0/uploadDocument";

//claim details
var claimDetails = baseUrl + "agent/claim/";
var formUpload = baseUrl + "agent/claim/{claimId}/uploadDocument";
