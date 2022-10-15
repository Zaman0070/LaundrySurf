class OrderModel {
  String? orderName;
  String? orderUrl;
  int? orderPrice;
  String? orderId;
  int? orderQuantity;
  String? pickupDate;
  String? pickTime;
  String? deliverDate;
  String? deliverTime;
  String? orderFor;
  String? payment;
  String? orderStatus;


  OrderModel(
      {this.orderName,
      this.orderId,
      this.orderPrice,
      this.orderQuantity,
      this.orderUrl,
      this.pickupDate,
      this.pickTime,
      this.deliverDate,
      this.deliverTime,
        this.orderFor,
        this.payment,
        this.orderStatus
      });
}
