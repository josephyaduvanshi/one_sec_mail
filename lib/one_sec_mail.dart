library one_sec_mail;

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'model/message_details.dart';
import 'model/message_model.dart';

class OneSecMail {
  final String _baseUrl = 'https://www.1secmail.com/api/v1/';

  Future<List<String>> generateRandomEmails({int count = 1}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?action=genRandomMailbox&count=$count'),
    );

    if (response.statusCode == 200) {
      List<dynamic> emails = jsonDecode(response.body);
      return emails.cast<String>();
    } else {
      throw const HttpException('Failed to generate random emails.');
    }
  }

  Future<List<String>> getDomainList() async {
    final response = await http.get(
      Uri.parse('$_baseUrl?action=getDomainList'),
    );

    if (response.statusCode == 200) {
      List<dynamic> domains = jsonDecode(response.body);
      return domains.cast<String>();
    } else {
      throw const HttpException('Failed to retrieve domain list.');
    }
  }

  Future<List<Message>> getMessages({
    required String login,
    required String domain,
  }) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?action=getMessages&login=$login&domain=$domain'),
    );

    if (response.statusCode == 200) {
      List<dynamic> messagesJson = jsonDecode(response.body);
      return messagesJson.map((json) => Message.fromJson(json)).toList();
    } else {
      throw const HttpException('Failed to retrieve messages.');
    }
  }

  Future<MessageDetails> readMessage({
    required String login,
    required String domain,
    required int id,
  }) async {
    final response = await http.get(
      Uri.parse(
          '$_baseUrl?action=readMessage&login=$login&domain=$domain&id=$id'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> messageJson = jsonDecode(response.body);
      return MessageDetails.fromJson(messageJson);
    } else {
      throw const HttpException('Failed to read message.');
    }
  }

  Future<void> downloadAttachment({
    required String login,
    required String domain,
    required int id,
    required String filename,
    required String savePath,
  }) async {
    final response = await http.get(
      Uri.parse(
          '$_baseUrl?action=download&login=$login&domain=$domain&id=$id&file=$filename'),
    );

    if (response.statusCode == 200) {
      final file = File('$savePath/$filename');
      await file.writeAsBytes(response.bodyBytes);
    } else {
      throw const HttpException('Failed to download attachment.');
    }
  }
}



