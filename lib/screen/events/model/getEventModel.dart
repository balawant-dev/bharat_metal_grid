class GetAllEventModel {
  bool? success;
  int? totalResult;
  int? totalPage;
  List<EventsData>? data;

  GetAllEventModel({this.success, this.totalResult, this.totalPage, this.data});

  GetAllEventModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalResult = json['totalResult'];
    totalPage = json['totalPage'];
    if (json['data'] != null) {
      data = <EventsData>[];
      json['data'].forEach((v) {
        data!.add(new EventsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['totalResult'] = this.totalResult;
    data['totalPage'] = this.totalPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventsData {
  String? sId;
  String? title;
  List<String>? images;
  String? description;
  String? date;
  String? startTime;
  String? endTime;
  String? createdAt;
  int? iV;

  EventsData(
      {this.sId,
        this.title,
        this.images,
        this.description,
        this.date,
        this.startTime,
        this.endTime,
        this.createdAt,
        this.iV});

  EventsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    images = json['images'].cast<String>();
    description = json['description'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['images'] = this.images;
    data['description'] = this.description;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
