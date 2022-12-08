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
  String? loanAccountNumber;
  String? borrowerAddress;
  String? borrowerState;
  String? loanType;
  int? loanAmount;
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
  int? policySumAssured;
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
        borrowerContactNumber: json["borrowerContactNumber"] == null
            ? null
            : json["borrowerContactNumber"],
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
