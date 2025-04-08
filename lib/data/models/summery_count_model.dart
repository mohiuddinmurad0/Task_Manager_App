class StatusCountModel {
  String? status;
  List<Data>? data;

  StatusCountModel({this.status, this.data});

  StatusCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? statusId;
  int? count;

  Data({this.statusId, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    statusId = json['_id'];
    count = json['sum'];
  }
}
