abstract class JSONSerializable {
  Map<String, dynamic> toJson();

  factory JSONSerializable.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
