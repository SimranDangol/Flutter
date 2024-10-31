import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DropDownItems extends StatefulWidget {


  @override
  State<DropDownItems> createState() => _DropDownItemsState();
}


class _DropDownItemsState extends State<DropDownItems> {
  late int _selectedNums = 0;
  
  List<int> nums = [0,1,2,3,4,5,6,7,8,9]; // Providing answer options in list

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SizedBox(
          height: 60,
          width: 80,
          child: DropdownButtonFormField<int>(
             icon: const Icon(Icons.arrow_downward),
           iconSize: 24,
           elevation: 16,
           isExpanded: true,
             style: const TextStyle(color: Color(0xFFE63A00), fontSize: 20),
            
           decoration: InputDecoration(
             enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 3, color: Color(0xFFE63A00))
             )
           ),
             items: nums.map((int dropDownValue) {
               return DropdownMenuItem<int>(
                 value: dropDownValue,
                 
                 child: Text(dropDownValue.toString())
               );
             }).toList(),
             onChanged: (newVal) {
               setState(() {
                 _selectedNums = newVal!;
                 if (kDebugMode) {
                   print(_selectedNums);
                 }
               }
               
               );
             },
             value: _selectedNums,
            // itemHeight: 1,
             
             ),
        ),
      ),
    );
  }
}