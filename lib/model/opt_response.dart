// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

OtpResponse optResponseFromJson(String str) =>
    OtpResponse.fromJson(json.decode(str));

String optResponseToJson(OtpResponse data) => json.encode(data.toJson());

class OtpResponse {
  String code;
  Meta meta;

  OtpResponse({
    required this.code,
    required this.meta,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
        code: json["code"],
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "meta": meta.toJson(),
      };
}

class Meta {
  String method;
  String bit;
  String mode;
  String secretKey;

  Meta({
    required this.method,
    required this.bit,
    required this.mode,
    required this.secretKey,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        method: json["method"],
        bit: json["bit"],
        mode: json["mode"],
        secretKey: json["secretKey"],
      );

  Map<String, dynamic> toJson() => {
        "method": method,
        "bit": bit,
        "mode": mode,
        "secretKey": secretKey,
      };
}
