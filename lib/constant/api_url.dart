/// base Url api
 var baseUrl = "http://13.235.28.49:7002/api/v1/";
//var baseUrl = "https://edbe-2401-4900-2e8b-7013-2b-a1e3-5d34-f7d4.in.ngrok.io/api/v1/";
//"https://81ac-223-190-86-159.in.ngrok.io/api/v1/";
/// authentication api
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
