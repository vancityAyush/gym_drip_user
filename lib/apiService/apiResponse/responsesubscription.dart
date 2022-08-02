class ResponseSubscription {
  int errorCode;
  String reponseString;
  Data data;

  ResponseSubscription({this.errorCode, this.reponseString, this.data});

  ResponseSubscription.fromJson(Map<String, dynamic> json) {
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
  String userId;
  String trainerId;
  String isSubscribed;
  String showTrainerData;
  String subscriptionStartDate;
  String subscriptionEndDate;
  String packageId;
  String packageAmount;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Data(
      {this.id,
        this.userId,
        this.trainerId,
        this.isSubscribed,
        this.showTrainerData,
        this.subscriptionStartDate,
        this.subscriptionEndDate,
        this.packageId,
        this.packageAmount,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    trainerId = json['trainer_id'];
    isSubscribed = json['is_subscribed'];
    showTrainerData = json['show_trainer_data'];
    subscriptionStartDate = json['subscription_start_date'];
    subscriptionEndDate = json['subscription_end_date'];
    packageId = json['package_id'];
    packageAmount = json['package_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['trainer_id'] = this.trainerId;
    data['is_subscribed'] = this.isSubscribed;
    data['show_trainer_data'] = this.showTrainerData;
    data['subscription_start_date'] = this.subscriptionStartDate;
    data['subscription_end_date'] = this.subscriptionEndDate;
    data['package_id'] = this.packageId;
    data['package_amount'] = this.packageAmount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
