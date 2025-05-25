import '../api/decodable.dart';
import 'package:flutter/material.dart';

class YesOrNoModel extends Decodable {
  String? answer;
  bool? forced;
  String? image;

  YesOrNoModel({this.answer, this.forced, this.image}) {
    debugPrint("YESORNOMODEL CONSTRUCTOR CALLED");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer'] = answer;
    data['forced'] = forced;
    data['image'] = image;
    return data;
  }

  @override
  decode(data) {
    answer = data['answer'];
    forced = data['forced'];
    image = data['image'];
    return this;
  }

  Map<String, dynamic> get encode => {
        'answer': answer,
        'forced': forced,
        'image': image,
      };
}
