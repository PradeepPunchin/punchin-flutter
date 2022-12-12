class ClaimDiscrepancyModel {
  int? timeStamp;
  Data? data;
  String? message;
  bool? isSuccess;
  int? statusCode;

  ClaimDiscrepancyModel(
      {this.timeStamp,
        this.data,
        this.message,
        this.isSuccess,
        this.statusCode});

  ClaimDiscrepancyModel.fromJson(Map<String, dynamic> json) {
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
  List<ClaimDocuments>? claimDocuments;
  List<String>? rejectedDocList;
  String? message;

  Data({this.claimDocuments, this.rejectedDocList, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['claimDocuments'] != null) {
      claimDocuments = <ClaimDocuments>[];
      json['claimDocuments'].forEach((v) {
        claimDocuments?.add(new ClaimDocuments.fromJson(v));
      });
    }
    rejectedDocList = json['rejectedDocList'].cast<String>();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.claimDocuments != null) {
      data['claimDocuments'] =
          this.claimDocuments?.map((v) => v.toJson()).toList();
    }
    data['rejectedDocList'] = this.rejectedDocList;
    data['message'] = this.message;
    return data;
  }
}

class ClaimDocuments {
  int? id;
  String? agentDocType;
  String? docType;
  bool? isVerified;
  bool? isApproved;
  String? reason;
  List<DocumentUrlDTOS>? documentUrlDTOS;

  ClaimDocuments(
      {this.id,
        this.agentDocType,
        this.docType,
        this.isVerified,
        this.isApproved,
        this.reason,
        this.documentUrlDTOS});

  ClaimDocuments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agentDocType = json['agentDocType'];
    docType = json['docType'];
    isVerified = json['isVerified'];
    isApproved = json['isApproved'];
    reason = json['reason'];
    if (json['documentUrlDTOS'] != null) {
      documentUrlDTOS = <DocumentUrlDTOS>[];
      json['documentUrlDTOS'].forEach((v) {
        documentUrlDTOS?.add(new DocumentUrlDTOS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['agentDocType'] = this.agentDocType;
    data['docType'] = this.docType;
    data['isVerified'] = this.isVerified;
    data['isApproved'] = this.isApproved;
    data['reason'] = this.reason;
    if (this.documentUrlDTOS != null) {
      data['documentUrlDTOS'] =
          this.documentUrlDTOS?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentUrlDTOS {
  String? docUrl;
  String? docFormat;

  DocumentUrlDTOS({this.docUrl, this.docFormat});

  DocumentUrlDTOS.fromJson(Map<String, dynamic> json) {
    docUrl = json['docUrl'];
    docFormat = json['docFormat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docUrl'] = this.docUrl;
    data['docFormat'] = this.docFormat;
    return data;
  }
}
