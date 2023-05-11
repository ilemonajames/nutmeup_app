import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:nutmeup/constants/Colors.dart';


class CustomButton extends StatefulWidget {
  CustomButton({Key? key , required  this.onClick , required this.text , this.margin   ,  this.loading }  ) : super(key: key);
  Function onClick;
  String text;
  var loading;
  var margin;
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {




  @override
  Widget build(BuildContext context) {


    bool _isLoading = widget.loading ?? false;
    return GestureDetector(
    
      onTap: () => !_isLoading ?widget.onClick() : (){
        
      },
      child: Container(
      height: 50,
      margin: widget.margin?? null,
      decoration: BoxDecoration(
        color: colorBlue ,
        borderRadius: const BorderRadius.all(Radius.circular(5))
      ),
      alignment: Alignment.center,
      padding:  const EdgeInsets.all(10),
      child: _isLoading? SizedBox(width: 20 , height: 20, child: CircularProgressIndicator( color: colorWhite , strokeWidth: 2,),) : Text(widget.text , style: TextStyle(fontSize: 16 , color: colorWhite),),
    ),
    );
  }
}