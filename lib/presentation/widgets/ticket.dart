import '../../domain/entities/transaction.dart';
import '../misc/constant.dart';
import '../misc/methods.dart';
import 'network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Ticket extends StatelessWidget {
  final Transaction transaction;
  const Ticket({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: containerTextField, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: grey800,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Text(
              transaction.id.toString(),
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: NetworkImageCard(
                  width: 75,
                  height: 114,
                  fit: BoxFit.cover,
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500/${transaction.transactionImage}',
                ),
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    verticalSpace(10),
                    Text(
                      transaction.theaterName.toString(),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat('EEEE, d MMMM y | HH:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              transaction.watchingTime!)),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    verticalSpace(10),
                    Text(
                      '${transaction.ticketAmount} Tickets (${transaction.seats.join(', ')})',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
