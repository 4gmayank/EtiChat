class CountryEntity {
  CountryEntity({
      this.name, 
      this.cca2, 
      this.ccn3, 
      this.cca3, 
      this.cioc, 
      this.capital, 
      this.region, 
      this.subregion, 
      this.flag, 
      this.continents, 
      this.flags, 
      this.coatOfArms, 
      this.postalCode,});

  CountryEntity.fromJson(dynamic json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    cca2 = json['cca2'];
    ccn3 = json['ccn3'];
    cca3 = json['cca3'];
    cioc = json['cioc'];
    capital = json['capital'] != null ? json['capital'].cast<String>() : [];
    region = json['region'];
    subregion = json['subregion'];
    flag = json['flag'];
    continents = json['continents'] != null ? json['continents'].cast<String>() : [];
    flags = json['flags'] != null ? Flags.fromJson(json['flags']) : null;
    coatOfArms = json['coatOfArms'] != null ? CoatOfArms.fromJson(json['coatOfArms']) : null;
    postalCode = json['postalCode'] != null ? PostalCode.fromJson(json['postalCode']) : null;
  }
  Name? name;
  String? cca2;
  String? ccn3;
  String? cca3;
  String? cioc;
  List<String>? capital;
  String? region;
  String? subregion;
  String? flag;
  List<String>? continents;
  Flags? flags;
  CoatOfArms? coatOfArms;
  PostalCode? postalCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (name != null) {
      map['name'] = name?.toJson();
    }
    map['cca2'] = cca2;
    map['ccn3'] = ccn3;
    map['cca3'] = cca3;
    map['cioc'] = cioc;
    map['capital'] = capital;
    map['region'] = region;
    map['subregion'] = subregion;
    map['flag'] = flag;
    map['continents'] = continents;
    if (flags != null) {
      map['flags'] = flags?.toJson();
    }
    if (coatOfArms != null) {
      map['coatOfArms'] = coatOfArms?.toJson();
    }
    if (postalCode != null) {
      map['postalCode'] = postalCode?.toJson();
    }
    return map;
  }

}

class PostalCode {
  PostalCode({
      this.format, 
      this.regex,});

  PostalCode.fromJson(dynamic json) {
    format = json['format'];
    regex = json['regex'];
  }
  String? format;
  String? regex;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['format'] = format;
    map['regex'] = regex;
    return map;
  }

}

class CoatOfArms {
  CoatOfArms({
      this.png, 
      this.svg,});

  CoatOfArms.fromJson(dynamic json) {
    png = json['png'];
    svg = json['svg'];
  }
  String? png;
  String? svg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['png'] = png;
    map['svg'] = svg;
    return map;
  }

}

class Flags {
  Flags({
      this.png, 
      this.svg, 
      this.alt,});

  Flags.fromJson(dynamic json) {
    png = json['png'];
    svg = json['svg'];
    alt = json['alt'];
  }
  String? png;
  String? svg;
  String? alt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['png'] = png;
    map['svg'] = svg;
    map['alt'] = alt;
    return map;
  }

}

class Name {
  Name({
      this.common, 
      this.official,});

  Name.fromJson(dynamic json) {
    common = json['common'];
    official = json['official'];
  }
  String? common;
  String? official;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['common'] = common;
    map['official'] = official;
    return map;
  }

}