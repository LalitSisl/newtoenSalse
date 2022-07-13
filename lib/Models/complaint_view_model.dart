class ComplaintViewModel {
  var id;
  var date;
  var partyCode;
  var party;
  var empCode;
  var employee;
  var productCategory;
  var sALEPROJCODE;
  var sALEPROJCODE1;
  var complainntType;
  var remarks;

  ComplaintViewModel(
      {this.id,
        this.date,
        this.partyCode,
        this.party,
        this.empCode,
        this.employee,
        this.productCategory,
        this.sALEPROJCODE,
        this.sALEPROJCODE1,
        this.complainntType,
        this.remarks});

  ComplaintViewModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    date = json['Date'];
    partyCode = json['PartyCode'];
    party = json['Party'];
    empCode = json['EmpCode'];
    employee = json['Employee'];
    productCategory = json['Product_Category'];
    sALEPROJCODE = json['SALE_PROJ_CODE'];
    sALEPROJCODE1 = json['SALE_PROJ_CODE1'];
    complainntType = json['Complainnt_Type'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Date'] = this.date;
    data['PartyCode'] = this.partyCode;
    data['Party'] = this.party;
    data['EmpCode'] = this.empCode;
    data['Employee'] = this.employee;
    data['Product_Category'] = this.productCategory;
    data['SALE_PROJ_CODE'] = this.sALEPROJCODE;
    data['SALE_PROJ_CODE1'] = this.sALEPROJCODE1;
    data['Complainnt_Type'] = this.complainntType;
    data['Remarks'] = this.remarks;
    return data;
  }
}

