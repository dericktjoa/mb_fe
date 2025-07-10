import 'package:mb_fe/games/model/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LevelSelector extends StatelessWidget {
  const LevelSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final List<String> levelGames = ['Easy', 'Medium', 'Hard'];

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            levelGames.map((level) {
              final isSelected = quizProvider.selectedValue == level;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ChoiceChip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: isSelected ? Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : const Color(0xFF60B28C) : Colors.black,
                      width: 2,
                    ),
                  ),
                  selectedColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade400
                      : Colors.green.shade100,
                  backgroundColor: Colors.white,
                  elevation: isSelected ? 4 : 0,
                  label: Text(
                    level,
                    style: TextStyle( 
                      color:
                          isSelected ? Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.green.shade800 : Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF333739)
                              : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (bool selected) {
                    if (isSelected){
                    quizProvider.setSelectedValue(null);
                    } else{
                      quizProvider.setSelectedValue(level);
                    }
                  },
                ),
              );
            }).toList(),
      ),
    );
  }
}
