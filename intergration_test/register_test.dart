import 'package:bloc_test/bloc_test.dart';
import 'package:fashora_app/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:fashora_app/features/auth/presentation/view_model/register_view_model/register_state.dart';
import 'package:fashora_app/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:integration_test/integration_test.dart';

class MogckRegisteBloc extends MockBloc<RegisterEvent, RegisterState>
implements RegisterViewModel{}

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MogckRegisteBloc registeBloc;

}

// class MockRegisteBloc extends MockBloc<RegisterEvent, RegisterState>
// implements RegisterViewModel {}




// void main(){
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   late MockRegisteBloc registeBloc;
// }