class EventTypeModel {
  String? value;
  String? name;

  EventTypeModel({this.value, this.name});

  EventTypeModel.fromJson(Map<String, dynamic> json) {
    value = json['Value'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Value'] = this.value;
    data['Name'] = this.name;
    return data;
  }
}