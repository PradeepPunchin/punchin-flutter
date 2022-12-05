
/// base Url api
var baseUrl ="http://13.235.28.49:7002/api/v1/";


/// authentication api
var loginApi=Uri.parse("${baseUrl}auth/login");
var logoutApi = baseUrl+"auth/logout";

/// home page
var homeCountApi = baseUrl+"banker/getDashboardData";