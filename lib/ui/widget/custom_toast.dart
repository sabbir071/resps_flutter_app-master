import 'package:flutter/material.dart';

successToast(
    {required BuildContext context, required String msg, String? title}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 6.0,
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    content: Row(
      children: [
        const Icon(
          Icons.done,
          size: 50,
          color: Colors.white,
        ),
        const SizedBox(width: 16),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? "Success",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                msg,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    ),
  ));
}

errorToast({required BuildContext context,required String msg}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 6.0,
    backgroundColor: Colors.red[400],
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    content: Row(
      children: [
        const Icon(
          Icons.error,
          size: 50,
          color: Colors.white,
        ),
        const SizedBox(width: 16),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Error",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                msg,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    ),
  ));
}

showLoaderDialog(BuildContext context, String message){
  AlertDialog alert=AlertDialog(
    content:  Row(
      children: [
       const CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7),child:Text('$message...')),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}