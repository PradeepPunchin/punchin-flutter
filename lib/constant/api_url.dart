/// base Url api
/// developement
var baseUrl = "http://13.235.28.49:7002/api/v1/";
// "http://3.110.250.144:7002/api/v1/" ; "https://4b25-2401-4900-5fc1-f02c-323a-c379-8978-ccd1.in.ngrok.io/api/v1/";//
// "http://13.235.28.49:7002/api/v1/";
//  "http://15.207.183.245:7002/api/v1/";
// authentication api
var loginApi = Uri.parse("${baseUrl}auth/login");
var logoutApi = baseUrl + "auth/logout";

/// home page
var homeCountApi = baseUrl + "agent/getDashboardData";

/// claim data
var getAgentClaimApi = baseUrl + "agent/claim?claimDataFilter=";

// multipart testing
var multipartApi = baseUrl + "banker/claim/0/uploadDocument";

//claim details
var claimDetails = baseUrl + "agent/claim/";
var formUpload = baseUrl + "agent/claim/";
var formUploadNew = baseUrl + "agent/claim/uploadDocumentNew1";
var formUploadNewOne = baseUrl + "agent/claim/uploadDocumentNew2";
var ClaimDiscrepeancyApi = baseUrl + "agent/claim/";

/// search
var SearchApi = baseUrl + "agent/claim/search?searchCaseEnum=";
