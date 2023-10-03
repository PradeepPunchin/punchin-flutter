// class ClaimDetails {
//   int? timeStamp;
//   Data? data;
//   String ?message;
//   bool? isSuccess;
//   int? statusCode;
//
//   ClaimDetails(
//       {this.timeStamp,
//         this.data,
//         this.message,
//         this.isSuccess,
//         this.statusCode});
//
//   ClaimDetails.fromJson(Map<String, dynamic> json) {
//     timeStamp = json['timeStamp'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     message = json['message'];
//     isSuccess = json['isSuccess'];
//     statusCode = json['statusCode'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['timeStamp'] = this.timeStamp;
//     if (this.data != null) {
//       data['data'] = this.data?.toJson();
//     }
//     data['message'] = this.message;
//     data['isSuccess'] = this.isSuccess;
//     data['statusCode'] = this.statusCode;
//     return data;
//   }
// }
//
// class Data {
//   List<ClaimDocuments>? claimDocuments;
//   ClaimData? claimData;
//   String? message;
//
//   Data({this.claimDocuments, this.claimData, this.message});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['claimDocuments'] != null) {
//       claimDocuments = <ClaimDocuments>[];
//       json['claimDocuments'].forEach((v) {
//         claimDocuments?.add(new ClaimDocuments.fromJson(v));
//       });
//     }
//     claimData = json['claimData'] != null
//         ? new ClaimData.fromJson(json['claimData'])
//         : null;
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.claimDocuments != null) {
//       data['claimDocuments'] =
//           this.claimDocuments?.map((v) => v.toJson()).toList();
//     }
//     if (this.claimData != null) {
//       data['claimData'] = this.claimData?.toJson();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class ClaimDocuments {
//   int? id;
//   String ?punchinClaimId;
//   int? claimDate;
//   String? borrowerName;
//   String? nomineeName;
//   String? nomineeContactNumber;
//   String? nomineeAddress;
//   String? borrowerAddress;
//   String? claimStatus;
//   String? singnedClaimDocument;
//   String? deathCertificate;
//   String? borrowerIdProof;
//   String? borrowerAddressProof;
//   String? nomineeIdProof;
//   String? nomineeAddressProof;
//   String? bankAccountProof;
//   String? firPostmortemReport;
//   String? additionalDoc;
//   String? relationshipDoc;
//   String? guardianIdProof;
//   String? guardianAddressProof;
//
//   ClaimDocuments(
//       {this.id,
//         this.punchinClaimId,
//         this.claimDate,
//         this.borrowerName,
//         this.nomineeName,
//         this.nomineeContactNumber,
//         this.nomineeAddress,
//         this.borrowerAddress,
//         this.claimStatus,
//         this.singnedClaimDocument,
//         this.deathCertificate,
//         this.borrowerIdProof,
//         this.borrowerAddressProof,
//         this.nomineeIdProof,
//         this.nomineeAddressProof,
//         this.bankAccountProof,
//         this.firPostmortemReport,
//         this.additionalDoc,
//         this.relationshipDoc,
//         this.guardianIdProof,
//         this.guardianAddressProof});
//
//   ClaimDocuments.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     punchinClaimId = json['punchinClaimId'];
//     claimDate = json['claimDate'];
//     borrowerName = json['borrowerName'];
//     nomineeName = json['nomineeName'];
//     nomineeContactNumber = json['nomineeContactNumber'];
//     nomineeAddress = json['nomineeAddress'];
//     borrowerAddress = json['borrowerAddress'];
//     claimStatus = json['claimStatus'];
//     singnedClaimDocument = json['singnedClaimDocument'];
//     deathCertificate = json['deathCertificate'];
//     borrowerIdProof = json['borrowerIdProof'];
//     borrowerAddressProof = json['borrowerAddressProof'];
//     nomineeIdProof = json['nomineeIdProof'];
//     nomineeAddressProof = json['nomineeAddressProof'];
//     bankAccountProof = json['bankAccountProof'];
//     firPostmortemReport = json['firPostmortemReport'];
//     additionalDoc = json['additionalDoc'];
//     relationshipDoc = json['relationshipDoc'];
//     guardianIdProof = json['guardianIdProof'];
//     guardianAddressProof = json['guardianAddressProof'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['punchinClaimId'] = this.punchinClaimId;
//     data['claimDate'] = this.claimDate;
//     data['borrowerName'] = this.borrowerName;
//     data['nomineeName'] = this.nomineeName;
//     data['nomineeContactNumber'] = this.nomineeContactNumber;
//     data['nomineeAddress'] = this.nomineeAddress;
//     data['borrowerAddress'] = this.borrowerAddress;
//     data['claimStatus'] = this.claimStatus;
//     data['singnedClaimDocument'] = this.singnedClaimDocument;
//     data['deathCertificate'] = this.deathCertificate;
//     data['borrowerIdProof'] = this.borrowerIdProof;
//     data['borrowerAddressProof'] = this.borrowerAddressProof;
//     data['nomineeIdProof'] = this.nomineeIdProof;
//     data['nomineeAddressProof'] = this.nomineeAddressProof;
//     data['bankAccountProof'] = this.bankAccountProof;
//     data['firPostmortemReport'] = this.firPostmortemReport;
//     data['additionalDoc'] = this.additionalDoc;
//     data['relationshipDoc'] = this.relationshipDoc;
//     data['guardianIdProof'] = this.guardianIdProof;
//     data['guardianAddressProof'] = this.guardianAddressProof;
//     return data;
//   }
// }
//
// class ClaimData {
//   int? createdAt;
//   int? updatedAt;
//   bool? isDeleted;
//   bool? isActive;
//   int? id;
//   int? uploadDate;
//   String? punchinClaimId;
//   String? insurerClaimId;
//   String? punchinBankerId;
//   int? claimInwardDate;
//   String? borrowerName;
//   String? borrowerContactNumber;
//   String? borrowerCity;
//   String? borrowerState;
//   String? borrowerPinCode;
//   String? borrowerEmailId;
//   String? borrowerAlternateContactNumber;
//   String? borrowerAlternateContactDetails;
//   Null? borrowerDob;
//   String? loanAccountNumber;
//   String? borrowerAddress;
//   String? loanType;
//   int? loanDisbursalDate;
//   double? loanOutstandingAmount;
//   double? loanAmount;
//   Null? loanAmountPaidByBorrower;
//   Null? loanAmountBalance;
//   String? branchCode;
//   Null? branchName;
//   String? branchAddress;
//   String? branchPinCode;
//   String? branchCity;
//   String? branchState;
//   String? loanAccountManagerName;
//   String? accountManagerContactNumber;
//   String? insurerName;
//   String? masterPolNumber;
//   String? policyNumber;
//   int? policyStartDate;
//   int? policyCoverageDuration;
//   int? policySumAssured;
//   String? nomineeName;
//   String? nomineeRelationShip;
//   String? nomineeContactNumber;
//   String? nomineeEmailId;
//   String? nomineeAddress;
//   String? claimStatus;
//   Null? claimBankerStatus;
//   int? agentId;
//   int? bankerId;
//   Null? submittedBy;
//   Null? submittedAt;
//   bool? isForwardToVerifier;
//   Null? causeOfDeath;
//   Null? isMinor;
//   int? createdDate;
//
//   ClaimData(
//       {this.createdAt,
//         this.updatedAt,
//         this.isDeleted,
//         this.isActive,
//         this.id,
//         this.uploadDate,
//         this.punchinClaimId,
//         this.insurerClaimId,
//         this.punchinBankerId,
//         this.claimInwardDate,
//         this.borrowerName,
//         this.borrowerContactNumber,
//         this.borrowerCity,
//         this.borrowerState,
//         this.borrowerPinCode,
//         this.borrowerEmailId,
//         this.borrowerAlternateContactNumber,
//         this.borrowerAlternateContactDetails,
//         this.borrowerDob,
//         this.loanAccountNumber,
//         this.borrowerAddress,
//         this.loanType,
//         this.loanDisbursalDate,
//         this.loanOutstandingAmount,
//         this.loanAmount,
//         this.loanAmountPaidByBorrower,
//         this.loanAmountBalance,
//         this.branchCode,
//         this.branchName,
//         this.branchAddress,
//         this.branchPinCode,
//         this.branchCity,
//         this.branchState,
//         this.loanAccountManagerName,
//         this.accountManagerContactNumber,
//         this.insurerName,
//         this.masterPolNumber,
//         this.policyNumber,
//         this.policyStartDate,
//         this.policyCoverageDuration,
//         this.policySumAssured,
//         this.nomineeName,
//         this.nomineeRelationShip,
//         this.nomineeContactNumber,
//         this.nomineeEmailId,
//         this.nomineeAddress,
//         this.claimStatus,
//         this.claimBankerStatus,
//         this.agentId,
//         this.bankerId,
//         this.submittedBy,
//         this.submittedAt,
//         this.isForwardToVerifier,
//         this.causeOfDeath,
//         this.isMinor,
//         this.createdDate});
//
//   ClaimData.fromJson(Map<String, dynamic> json) {
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     isDeleted = json['isDeleted'];
//     isActive = json['isActive'];
//     id = json['id'];
//     uploadDate = json['uploadDate'];
//     punchinClaimId = json['punchinClaimId'];
//     insurerClaimId = json['insurerClaimId'];
//     punchinBankerId = json['punchinBankerId'];
//     claimInwardDate = json['claimInwardDate'];
//     borrowerName = json['borrowerName'];
//     borrowerContactNumber = json['borrowerContactNumber'];
//     borrowerCity = json['borrowerCity'];
//     borrowerState = json['borrowerState'];
//     borrowerPinCode = json['borrowerPinCode'];
//     borrowerEmailId = json['borrowerEmailId'];
//     borrowerAlternateContactNumber = json['borrowerAlternateContactNumber'];
//     borrowerAlternateContactDetails = json['borrowerAlternateContactDetails'];
//     borrowerDob = json['borrowerDob'];
//     loanAccountNumber = json['loanAccountNumber'];
//     borrowerAddress = json['borrowerAddress'];
//     loanType = json['loanType'];
//     loanDisbursalDate = json['loanDisbursalDate'];
//     loanOutstandingAmount = json['loanOutstandingAmount'];
//     loanAmount = json['loanAmount'];
//     loanAmountPaidByBorrower = json['loanAmountPaidByBorrower'];
//     loanAmountBalance = json['loanAmountBalance'];
//     branchCode = json['branchCode'];
//     branchName = json['branchName'];
//     branchAddress = json['branchAddress'];
//     branchPinCode = json['branchPinCode'];
//     branchCity = json['branchCity'];
//     branchState = json['branchState'];
//     loanAccountManagerName = json['loanAccountManagerName'];
//     accountManagerContactNumber = json['accountManagerContactNumber'];
//     insurerName = json['insurerName'];
//     masterPolNumber = json['masterPolNumber'];
//     policyNumber = json['policyNumber'];
//     policyStartDate = json['policyStartDate'];
//     policyCoverageDuration = json['policyCoverageDuration'];
//     policySumAssured = json['policySumAssured'];
//     nomineeName = json['nomineeName'];
//     nomineeRelationShip = json['nomineeRelationShip'];
//     nomineeContactNumber = json['nomineeContactNumber'];
//     nomineeEmailId = json['nomineeEmailId'];
//     nomineeAddress = json['nomineeAddress'];
//     claimStatus = json['claimStatus'];
//     claimBankerStatus = json['claimBankerStatus'];
//     agentId = json['agentId'];
//     bankerId = json['bankerId'];
//     submittedBy = json['submittedBy'];
//     submittedAt = json['submittedAt'];
//     isForwardToVerifier = json['isForwardToVerifier'];
//     causeOfDeath = json['causeOfDeath'];
//     isMinor = json['isMinor'];
//     createdDate = json['createdDate'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['isDeleted'] = this.isDeleted;
//     data['isActive'] = this.isActive;
//     data['id'] = this.id;
//     data['uploadDate'] = this.uploadDate;
//     data['punchinClaimId'] = this.punchinClaimId;
//     data['insurerClaimId'] = this.insurerClaimId;
//     data['punchinBankerId'] = this.punchinBankerId;
//     data['claimInwardDate'] = this.claimInwardDate;
//     data['borrowerName'] = this.borrowerName;
//     data['borrowerContactNumber'] = this.borrowerContactNumber;
//     data['borrowerCity'] = this.borrowerCity;
//     data['borrowerState'] = this.borrowerState;
//     data['borrowerPinCode'] = this.borrowerPinCode;
//     data['borrowerEmailId'] = this.borrowerEmailId;
//     data['borrowerAlternateContactNumber'] =
//         this.borrowerAlternateContactNumber;
//     data['borrowerAlternateContactDetails'] =
//         this.borrowerAlternateContactDetails;
//     data['borrowerDob'] = this.borrowerDob;
//     data['loanAccountNumber'] = this.loanAccountNumber;
//     data['borrowerAddress'] = this.borrowerAddress;
//     data['loanType'] = this.loanType;
//     data['loanDisbursalDate'] = this.loanDisbursalDate;
//     data['loanOutstandingAmount'] = this.loanOutstandingAmount;
//     data['loanAmount'] = this.loanAmount;
//     data['loanAmountPaidByBorrower'] = this.loanAmountPaidByBorrower;
//     data['loanAmountBalance'] = this.loanAmountBalance;
//     data['branchCode'] = this.branchCode;
//     data['branchName'] = this.branchName;
//     data['branchAddress'] = this.branchAddress;
//     data['branchPinCode'] = this.branchPinCode;
//     data['branchCity'] = this.branchCity;
//     data['branchState'] = this.branchState;
//     data['loanAccountManagerName'] = this.loanAccountManagerName;
//     data['accountManagerContactNumber'] = this.accountManagerContactNumber;
//     data['insurerName'] = this.insurerName;
//     data['masterPolNumber'] = this.masterPolNumber;
//     data['policyNumber'] = this.policyNumber;
//     data['policyStartDate'] = this.policyStartDate;
//     data['policyCoverageDuration'] = this.policyCoverageDuration;
//     data['policySumAssured'] = this.policySumAssured;
//     data['nomineeName'] = this.nomineeName;
//     data['nomineeRelationShip'] = this.nomineeRelationShip;
//     data['nomineeContactNumber'] = this.nomineeContactNumber;
//     data['nomineeEmailId'] = this.nomineeEmailId;
//     data['nomineeAddress'] = this.nomineeAddress;
//     data['claimStatus'] = this.claimStatus;
//     data['claimBankerStatus'] = this.claimBankerStatus;
//     data['agentId'] = this.agentId;
//     data['bankerId'] = this.bankerId;
//     data['submittedBy'] = this.submittedBy;
//     data['submittedAt'] = this.submittedAt;
//     data['isForwardToVerifier'] = this.isForwardToVerifier;
//     data['causeOfDeath'] = this.causeOfDeath;
//     data['isMinor'] = this.isMinor;
//     data['createdDate'] = this.createdDate;
//     return data;
//   }
// }
//
//
//
//
//
 // To parse this JSON data, do
 //
//     final claimDetails = claimDetailsFromJson(jsonString);

import 'dart:convert';

ClaimDetails claimDetailsFromJson(String str) =>
    ClaimDetails.fromJson(json.decode(str));

String claimDetailsToJson(ClaimDetails data) => json.encode(data.toJson());

class ClaimDetails {
  ClaimDetails({
    required this.timeStamp,
    required this.data,
    required this.message,
    required this.isSuccess,
    required this.statusCode,
  });

  int timeStamp;
  ClaimDetails? data;
  String message;
  bool isSuccess;
  int statusCode;

  factory ClaimDetails.fromJson(Map<String, dynamic> json) => ClaimDetails(
        timeStamp: json["timeStamp"] == null ? null : json["timeStamp"],
        data: json["data"] == null ? null : ClaimDetails.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
        isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "timeStamp": timeStamp == null ? null : timeStamp,
        "data": data == null ? null : data!.toJson(),
        "message": message == null ? null : message,
        "isSuccess": isSuccess == null ? null : isSuccess,
        "statusCode": statusCode == null ? null : statusCode,
      };
}

class ClaimDetailsData {
  ClaimDetailsData({
    this.createdAt,
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
    this.borrowerDob,
    this.borrowerEmailId,
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
  });

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
  int? borrowerDob;
  String? borrowerEmailId;
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

  factory ClaimDetailsData.fromJson(Map<String, dynamic> json) =>
      ClaimDetailsData(
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        isDeleted: json["isDeleted"] == null ? null : json["isDeleted"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        id: json["id"] == null ? null : json["id"],
        punchinClaimId:
            json["punchinClaimId"] == null ? null : json["punchinClaimId"],
        insurerClaimId:
            json["insurerClaimId"] == null ? null : json["insurerClaimId"],
        punchinBankerId:
            json["punchinBankerId"] == null ? null : json["punchinBankerId"],
        claimInwardDate:
            json["claimInwardDate"] == null ? null : json["claimInwardDate"],
        borrowerName:
            json["borrowerName"] == null ? null : json["borrowerName"],
        borrowerContactNumber: json["borrowerContactNumber"] == null ? null : json["borrowerContactNumber"],
        borrowerDob:json["borrowerDob"] == null ? null : json["borrowerDob"],
        borrowerEmailId : json["borrowerEmailId"] == null ? null : json["borrowerEmailId"],
        loanAccountNumber: json["loanAccountNumber"] == null
            ? null
            : json["loanAccountNumber"],
        borrowerAddress:
            json["borrowerAddress"] == null ? null : json["borrowerAddress"],
        borrowerState:
            json["borrowerState"] == null ? null : json["borrowerState"],
        loanType: json["loanType"] == null ? null : json["loanType"],
        loanAmount: json["loanAmount"] == null ? null : json["loanAmount"],
        branchCode: json["branchCode"] == null ? null : json["branchCode"],
        branchName: json["branchName"] == null ? null : json["branchName"],
        branchAddress:
            json["branchAddress"] == null ? null : json["branchAddress"],
        branchPinCode:
            json["branchPinCode"] == null ? null : json["branchPinCode"],
        branchState: json["branchState"] == null ? null : json["branchState"],
        loanAccountManagerName: json["loanAccountManagerName"] == null
            ? null
            : json["loanAccountManagerName"],
        accountManagerContactNumber: json["accountManagerContactNumber"] == null
            ? null
            : json["accountManagerContactNumber"],
        insurerName: json["insurerName"] == null ? null : json["insurerName"],
        masterPolNumber:
            json["masterPolNumber"] == null ? null : json["masterPolNumber"],
        policyNumber:
            json["policyNumber"] == null ? null : json["policyNumber"],
        policyStartDate:
            json["policyStartDate"] == null ? null : json["policyStartDate"],
        policyCoverageDuration: json["policyCoverageDuration"] == null
            ? null
            : json["policyCoverageDuration"],
        policySumAssured:
            json["policySumAssured"] == null ? null : json["policySumAssured"],
        nomineeName: json["nomineeName"] == null ? null : json["nomineeName"],
        nomineeRelationShip: json["nomineeRelationShip"] == null
            ? null
            : json["nomineeRelationShip"],
        nomineeContactNumber: json["nomineeContactNumber"] == null
            ? null
            : json["nomineeContactNumber"],
        nomineeEmailId:
            json["nomineeEmailId"] == null ? null : json["nomineeEmailId"],
        nomineeAddress:
            json["nomineeAddress"] == null ? null : json["nomineeAddress"],
        claimStatus: json["claimStatus"] == null ? null : json["claimStatus"],
        submittedBy: json["submittedBy"] == null ? null : json["submittedBy"],
        submittedAt: json["submittedAt"] == null ? null : json["submittedAt"],
        isForwardToVerifier: json["isForwardToVerifier"] == null
            ? null
            : json["isForwardToVerifier"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "isDeleted": isDeleted == null ? null : isDeleted,
        "isActive": isActive == null ? null : isActive,
        "id": id == null ? null : id,
        "punchinClaimId": punchinClaimId == null ? null : punchinClaimId,
        "insurerClaimId": insurerClaimId == null ? null : insurerClaimId,
        "punchinBankerId": punchinBankerId == null ? null : punchinBankerId,
        "claimInwardDate": claimInwardDate == null ? null : claimInwardDate,
        "borrowerName": borrowerName == null ? null : borrowerName,
        "borrowerContactNumber":
            borrowerContactNumber == null ? null : borrowerContactNumber,
        "borrowerDob":borrowerDob==null? null:borrowerDob,
        "borrowerEmailId":borrowerEmailId==null?null:borrowerEmailId,
        "loanAccountNumber":
            loanAccountNumber == null ? null : loanAccountNumber,
        "borrowerAddress": borrowerAddress == null ? null : borrowerAddress,
        "borrowerState": borrowerState == null ? null : borrowerState,
        "loanType": loanType == null ? null : loanType,
        "loanAmount": loanAmount == null ? null : loanAmount,
        "branchCode": branchCode == null ? null : branchCode,
        "branchName": branchName == null ? null : branchName,
        "branchAddress": branchAddress == null ? null : branchAddress,
        "branchPinCode": branchPinCode == null ? null : branchPinCode,
        "branchState": branchState == null ? null : branchState,
        "loanAccountManagerName":
            loanAccountManagerName == null ? null : loanAccountManagerName,
        "accountManagerContactNumber": accountManagerContactNumber == null
            ? null
            : accountManagerContactNumber,
        "insurerName": insurerName == null ? null : insurerName,
        "masterPolNumber": masterPolNumber == null ? null : masterPolNumber,
        "policyNumber": policyNumber == null ? null : policyNumber,
        "policyStartDate": policyStartDate == null ? null : policyStartDate,
        "policyCoverageDuration":
            policyCoverageDuration == null ? null : policyCoverageDuration,
        "policySumAssured": policySumAssured == null ? null : policySumAssured,
        "nomineeName": nomineeName == null ? null : nomineeName,
        "nomineeRelationShip":
            nomineeRelationShip == null ? null : nomineeRelationShip,
        "nomineeContactNumber":
            nomineeContactNumber == null ? null : nomineeContactNumber,
        "nomineeEmailId": nomineeEmailId == null ? null : nomineeEmailId,
        "nomineeAddress": nomineeAddress == null ? null : nomineeAddress,
        "claimStatus": claimStatus == null ? null : claimStatus,
        "submittedBy": submittedBy == null ? null : submittedBy,
        "submittedAt": submittedAt == null ? null : submittedAt,
        "isForwardToVerifier":
            isForwardToVerifier == null ? null : isForwardToVerifier,
        "createdDate": createdDate == null ? null : createdDate,
      };
}
