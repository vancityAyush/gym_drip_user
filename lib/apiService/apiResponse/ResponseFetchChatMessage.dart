class ResponseFetchChatMessage {
  int errorCode;
  String responseString;
  List<DataChat> data;

  ResponseFetchChatMessage({this.errorCode, this.responseString, this.data});

  ResponseFetchChatMessage.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    responseString = json['response_string'];
    if (json['data'] != null) {
      data = new List<DataChat>();
      json['data'].forEach((v) {
        data.add(new DataChat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_code'] = this.errorCode;
    data['response_string'] = this.responseString;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataChat {
  String id;
  String msgBy;
  String msgTo;
  String msg;
  String msgType;
  String msgDelivered;
  String msgSeen;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String isDisappearing;

  DataChat(
      {this.id,
        this.msgBy,
        this.msgTo,
        this.msg,
        this.msgType,
        this.msgDelivered,
        this.msgSeen,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.isDisappearing});

  DataChat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    msgBy = json['msg_by'];
    msgTo = json['msg_to'];
    msg = json['msg'];
    msgType = json['msg_type'];
    msgDelivered = json['msg_delivered'];
    msgSeen = json['msg_seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    isDisappearing = json['is_disappearing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['msg_by'] = this.msgBy;
    data['msg_to'] = this.msgTo;
    data['msg'] = this.msg;
    data['msg_type'] = this.msgType;
    data['msg_delivered'] = this.msgDelivered;
    data['msg_seen'] = this.msgSeen;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['is_disappearing'] = this.isDisappearing;
    return data;
  }
}
