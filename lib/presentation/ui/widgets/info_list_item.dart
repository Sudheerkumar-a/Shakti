import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakti/domain/entities/info_entity.dart';
import 'package:shakti/presentation/ui/widgets/outside_police_help.dart';

class InfoListItem extends StatefulWidget {
  final InfoEntity data;
  final ValueNotifier<String> sateChangeNotifier;
  InfoListItem(
      {super.key, required this.data, required this.sateChangeNotifier});
  @override
  State<StatefulWidget> createState() => _InfoListItemSate();
}

class _InfoListItemSate extends State<InfoListItem> {
  bool isSelected = false;
  onSateChanged() {
    isSelected = widget.sateChangeNotifier.value == widget.data.id;
    setState(() {});
  }

  @override
  void initState() {
    widget.sateChangeNotifier.addListener(onSateChanged);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              if (isSelected) {
                widget.sateChangeNotifier.value = '';
                isSelected = false;
              } else {
                widget.sateChangeNotifier.value = widget.data.id;
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.data.title ?? '',
                    style: GoogleFonts.roboto(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(
                  isSelected
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_outlined,
                  color: Colors.black,
                )
              ],
            ),
          ),
          Visibility(
            visible: isSelected,
            child: ((widget.data.title ?? '').contains('Outside police help'))
                ? Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: const OutsidePoliceHelp())
                : Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.data.description ?? '',
                        style: GoogleFonts.roboto(
                          color: const Color.fromARGB(255, 112, 112, 112),
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
