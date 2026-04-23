class JwkModel {
  String? kty;
  String? alg;
  String? use;
  String? n;
  String? e;

  JwkModel({this.kty, this.alg, this.use, this.n, this.e});

  JwkModel.fromJson(Map<String, dynamic> json) {
    kty = json['kty'];
    alg = json['alg'];
    use = json['use'];
    n = json['n'];
    e = json['e'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kty'] = kty;
    data['alg'] = alg;
    data['use'] = use;
    data['n'] = n;
    data['e'] = e;
    return data;
  }
}
