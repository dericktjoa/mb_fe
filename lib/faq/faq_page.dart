import 'package:mb_fe/faq/data/faq_data.dart';
import 'package:mb_fe/faq/model/faq.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mb_fe/appbar/custom_appbar.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  late final List<FaqItem> _faqItems;

  @override
  void initState() {
    super.initState();
    _faqItems = faqData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'FAQ', showMenu: false,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: ExpansionPanelList(
            animationDuration: const Duration(milliseconds: 500),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _faqItems[index].isExpanded = isExpanded;
              });
            },
            elevation: 1,
            children: _faqItems.map<ExpansionPanel>((FaqItem item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      item.question,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: isExpanded ? Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey
                            : const Color(0xFF60B28C) : Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  );
                },
                body: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0), 
                    child: Text(
                      item.answer,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                isExpanded: item.isExpanded,
                canTapOnHeader: true, 
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}