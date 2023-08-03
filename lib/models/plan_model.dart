import '../entity/plan_entity.dart';
import '../service/plan_service.dart';
import 'base_model.dart';

class PlanModel extends BaseModel {
  final PlanService _planService = PlanService();

  List<PlanEntity> _planEntityList = [];

  List<PlanEntity> get planEntityList => _planEntityList;

  // 获取套餐列表
  void fetchPlanList() async {
    _planEntityList = (await _planService.plan())!;

    notifyListeners();
  }
}
