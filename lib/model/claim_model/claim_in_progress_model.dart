class WipInProgressModel {
  int? timeStamp;
  Data? data;
  String? message;
  bool? isSuccess;
  int? statusCode;

  WipInProgressModel(
      {this.timeStamp,
        this.data,
        this.message,
        this.isSuccess,
        this.statusCode});

  WipInProgressModel.fromJson(Map<String, dynamic> json) {
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
  List<Content>? content;
  int? size;
  int? totalPages;
  int? totalRecords;

  Data({this.content, this.size, this.totalPages, this.totalRecords});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content =<Content>[];
      json['content'].forEach((v) {
        content?.add(new Content.fromJson(v));
      });
    }
    size = json['size'];
    totalPages = json['totalPages'];
    totalRecords = json['totalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content?.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    data['totalPages'] = this.totalPages;
    data['totalRecords'] = this.totalRecords;
    return data;
  }
}

class Content {
  int? id;
  String? claimId;
  int? claimDate;
  String? nomineeName;
  String? nomineeContactNumber;
  int? allocationDate;
  String ?borrowerName;
  String? borrowerAddress;
  String? claimStatus;

  Content(
      {this.id,
        this.claimId,
        this.claimDate,
        this.nomineeName,
        this.nomineeContactNumber,
        this.allocationDate,
        this.borrowerName,
        this.borrowerAddress,
        this.claimStatus});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    claimId = json['claimId'];
    claimDate = json['claimDate'];
    nomineeName = json['nomineeName'];
    nomineeContactNumber = json['nomineeContactNumber'];
    allocationDate = json['allocationDate'];
    borrowerName = json['borrowerName'];
    borrowerAddress = json['borrowerAddress'];
    claimStatus = json['claimStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['claimId'] = this.claimId;
    data['claimDate'] = this.claimDate;
    data['nomineeName'] = this.nomineeName;
    data['nomineeContactNumber'] = this.nomineeContactNumber;
    data['allocationDate'] = this.allocationDate;
    data['borrowerName'] = this.borrowerName;
    data['borrowerAddress'] = this.borrowerAddress;
    data['claimStatus'] = this.claimStatus;
    return data;
  }
}
