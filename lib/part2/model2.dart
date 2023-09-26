// To parse this JSON data, do
//
//     final imgdata = imgdataFromJson(jsonString);

import 'dart:convert';

Imgdata imgdataFromJson(String str) => Imgdata.fromJson(json.decode(str));

String imgdataToJson(Imgdata data) => json.encode(data.toJson());

class Imgdata {
    bool success;
    String message;
    List<Datum> data;

    Imgdata({
        required this.success,
        required this.message,
        required this.data,
    });

    factory Imgdata.fromJson(Map<String, dynamic> json) => Imgdata(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    String title;
    User user;
    List<Image> images;

    Datum({
        required this.id,
        required this.title,
        required this.user,
        required this.images,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        user: User.fromJson(json["user"]),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "user": user.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
    };
}

class Image {
    String id;
    String imagename;
    String url;

    Image({
        required this.id,
        required this.imagename,
        required this.url,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["_id"],
        imagename: json["imagename"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "imagename": imagename,
        "url": url,
    };
}

class User {
    String id;
    String name;
    String email;
    String img;

    User({
        required this.id,
        required this.name,
        required this.email,
        required this.img,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json[" id"],
        name: json["name"],
        email: json["email"],
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        " id": id,
        "name": name,
        "email": email,
        "img": img,
    };
}
