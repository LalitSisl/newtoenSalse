class ProductType {
  String? pRODTYPEDesc;
  String? pRODTYPE;
  String? pRODTYPEShrtName;

  ProductType({this.pRODTYPEDesc, this.pRODTYPE, this.pRODTYPEShrtName});

  ProductType.fromJson(Map<String, dynamic> json) {
    pRODTYPEDesc = json['PROD_TYPE_desc'];
    pRODTYPE = json['PROD_TYPE'];
    pRODTYPEShrtName = json['PROD_TYPE_shrt_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PROD_TYPE_desc'] = this.pRODTYPEDesc;
    data['PROD_TYPE'] = this.pRODTYPE;
    data['PROD_TYPE_shrt_name'] = this.pRODTYPEShrtName;
    return data;
  }
}