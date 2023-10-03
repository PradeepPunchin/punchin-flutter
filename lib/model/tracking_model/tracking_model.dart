class TrackingModel {
  int? timeStamp;
  Data? data;
  String? message;
  bool? isSuccess;
  int? statusCode;

  TrackingModel(
      {this.timeStamp,
        this.data,
        this.message,
        this.isSuccess,
        this.statusCode});

  TrackingModel.fromJson(Map<String, dynamic> json) {
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
  int ?startedAt;
  List<ClaimHistoryDTOS>? claimHistoryDTOS;
  String? claimStatus;

  Data({this.startedAt, this.claimHistoryDTOS, this.claimStatus});

  Data.fromJson(Map<String, dynamic> json) {
    startedAt = json['startedAt'];
    if (json['claimHistoryDTOS'] != null) {
      claimHistoryDTOS =<ClaimHistoryDTOS>[];
      json['claimHistoryDTOS'].forEach((v) {
        claimHistoryDTOS?.add(new ClaimHistoryDTOS.fromJson(v));
      });
    }
    claimStatus = json['claimStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startedAt'] = this.startedAt;
    if (this.claimHistoryDTOS != null) {
      data['claimHistoryDTOS'] =
          this.claimHistoryDTOS?.map((v) => v.toJson()).toList();
    }
    data['claimStatus'] = this.claimStatus;
    return data;
  }
}

class ClaimHistoryDTOS {
  int? createdAt;
  int? claimId;
  String? claimStatus;
  String? description;

  ClaimHistoryDTOS(
      {this.createdAt, this.claimId, this.claimStatus, this.description});

  ClaimHistoryDTOS.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    claimId = json['claimId'];
    claimStatus = json['claimStatus'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['claimId'] = this.claimId;
    data['claimStatus'] = this.claimStatus;
    data['description'] = this.description;
    return data;
  }
}
