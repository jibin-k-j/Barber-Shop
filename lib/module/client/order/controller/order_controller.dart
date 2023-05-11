import 'package:barber_app/core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderController extends GetxController {
  OrderView? view;
  int selectedFilterIndex = 0;

  get filterStatus {
    if (selectedFilterIndex == 0) {
      return "Pending";
    } else if (selectedFilterIndex == 1) {
      return "Approved";
    } else if (selectedFilterIndex == 2) {
      return "Rejected";
    } else if (selectedFilterIndex == 3) {
      return "Failed";
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  updateFilter(index) async {
    selectedFilterIndex = index;
    update();
  }

  doApprove(Map item) async {
    showLoading();
    await FirebaseFirestore.instance
        .collection(collection.bookingCollection)
        .doc(item["id"])
        .update({
      "status": "Approved",
    });
    hideLoading();
  }

  doReject(Map item) async {
    showLoading();
    await FirebaseFirestore.instance
        .collection(collection.bookingCollection)
        .doc(item["id"])
        .update({
      "status": "Rejected",
    });
    hideLoading();
  }

  doCall(dynamic item) async {
    var snapshot = await FirebaseFirestore.instance
        .collection(collection.vendorCollection)
        .doc(item["vendor_id"])
        .get();

    var d = snapshot.data() ?? {};
    var phone = d["phone"];
    if (phone == null || phone.toString().length < 4) {
      Get.snackbar("No Phone Number", "No Phone Number Provided");
      return;
    }
    await launchURL("tel:$phone");
  }
}
