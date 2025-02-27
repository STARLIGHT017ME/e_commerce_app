import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'C a r t',
              style: TextStyle(color: Colors.black, fontSize: 27),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Placeholder(
                    fallbackHeight: 100,
                    fallbackWidth: 100,
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Item 1'),
                      subtitle: const Text('Price: 100'),
                      trailing: IconButton(
                        icon: const FaIcon(
                          FontAwesomeIcons.trash,
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text("Total: \$500"),
              const Spacer(),
              TextButton(
                  onPressed: () => {},
                  child: const Text(
                    "Checkout",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ))
            ],
          ),
        ));
  }
}
