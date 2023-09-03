import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakti/domain/entities/info_entity.dart';

class ItemOutsidePoliceHelp extends StatelessWidget {
  final InfoEntity data;
  final int index;
  const ItemOutsidePoliceHelp(
      {required this.index, required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 0.25,
          color: Colors.black,
        ),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalDivider(
                width: 1,
                color: Colors.black,
              ),
              SizedBox(
                width: 24,
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(
                    '$index.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const VerticalDivider(
                color: Colors.black,
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SelectableText(
                    data.address ?? '',
                    contextMenuBuilder: (context, editableTextState) {
                      final List<ContextMenuButtonItem> buttonItems =
                          editableTextState.contextMenuButtonItems;
                      buttonItems
                          .removeWhere((ContextMenuButtonItem buttonItem) {
                        return buttonItem.type == ContextMenuButtonType.cut;
                      });
                      return AdaptiveTextSelectionToolbar.buttonItems(
                        anchors: editableTextState.contextMenuAnchors,
                        buttonItems: buttonItems,
                      );
                    },
                    style: GoogleFonts.roboto(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const VerticalDivider(
                color: Colors.black,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SelectableText(
                    data.contactNumbers ?? '',
                    contextMenuBuilder: (context, editableTextState) {
                      final List<ContextMenuButtonItem> buttonItems =
                          editableTextState.contextMenuButtonItems;
                      buttonItems
                          .removeWhere((ContextMenuButtonItem buttonItem) {
                        return buttonItem.type == ContextMenuButtonType.cut;
                      });
                      return AdaptiveTextSelectionToolbar.buttonItems(
                        anchors: editableTextState.contextMenuAnchors,
                        buttonItems: buttonItems,
                      );
                    },
                    style: GoogleFonts.roboto(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const VerticalDivider(
                width: 1,
                color: Colors.black,
              ),
            ],
          ),
        ),
        const Divider(
          height: 0.25,
          color: Colors.black,
        ),
      ],
    );
  }
}
