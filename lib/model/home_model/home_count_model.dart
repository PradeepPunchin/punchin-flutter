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
  int? aLL;
  int? sETTLED;

  Data({this.iNPROGRESS, this.aLL, this.sETTLED});

  Data.fromJson(Map<String, dynamic> json) {
    iNPROGRESS = json['IN_PROGRESS'];
    aLL = json['ALL'];
    sETTLED = json['SETTLED'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IN_PROGRESS'] = this.iNPROGRESS;
    data['ALL'] = this.aLL;
    data['SETTLED'] = this.sETTLED;
    return data;
  }
}
