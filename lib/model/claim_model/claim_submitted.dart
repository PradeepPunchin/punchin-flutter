class ClaimSubmitted {
  int? timeStamp;
  Data? data;
  String? message;
  bool? isSuccess;
  int? statusCode;

  ClaimSubmitted(
      {this.timeStamp,
      this.data,
      this.message,
      this.isSuccess,
      this.statusCode});

  ClaimSubmitted.fromJson(Map<String, dynamic> json) {
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
  Pageable? pageable;
  bool? last;
  int? totalPages;
  int? totalElements;
  Sort? sort;
  int? numberOfElements;
  bool? first;
  int? size;
  int? number;
  bool? empty;

  Data(
      {this.content,
      this.pageable,
      this.last,
      this.totalPages,
      this.totalElements,
      this.sort,
      this.numberOfElements,
      this.first,
      this.size,
      this.number,
      this.empty});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content?.add(new Content.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    numberOfElements = json['numberOfElements'];
    first = json['first'];
    size = json['size'];
    number = json['number'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content?.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable?.toJson();
    }
    data['last'] = this.last;
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    if (this.sort != null) {
      data['sort'] = this.sort?.toJson();
    }
    data['numberOfElements'] = this.numberOfElements;
    data['first'] = this.first;
    data['size'] = this.size;
    data['number'] = this.number;
    data['empty'] = this.empty;
    return data;
  }
}

class Content {
  int? createdAt;
  int? updatedAt;
  bool? isDeleted;
  bool? isActive;
  int? id;
  String? punchinClaimId;
  String? insurerClaimId;
  String? punchinBankerId;
  int? claimInwardDate;
  String? borrowerName;
  String? borrowerContactNumber;
  String? loanAccountNumber;
  String? borrowerAddress;
  String? borrowerState;
  String? loanType;
  double? loanAmount;
  String? branchCode;
  String? branchName;
  String? branchAddress;
  String? branchPinCode;
  String? branchState;
  String? loanAccountManagerName;
  String? accountManagerContactNumber;
  String? insurerName;
  String? masterPolNumber;
  String? policyNumber;
  int? policyStartDate;
  int? policyCoverageDuration;
  double? policySumAssured;
  String? nomineeName;
  String? nomineeRelationShip;
  String? nomineeContactNumber;
  String? nomineeEmailId;
  String? nomineeAddress;
  String? claimStatus;
  String? submittedBy;
  int? submittedAt;
  bool? isForwardToVerifier;
  int? createdDate;
  int? allocationDate;

  Content(
      {this.createdAt,
      this.updatedAt,
      this.isDeleted,
      this.isActive,
      this.id,
      this.punchinClaimId,
      this.insurerClaimId,
      this.punchinBankerId,
      this.claimInwardDate,
      this.borrowerName,
      this.borrowerContactNumber,
      this.loanAccountNumber,
      this.borrowerAddress,
      this.borrowerState,
      this.loanType,
      this.loanAmount,
      this.branchCode,
      this.branchName,
      this.branchAddress,
      this.branchPinCode,
      this.branchState,
      this.loanAccountManagerName,
      this.accountManagerContactNumber,
      this.insurerName,
      this.masterPolNumber,
      this.policyNumber,
      this.policyStartDate,
      this.policyCoverageDuration,
      this.policySumAssured,
      this.nomineeName,
      this.nomineeRelationShip,
      this.nomineeContactNumber,
      this.nomineeEmailId,
      this.nomineeAddress,
      this.claimStatus,
      this.submittedBy,
      this.submittedAt,
      this.isForwardToVerifier,
      this.createdDate,
      this.allocationDate});

  Content.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    id = json['id'];
    punchinClaimId = json['claimId'];
    insurerClaimId = json['claimId'];
    punchinBankerId = json['punchinBankerId'];
    claimInwardDate = json['claimInwardDate'];
    borrowerName = json['borrowerName'];
    borrowerContactNumber = json['borrowerContactNumber'];
    loanAccountNumber = json['loanAccountNumber'];
    borrowerAddress = json['borrowerAddress'];
    borrowerState = json['borrowerState'];
    loanType = json['loanType'];
    loanAmount = json['loanAmount'];
    branchCode = json['branchCode'];
    branchName = json['branchName'];
    branchAddress = json['branchAddress'];
    branchPinCode = json['branchPinCode'];
    branchState = json['branchState'];
    loanAccountManagerName = json['loanAccountManagerName'];
    accountManagerContactNumber = json['accountManagerContactNumber'];
    insurerName = json['insurerName'];
    masterPolNumber = json['masterPolNumber'];
    policyNumber = json['policyNumber'];
    policyStartDate = json['policyStartDate'];
    policyCoverageDuration = json['policyCoverageDuration'];
    policySumAssured = json['policySumAssured'];
    nomineeName = json['nomineeName'];
    nomineeRelationShip = json['nomineeRelationShip'];
    nomineeContactNumber = json['nomineeContactNumber'];
    nomineeEmailId = json['nomineeEmailId'];
    nomineeAddress = json['nomineeAddress'];
    claimStatus = json['claimStatus'];
    submittedBy = json['submittedBy'];
    submittedAt = json['submittedAt'];
    isForwardToVerifier = json['isForwardToVerifier'];
    createdDate = json['createdDate'];
    allocationDate = json["allocationDate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isDeleted'] = this.isDeleted;
    data['isActive'] = this.isActive;
    data['id'] = this.id;
    data['claimId'] = this.punchinClaimId;
    data['claimId'] = this.insurerClaimId;
    data['punchinBankerId'] = this.punchinBankerId;
    data['claimInwardDate'] = this.claimInwardDate;
    data['borrowerName'] = this.borrowerName;
    data['borrowerContactNumber'] = this.borrowerContactNumber;
    data['loanAccountNumber'] = this.loanAccountNumber;
    data['borrowerAddress'] = this.borrowerAddress;
    data['borrowerState'] = this.borrowerState;
    data['loanType'] = this.loanType;
    data['loanAmount'] = this.loanAmount;
    data['branchCode'] = this.branchCode;
    data['branchName'] = this.branchName;
    data['branchAddress'] = this.branchAddress;
    data['branchPinCode'] = this.branchPinCode;
    data['branchState'] = this.branchState;
    data['loanAccountManagerName'] = this.loanAccountManagerName;
    data['accountManagerContactNumber'] = this.accountManagerContactNumber;
    data['insurerName'] = this.insurerName;
    data['masterPolNumber'] = this.masterPolNumber;
    data['policyNumber'] = this.policyNumber;
    data['policyStartDate'] = this.policyStartDate;
    data['policyCoverageDuration'] = this.policyCoverageDuration;
    data['policySumAssured'] = this.policySumAssured;
    data['nomineeName'] = this.nomineeName;
    data['nomineeRelationShip'] = this.nomineeRelationShip;
    data['nomineeContactNumber'] = this.nomineeContactNumber;
    data['nomineeEmailId'] = this.nomineeEmailId;
    data['nomineeAddress'] = this.nomineeAddress;
    data['claimStatus'] = this.claimStatus;
    data['submittedBy'] = this.submittedBy;
    data['submittedAt'] = this.submittedAt;
    data['isForwardToVerifier'] = this.isForwardToVerifier;
    data['createdDate'] = this.createdDate;
    data["allocationDate"] = this.allocationDate;
    return data;
  }
}

class Pageable {
  Sort? sort;
  int? pageNumber;
  int? pageSize;
  int? offset;
  bool? unpaged;
  bool? paged;

  Pageable(
      {this.sort,
      this.pageNumber,
      this.pageSize,
      this.offset,
      this.unpaged,
      this.paged});

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    offset = json['offset'];
    unpaged = json['unpaged'];
    paged = json['paged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sort != null) {
      data['sort'] = this.sort?.toJson();
    }
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['offset'] = this.offset;
    data['unpaged'] = this.unpaged;
    data['paged'] = this.paged;
    return data;
  }
}

class Sort {
  bool? sorted;
  bool? unsorted;
  bool? empty;

  Sort({this.sorted, this.unsorted, this.empty});

  Sort.fromJson(Map<String, dynamic> json) {
    sorted = json['sorted'];
    unsorted = json['unsorted'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sorted'] = this.sorted;
    data['unsorted'] = this.unsorted;
    data['empty'] = this.empty;
    return data;
  }
}
