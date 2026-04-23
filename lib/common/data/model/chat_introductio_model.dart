class ChatIntroductioModel {
  SealModel? seal;
  String? signum;
  String? nomen;
  String? clavisPublica;

  ChatIntroductioModel({this.seal, this.signum, this.nomen, this.clavisPublica});

  ChatIntroductioModel.fromJson(Map<String, dynamic> json) {
    seal = json['seal'] != null ?  SealModel.fromJson(json['seal']) : null;
    signum = json['signum'];
    nomen = json['nomen'];
    clavisPublica = json['clavis_publica'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (seal != null) {
      data['seal'] = seal!.toJson();
    }
    data['signum'] = signum;
    data['nomen'] = nomen;
    data['clavis_publica'] = clavisPublica;
    return data;
  }
}

class SealModel {
  double? indicatione;
  String? opus;
  int? unicus;
  List<String>? track;
  List<String>? destinario;

  SealModel({this.indicatione, this.opus, this.unicus, this.track, this.destinario});

  SealModel.fromJson(Map<String, dynamic> json) {
    indicatione = json['indicatione'];
    opus = json['opus'];
    unicus = json['unicus'];
    track = json['track'].cast<String>();
    destinario = json['destinario'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['indicatione'] = indicatione;
    data['opus'] = opus;
    data['unicus'] = unicus;
    data['track'] = track;
    data['destinario'] = destinario;
    return data;
  }
}