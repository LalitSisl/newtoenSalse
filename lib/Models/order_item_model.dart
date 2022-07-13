class OrderItemModel {
  String? sYSCDSCODEVALUE;
  String? sYSCDSCODEDESC;

  OrderItemModel({this.sYSCDSCODEVALUE, this.sYSCDSCODEDESC});

  OrderItemModel.fromJson(Map<String, dynamic> json) {
    sYSCDSCODEVALUE = json['SYSCDS_CODE_VALUE'];
    sYSCDSCODEDESC = json['SYSCDS_CODE_DESC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SYSCDS_CODE_VALUE'] = this.sYSCDSCODEVALUE;
    data['SYSCDS_CODE_DESC'] = this.sYSCDSCODEDESC;
    return data;
  }
}

