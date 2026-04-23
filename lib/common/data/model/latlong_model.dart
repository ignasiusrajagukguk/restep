class LatLongModel {
  double? lat;
  double? long;

  LatLongModel({this.lat, this.long,});

  LatLongModel.fromJson(Map<String, dynamic> json) {
    lat = json['latitude'] ?? '';
    long = json['longitude'] ?? '';
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['latitude'] = lat;
    map['longitude'] = long;
    return map;
  }
}
