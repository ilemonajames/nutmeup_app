class References {
  String authorization_url;
  String access_code;
  String reference;

  References(
      {required String this.authorization_url,
      required String this.access_code,
      required String this.reference});

  References.fromJson(Map json)
      : authorization_url = json['authorization_url'],
        access_code = json['access_code'],
        reference = json['reference'];

  Map toJson() {
    return {
      'authorization_url': authorization_url,
      'access_code': access_code,
      'reference': reference
    };
  }
}
