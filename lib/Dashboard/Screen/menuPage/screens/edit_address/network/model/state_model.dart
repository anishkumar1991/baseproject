class CountryState {
  String? country;
  int? geonameid;
  String? name;
  String? subcountry;

  CountryState({this.country, this.geonameid, this.name, this.subcountry});

  CountryState.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    geonameid = json['geonameid'];
    name = json['name'];
    subcountry = json['subcountry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['geonameid'] = geonameid;
    data['name'] = name;
    data['subcountry'] = subcountry;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CountryState && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
