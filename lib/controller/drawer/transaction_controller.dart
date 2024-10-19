import 'package:get/get.dart';

import '../../backend/model/transaction_log/transaction_log_model.dart';
import '../../backend/services/api_services.dart';

class TransactionController extends GetxController {
  @override
  void onInit() {
    getTransactionData();
    super.onInit();
  }

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  late TransactionLogModel _transactionLogModel;

  TransactionLogModel get transactionModel => _transactionLogModel;

  Future<TransactionLogModel> getTransactionData() async {
    _isLoading.value = true;
    update();

    // calling  from api service
    await ApiServices.getTransactionLogAPi().then((value) {
      _transactionLogModel = value!;

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    update();
    return _transactionLogModel;
  }
}
