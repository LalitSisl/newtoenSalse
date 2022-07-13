class StockCaptureCategoryModel {
  String? itemDescRc;
  String? iTEMITEMCODE;
  String? iTEMITEMNAME;
  var iTEMTRFRATE;
  var sTRMRP;
  var strCategory;
  var sTRSUBCATG;
  var sTRSUBDEPT;
  var sTRSUBCLASS;
  var sTRSUBSUBCATGCODE;

  StockCaptureCategoryModel(
      {this.itemDescRc,
        this.iTEMITEMCODE,
        this.iTEMITEMNAME,
        this.iTEMTRFRATE,
        this.sTRMRP,
        this.strCategory,
        this.sTRSUBCATG,
        this.sTRSUBDEPT,
        this.sTRSUBCLASS,
        this.sTRSUBSUBCATGCODE});

  StockCaptureCategoryModel.fromJson(Map<String, dynamic> json) {
    itemDescRc = json['item_desc_rc'];
    iTEMITEMCODE = json['ITEM_ITEM_CODE'];
    iTEMITEMNAME = json['ITEM_ITEM_NAME'];
    iTEMTRFRATE = json['ITEM_TRF_RATE'];
    sTRMRP = json['STR_MRP'];
    strCategory = json['Str_Category'];
    sTRSUBCATG = json['STR_SUB_CATG'];
    sTRSUBDEPT = json['STR_SUB_DEPT'];
    sTRSUBCLASS = json['STR_SUBCLASS'];
    sTRSUBSUBCATGCODE = json['STR_SUBSUBCATG_CODE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_desc_rc'] = this.itemDescRc;
    data['ITEM_ITEM_CODE'] = this.iTEMITEMCODE;
    data['ITEM_ITEM_NAME'] = this.iTEMITEMNAME;
    data['ITEM_TRF_RATE'] = this.iTEMTRFRATE;
    data['STR_MRP'] = this.sTRMRP;
    data['Str_Category'] = this.strCategory;
    data['STR_SUB_CATG'] = this.sTRSUBCATG;
    data['STR_SUB_DEPT'] = this.sTRSUBDEPT;
    data['STR_SUBCLASS'] = this.sTRSUBCLASS;
    data['STR_SUBSUBCATG_CODE'] = this.sTRSUBSUBCATGCODE;
    return data;
  }
}

