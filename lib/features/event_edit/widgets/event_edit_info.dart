import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_detail/widgets/event_detail_map.dart';
import 'package:role/features/event_edit/providers/event_edit_provider.dart';
import 'package:role/shared/widgets/form/form_item_date_picker.dart';
import 'package:role/shared/widgets/form/form_item_group_title.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';

class EventEditInfo extends StatelessWidget {
  const EventEditInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    EventEditProvider provider = Provider.of<EventEditProvider>(context);

    return Column(
      children: [
        FormItemGroupTitle(title: "INFORMAÇÕES"),
        FormItemTextField(
          controller: provider.nameController,
          title: provider.event.name,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'O nome não pode ser vazio.';
            }
            return null;
          },
        ),
        SizedBox(height: 12),
        Row(children: [
          FormItemDatePicker(
            title: "data de início",
            initialValue: provider.event.startDate,
            onSaved: (date) => provider.startDate = date,
          ),
          SizedBox(width: 6),
          Icon(CupertinoIcons.arrow_right,
              size: 30,
              color: CupertinoColors.systemGrey3.resolveFrom(context)),
          SizedBox(width: 6),
          FormItemDatePicker(
            title: "data de fim",
            initialValue: provider.event.endDate,
            onSaved: (date) => provider.endDate = date,
          ),
        ]),
        SizedBox(height: 12),
        SizedBox(
            height: 250,
            child: EventDetailMap(
                color: provider.event.color1,
                location: provider.event.location)),
      ],
    );
  }
}
