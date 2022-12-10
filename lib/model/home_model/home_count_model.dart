class HomeCount {
  int? timeStamp;
  Data? data;
  String? message;
  bool? isSuccess;
  int? statusCode;

  HomeCount(
      {this.timeStamp,
        this.data,
        this.message,
        this.isSuccess,
        this.statusCode});

  HomeCount.fromJson(Map<String, dynamic> json) {
    timeStamp = json['timeStamp'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    isSuccess = json['isSuccess'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeStamp'] = this.timeStamp;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['message'] = this.message;
    data['isSuccess'] = this.isSuccess;
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Data {
  int? iNPROGRESS;
  int? uNDERVERIFICATION;
  int? aCTIONPENDING;
  int? aGENTALLOCATED;

  Data(
      {this.iNPROGRESS,
        this.uNDERVERIFICATION,
        this.aCTIONPENDING,
        this.aGENTALLOCATED});

  Data.fromJson(Map<String, dynamic> json) {
    iNPROGRESS = json['IN_PROGRESS'];
    uNDERVERIFICATION = json['UNDER_VERIFICATION'];
    aCTIONPENDING = json['ACTION_PENDING'];
    aGENTALLOCATED = json['AGENT_ALLOCATED'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IN_PROGRESS'] = this.iNPROGRESS;
    data['UNDER_VERIFICATION'] = this.uNDERVERIFICATION;
    data['ACTION_PENDING'] = this.aCTIONPENDING;
    data['AGENT_ALLOCATED'] = this.aGENTALLOCATED;
    return data;
  }
}
