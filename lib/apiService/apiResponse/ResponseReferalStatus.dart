// @dart=2.9
class ResponseReferalStatus {
  int errorCode;
  String reponseString;
  Data data;

  ResponseReferalStatus({this.errorCode, this.reponseString, this.data});

  ResponseReferalStatus.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    reponseString = json['reponse_string'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_code'] = this.errorCode;
    data['reponse_string'] = this.reponseString;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String id;
  String clientKey;
  String userType;
  String linkedId;
  String name;
  String phone;
  String email;
  String image;
  String fcmToken;
  String bio;
  String address;
  String aadhaarCard;
  String paymentType;
  String accountHolderName;
  String bankName;
  String ifsc;
  String branch;
  String cancelledChequeImage;
  String upi;
  String gender;
  String dob;
  String weight;
  String height;
  String goal;
  String occupations;
  String relationshipStatus;
  String privacyStatus;
  String referalCode;
  String workoutExperience;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Data(
      {this.id,
        this.clientKey,
        this.userType,
        this.linkedId,
        this.name,
        this.phone,
        this.email,
        this.image,
        this.fcmToken,
        this.bio,
        this.address,
        this.aadhaarCard,
        this.paymentType,
        this.accountHolderName,
        this.bankName,
        this.ifsc,
        this.branch,
        this.cancelledChequeImage,
        this.upi,
        this.gender,
        this.dob,
        this.weight,
        this.height,
        this.goal,
        this.occupations,
        this.relationshipStatus,
        this.privacyStatus,
        this.referalCode,
        this.workoutExperience,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientKey = json['client_key'];
    userType = json['user_type'];
    linkedId = json['linked_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    fcmToken = json['fcm_token'];
    bio = json['bio'];
    address = json['address'];
    aadhaarCard = json['aadhaar_card'];
    paymentType = json['payment_type'];
    accountHolderName = json['account_holder_name'];
    bankName = json['bank_name'];
    ifsc = json['ifsc'];
    branch = json['branch'];
    cancelledChequeImage = json['cancelled_cheque_image'];
    upi = json['upi'];
    gender = json['gender'];
    dob = json['dob'];
    weight = json['weight'];
    height = json['height'];
    goal = json['goal'];
    occupations = json['occupations'];
    relationshipStatus = json['relationship_status'];
    privacyStatus = json['privacy_status'];
    referalCode = json['referal_code'];
    workoutExperience = json['workout_experience'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_key'] = this.clientKey;
    data['user_type'] = this.userType;
    data['linked_id'] = this.linkedId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['image'] = this.image;
    data['fcm_token'] = this.fcmToken;
    data['bio'] = this.bio;
    data['address'] = this.address;
    data['aadhaar_card'] = this.aadhaarCard;
    data['payment_type'] = this.paymentType;
    data['account_holder_name'] = this.accountHolderName;
    data['bank_name'] = this.bankName;
    data['ifsc'] = this.ifsc;
    data['branch'] = this.branch;
    data['cancelled_cheque_image'] = this.cancelledChequeImage;
    data['upi'] = this.upi;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['goal'] = this.goal;
    data['occupations'] = this.occupations;
    data['relationship_status'] = this.relationshipStatus;
    data['privacy_status'] = this.privacyStatus;
    data['referal_code'] = this.referalCode;
    data['workout_experience'] = this.workoutExperience;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}