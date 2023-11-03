import 'package:get/get.dart';
import 'package:job_app/controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthcController>(AuthcController());
    // Get.put<GuardsandMemberController>(GuardsandMemberController());
    //Get.put<IncidentCallController>(IncidentCallController());
  }
}
