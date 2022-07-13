class EventDetailModel {
  String? id;
  String? name;
  String? phone;
  String? date;
  String? dOB;
  String? address;

  EventDetailModel(
      {this.id, this.name, this.phone, this.date, this.dOB, this.address});

  EventDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    phone = json['Phone'];
    date = json['Date'];
    dOB = json['DOB'];
    address = json['Address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Phone'] = this.phone;
    data['Date'] = this.date;
    data['DOB'] = this.dOB;
    data['Address'] = this.address;
    return data;
  }
}

