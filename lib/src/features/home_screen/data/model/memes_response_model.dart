class MemesResponseModel {
  MemesResponseModel({
    this.success,
    this.data,
  });

  MemesResponseModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  Data? data;

  MemesResponseModel copyWith({
    bool? success,
    Data? data,
  }) =>
      MemesResponseModel(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.memes,
  });

  Data.fromJson(dynamic json) {
    if (json['memes'] != null) {
      memes = [];
      json['memes'].forEach((v) {
        memes?.add(Memes.fromJson(v));
      });
    }
  }

  List<Memes>? memes;

  Data copyWith({
    List<Memes>? memes,
  }) =>
      Data(
        memes: memes ?? this.memes,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (memes != null) {
      map['memes'] = memes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Memes {
  Memes({
    this.id,
    this.name,
    this.url,
    this.width,
    this.height,
    this.boxCount,
    this.captions,
  });

  Memes.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    width = json['width'];
    height = json['height'];
    boxCount = json['box_count'];
    captions = json['captions'];
  }

  String? id;
  String? name;
  String? url;
  num? width;
  num? height;
  num? boxCount;
  num? captions;

  Memes copyWith({
    String? id,
    String? name,
    String? url,
    num? width,
    num? height,
    num? boxCount,
    num? captions,
  }) =>
      Memes(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
        width: width ?? this.width,
        height: height ?? this.height,
        boxCount: boxCount ?? this.boxCount,
        captions: captions ?? this.captions,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['url'] = url;
    map['width'] = width;
    map['height'] = height;
    map['box_count'] = boxCount;
    map['captions'] = captions;
    return map;
  }
}
