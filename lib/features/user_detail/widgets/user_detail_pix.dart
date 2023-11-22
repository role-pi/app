import 'package:flutter/cupertino.dart';
import 'package:role/features/user_detail/widgets/user_detail_info.dart';
import 'package:role/shared/widgets/modal_popup.dart';

class NewPixKeyScreen extends StatelessWidget{
  NewPixKeyScreen(UserDetailInfo userDetailInfo){
  }

  void show(BuildContext context) {
    ModalPopup(
            context: context, title: "adicionar chave pix", child: build(context))
        .show();
  }
  
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
   
  }
}