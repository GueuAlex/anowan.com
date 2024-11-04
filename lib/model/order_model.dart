// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> listOrderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String listOrderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
// single

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  final int id;
  final int eventId;
  final String uniqueCode;
  final String amount;
  final bool status;
  final int orderableId;
  /* final String orderableType; */

  final String? fees;
  final String? smsFees;
  final String? amountAvailable;
  final String? packLevy;
  final String? amountHt;
  final String? comments;
  final int? smsQuantity;

  OrderModel({
    required this.id,
    required this.eventId,
    required this.uniqueCode,
    required this.amount,
    required this.status,
    required this.orderableId,
    /* required this.orderableType, */
    required this.fees,
    required this.smsFees,
    required this.amountAvailable,
    required this.packLevy,
    required this.amountHt,
    required this.comments,
    required this.smsQuantity,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        eventId: json["event_id"],
        uniqueCode: json["unique_code"],
        amount: json["amount"],
        status: json["status"] == 0 ? false : true,
        orderableId: json["orderable_id"],
        /* orderableType: json["orderable_type"], */
        fees: json["fees"],
        smsFees: json["sms_fees"],
        amountAvailable: json["amount_available"],
        packLevy: json["pack_levy"],
        amountHt: json["amount_ht"],
        comments: json["comments"],
        smsQuantity: json["sms_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_id": eventId,
        "unique_code": uniqueCode,
        "amount": amount,
        "status": status,
        "orderable_id": orderableId,
        /* "orderable_type": orderableType, */
        "fees": fees,
        "sms_fees": smsFees,
        "amount_available": amountAvailable,
        "pack_levy": packLevy,
        "amount_ht": amountHt,
        "comments": comments,
        "sms_quantity": smsQuantity,
      };
}
