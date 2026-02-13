class ChatModel {
  ChatModel({
      List<Parts>? parts, 
      String? role,}){
    _parts = parts;
    _role = role;
}

  ChatModel.fromJson(dynamic json) {
    if (json['parts'] != null) {
      _parts = [];
      json['parts'].forEach((v) {
        _parts?.add(Parts.fromJson(v));
      });
    }
    _role = json['role'];
  }
  List<Parts>? _parts;
  String? _role;
ChatModel copyWith({  List<Parts>? parts,
  String? role,
}) => ChatModel(  parts: parts ?? _parts,
  role: role ?? _role,
);
  List<Parts>? get parts => _parts;
  String? get role => _role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_parts != null) {
      map['parts'] = _parts?.map((v) => v.toJson()).toList();
    }
    map['role'] = _role;
    return map;
  }

}

class Parts {
  Parts({
      String? text, 
      String? thoughtSignature,}){
    _text = text;
    _thoughtSignature = thoughtSignature;
}

  Parts.fromJson(dynamic json) {
    _text = json['text'];
    _thoughtSignature = json['thoughtSignature'];
  }
  String? _text;
  String? _thoughtSignature;
Parts copyWith({  String? text,
  String? thoughtSignature,
}) => Parts(  text: text ?? _text,
  thoughtSignature: thoughtSignature ?? _thoughtSignature,
);
  String? get text => _text;
  String? get thoughtSignature => _thoughtSignature;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['thoughtSignature'] = _thoughtSignature;
    return map;
  }

}