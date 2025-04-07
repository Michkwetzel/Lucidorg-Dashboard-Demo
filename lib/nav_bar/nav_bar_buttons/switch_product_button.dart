import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/enums.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class SwitchProductButton extends ConsumerWidget {
  const SwitchProductButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 20,
      child: PopupMenuButton<Product>(
        icon: Icon(
          color: Colors.black,
          Icons.arrow_drop_down,
          size: 20,
        ),
        padding: EdgeInsets.zero,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          side: WidgetStateProperty.all(BorderSide(color: Colors.grey, width: 0.5)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
        ),
        offset: Offset(25, 0),
        color: Colors.white,
        elevation: 0,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Product>>[
          PopupMenuItem<Product>(
            value: Product.org,
            onTap: () {
              ref.read(navBarProvider.notifier).changeProduct(Product.org);
            },
            child: Text('ORG'),
          ),
          PopupMenuItem<Product>(
            value: Product.hr,
            onTap: () {
              ref.read(navBarProvider.notifier).changeProduct(Product.hr);
            },
            child: Text('HR'),
          ),
          PopupMenuItem<Product>(
            value: Product.board,
            onTap: () {},
            child: Text('BOARD'),
          ),
        ],
      ),
    );
  }
}
