import 'package:food_app/data/repository/order_repository.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/models/place_order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepository orderRepository;
  OrderController({required this.orderRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late List<OrderModel> _currentOrderList;
  late List<OrderModel> _historyOrderList;

  List<OrderModel> get currentOrderList => _currentOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;

  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;

  String _orderType = 'delivery';
  String get orderType => _orderType;

  String _orderNote = '';
  String get orderNote => _orderNote;

  Future<void> placeOrder(
      PlaceOrderBody placeOrderBody, Function callBack) async {
    _isLoading = true;
    Response response = await orderRepository.placeOrder(placeOrderBody);
    if (response.statusCode == 200) {
      _isLoading = false;
      String message = response.body['message'];
      String orderId = response.body['order_id'].toString();
      callBack(true, message, orderId);
    } else {
      callBack(true, response.statusText, '-1');
    }
  }

  Future<void> getOrderList() async {
    _isLoading = true;
    Response response = await orderRepository.getOrderList();
    _historyOrderList = [];
    _currentOrderList = [];
    if (response.statusCode == 200) {
      response.body.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus == 'pending' ||
            orderModel.orderStatus == 'accepted' ||
            orderModel.orderStatus == 'processing' ||
            orderModel.orderStatus == 'handover' ||
            orderModel.orderStatus == 'picked_up') {
          _currentOrderList.add(orderModel);
        } else {
          _historyOrderList.add(orderModel);
        }
      });
    }
    _isLoading = false;
    update();
  }

  void setPaymentIndex(int index) {
    _paymentIndex = index;
    update();
  }

  void setDeliveryType(String orderType) {
    _orderType = orderType;
    update();
  }

  void setOrderNote(String orderNote) {
    _orderNote = orderNote;
  }
}
