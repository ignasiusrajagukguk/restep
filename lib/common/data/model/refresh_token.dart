class RefreshToken {
  SealToken? seal;
  String? signumRenovatio;
  String? informationes;
  String? tempus;

  RefreshToken({this.seal, this.signumRenovatio, this.informationes, this.tempus});

  RefreshToken.fromJson(Map<String, dynamic> json) {
    seal =
        json['seal'] != null ? SealToken.fromJson(json['seal']) : null;
    signumRenovatio = json['signum_renovatio'];
    informationes = json['informationes'];
    tempus = json['tempus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (seal != null) {
      data['seal'] = seal!.toJson();
    }
    data['signum_renovatio'] = signumRenovatio;
    data['informationes'] = informationes;
    data['tempus'] = tempus;
    return data;
  }
}

class SealToken {
  double? indicatione;
  String? opus;
  String? unicus;

  SealToken({this.indicatione, this.opus});

  SealToken.fromJson(Map<String, dynamic> json) {
    indicatione = json['indicatione'];
    opus = json['opus'];
    unicus = (json['unicus']).toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['indicatione'] = indicatione;
    data['opus'] = opus;
    data['unicus'] = unicus;
    return data;
  }
}
