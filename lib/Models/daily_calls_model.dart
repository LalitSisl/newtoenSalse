class DailyCallsModel {
  String? date;
  String? saleExecutive;
  String? area;
  String? subArea;
  String? callsMade;
  String? executiveCalls;
  String? category;
  String? qty;
  String? amount;

  DailyCallsModel(
      {this.date,
        this.saleExecutive,
        this.area,
        this.subArea,
        this.callsMade,
        this.executiveCalls,
        this.category,
        this.qty,
        this.amount});

  DailyCallsModel.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    saleExecutive = json['SaleExecutive'];
    area = json['Area'];
    subArea = json['SubArea'];
    callsMade = json['Calls_Made'];
    executiveCalls = json['Executive_Calls'];
    category = json['Category'];
    qty = json['Qty'];
    amount = json['Amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['SaleExecutive'] = this.saleExecutive;
    data['Area'] = this.area;
    data['SubArea'] = this.subArea;
    data['Calls_Made'] = this.callsMade;
    data['Executive_Calls'] = this.executiveCalls;
    data['Category'] = this.category;
    data['Qty'] = this.qty;
    data['Amount'] = this.amount;
    return data;
  }
}

