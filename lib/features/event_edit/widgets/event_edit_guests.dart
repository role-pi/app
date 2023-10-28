import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:role/shared/widgets/form/form_item_group_title.dart';
import 'package:role/shared/widgets/modal_popup.dart';

class EventEditGuests extends StatelessWidget {
  const EventEditGuests({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormItemGroupTitle(title: "5 CONVIDADOS"),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey6,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Expanded(
            child: Column(
              children: [
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Participante $index'),
                    );
                  },
                ),
                CupertinoButton(
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: CupertinoDynamicColor.resolve(
                            CupertinoColors.label, context),
                        size: 30,
                      ),
                      SizedBox(width: 12),
                      Text(
                        "adicionar participante",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CupertinoDynamicColor.resolve(
                              CupertinoColors.label, context),
                        ),
                      ),
                      SizedBox(width: 40),
                      Icon(
                        CupertinoIcons.bars,
                        color: CupertinoDynamicColor.resolve(
                            CupertinoColors.label, context),
                      ),
                    ],
                  ),
                  onPressed: () {
                    ModalPopup(
                      context: context,
                      title: "adicionar participante:",
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: CupertinoColors
                                      .extraLightBackgroundGray
                                      .withOpacity(0.8),
                                ),
                                child: Icon(
                                  CupertinoIcons.envelope,
                                  color: CupertinoDynamicColor.resolve(
                                      CupertinoColors.label, context),
                                ),
                              ),
                              Text(" Convidar por e-mail"),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: CupertinoColors
                                      .extraLightBackgroundGray
                                      .withOpacity(0.8),
                                ),
                                child: Icon(
                                  CupertinoIcons.qrcode,
                                  color: CupertinoDynamicColor.resolve(
                                      CupertinoColors.label, context),
                                ),
                              ),
                              Text("QR CODE"),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: CupertinoColors
                                      .extraLightBackgroundGray
                                      .withOpacity(0.8),
                                ),
                                child: Icon(
                                  CupertinoIcons.square_arrow_up,
                                  color: CupertinoDynamicColor.resolve(
                                      CupertinoColors.label, context),
                                ),
                              ),
                              Text("Encaminhar"),
                            ],
                          )
                        ],
                      ),
                    ).show();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
