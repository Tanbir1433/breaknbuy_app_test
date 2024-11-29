class OrderItemRequest {
  final int productId;
  final int variantId;
  final int quantity;

  OrderItemRequest({
    required this.productId,
    required this.variantId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'variant_id': variantId,
      'quantity': quantity,
    };
  }
}



class CreateOrderRequest {
  final int userId;
  final List<OrderItemRequest> items;
  final String paymentGatewayName;
  final String paymentStatus;
  final String? description;

  CreateOrderRequest({
    required this.userId,
    required this.items,
    required this.paymentGatewayName,
    required this.paymentStatus,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'payment_gateway_name': paymentGatewayName,
      'payment_status': paymentStatus,
      'Description': description,
    };
  }
}



class OrderResponse {
  final String message;
  final int orderId;

  OrderResponse({
    required this.message,
    required this.orderId,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      message: json['message'],
      orderId: json['order_id'],
    );
  }
}
