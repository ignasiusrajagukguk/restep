import 'error_model.dart';

class MyProfileModel {
  int? httpStatusCode;
  String? statusMessage;
  Data? data;
  ErrorModel? error;

  MyProfileModel(
      {this.httpStatusCode, this.statusMessage, this.data, this.error});

  MyProfileModel.fromJson(Map<String, dynamic> json) {
    httpStatusCode = json['http_status_code'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'] != null ? ErrorModel.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['http_status_code'] = httpStatusCode;
    data['status_message'] = statusMessage;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (error != null) {
      data['error'] = error!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? imageLink;
  String? screenName;
  String? countryIso2;
  String? email;
  String? mobile;
  List<Teams>? teams;
  List<Clients>? clients;

  Data(
      {this.id,
      this.name,
      this.imageLink,
      this.screenName,
      this.countryIso2,
      this.email,
      this.mobile,
      this.teams,
      this.clients});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageLink = json['image_link'];
    screenName = json['screen_name'];
    countryIso2 = json['country_iso2'];
    email = json['email'];
    mobile = json['mobile'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(Teams.fromJson(v));
      });
    }
    if (json['clients'] != null) {
      clients = <Clients>[];
      json['clients'].forEach((v) {
        clients!.add(Clients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_link'] = imageLink;
    data['screen_name'] = screenName;
    data['country_iso2'] = countryIso2;
    data['email'] = email;
    data['mobile'] = mobile;
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    if (clients != null) {
      data['clients'] = clients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teams {
  String? rtmId;
  String? rtmTeamId;
  String? rtmMemberId;
  String? rtmRole;
  String? rtmTimestamp;
  String? rtmMemberIdCreate;
  String? rtmJobTitle;
  String? rtmClientId;

  Teams(
      {this.rtmId,
      this.rtmTeamId,
      this.rtmMemberId,
      this.rtmRole,
      this.rtmTimestamp,
      this.rtmMemberIdCreate,
      this.rtmJobTitle,
      this.rtmClientId});

  Teams.fromJson(Map<String, dynamic> json) {
    rtmId = json['rtm_id'].toString();
    rtmTeamId = json['rtm_team_id'].toString();
    rtmMemberId = json['rtm_member_id'].toString();
    rtmRole = json['rtm_role'];
    rtmTimestamp = json['rtm_timestamp'].toString();
    rtmMemberIdCreate = json['rtm_member_id_create'];
    rtmJobTitle = json['rtm_job_title'];
    rtmClientId = json['rtm_client_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rtm_id'] = rtmId;
    data['rtm_team_id'] = rtmTeamId;
    data['rtm_member_id'] = rtmMemberId;
    data['rtm_role'] = rtmRole;
    data['rtm_timestamp'] = rtmTimestamp;
    data['rtm_member_id_create'] = rtmMemberIdCreate;
    data['rtm_job_title'] = rtmJobTitle;
    data['rtm_client_id'] = rtmClientId;
    return data;
  }
}

class Clients {
  int? id;
  String? name;
  int? staffId;
  String? jobTitle;
  String? imageLink;

  Clients({this.id, this.name, this.staffId, this.jobTitle, this.imageLink});

  Clients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    staffId = json['staff_id'];
    jobTitle = json['job_title'];
    imageLink = json['image_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['staff_id'] = staffId;
    data['job_title'] = jobTitle;
    data['image_link'] = imageLink;
    return data;
  }
}
