<p align="center">
  <a href="https://github.com/josephyaduvanshi" target="_blank">
    <img src="https://i.imgur.com/OQ4VMmS.png"  width="1200" alt="OneSecMail">
  </a>
</p>

[![RandomX](https://img.shields.io/badge/one_sec_mail-firm-orange)](https://github.com/josephyaduvanshi/one_sec_mail)
[![Pub release](https://img.shields.io/pub/v/one_sec_mail.svg?style=flat-square)](https://pub.dev/packages/one_sec_mail)
[![GitHub Release Date](https://img.shields.io/github/release-date/josephyaduvanshi/one_sec_mail.svg?style=flat-square)](https://github.com/josephyaduvanshi/one_sec_mail)
[![GitHub issues](https://img.shields.io/github/issues/josephyaduvanshi/one_sec_mail.svg?style=flat-square)](https://github.com/josephyaduvanshi/one_sec_mail/issues)
[![GitHub top language](https://img.shields.io/github/languages/top/josephyaduvanshi/one_sec_mail.svg?style=flat-square)](https://github.com/josephyaduvanshi/one_sec_mail)
[![Likes](https://badges.bar/one_sec_mail/likes)](https://pub.dev/packages/one_sec_mail/score)
[![Popularity](https://badges.bar/one_sec_mail/popularity)](https://pub.dev/packages/one_sec_mail/score)
[![GitHub license](https://img.shields.io/badge/license-APACHE-blue.svg?style=flat)](https://github.com/josephyaduvanshi/one_sec_mail/blob/main/LICENSE)
[![support](https://img.shields.io/badge/platform-flutter%7Cflutter%20web%7Cdart%20vm-ff69b4.svg?style=flat-square)](https://github.com/josephyaduvanshi/one_sec_mail)

### Show some :heart: and star the repo :star: :star:.

[![GitHub followers](https://img.shields.io/github/followers/josephyaduvanshi.svg?style=social&label=Follow)](https://github.com/josephyaduvanshi/)
[![Twitter Follow](https://img.shields.io/twitter/follow/Josefyaduvanshi.svg?style=social)](https://twitter.com/Josefyaduvanshi)

[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://opensource.org/licenses/Apache-2.0)

---

# OneSecMail Dart Package

A Dart package that provides a convenient wrapper around the [1secmail.com](https://www.1secmail.com/api/) API. This package allows you to generate temporary email addresses, check mailboxes, read messages, and download attachments effortlessly.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [Import the Package](#import-the-package)
  - [Generating Random Email Addresses](#generating-random-email-addresses)
  - [Retrieving Active Domains](#retrieving-active-domains)
  - [Checking Mailbox](#checking-mailbox)
  - [Fetching Single Message](#fetching-single-message)
  - [Downloading Attachments](#downloading-attachments)
- [API Reference](#api-reference)
  - [OneSecMail Class](#onesecmail-class)
    - [Methods](#methods)
- [Models](#models)
  - [Message Class](#message-class)
  - [MessageDetails Class](#messagedetails-class)
  - [Attachment Class](#attachment-class)
- [Best Practices](#best-practices)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Generate Random Email Addresses**: Quickly generate one or multiple random email addresses using the available domains.
- **Retrieve Active Domains**: Fetch the list of currently active domains that can be used for email addresses.
- **Check Mailbox**: Retrieve a list of messages in a specific mailbox.
- **Fetch Single Message**: Read the details of a single message, including its body and attachments.
- **Download Attachments**: Download attachments from messages directly to your local storage.

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  one_sec_mail: ^1.0.0
```

Then run:

```bash
flutter pub get
```

Or for a Dart project:

```bash
dart pub get
```

## Usage

Here's how to use the package:

### Import the Package

```dart
import 'package:one_sec_mail/one_sec_mail.dart';
```

### Generating Random Email Addresses

```dart
void main() async {
  final mailClient = OneSecMail();

  // Generate random email addresses
  List<String> emails = await mailClient.generateRandomEmails(count: 5);
  print('Generated Emails: $emails');
}
```

### Retrieving Active Domains

```dart
// Get list of active domains
List<String> domains = await mailClient.getDomainList();
print('Active Domains: $domains');
```

### Checking Mailbox

```dart
// Use the first generated email for further actions
String email = emails.first;
String login = email.split('@')[0];
String domain = email.split('@')[1];

// Check mailbox
List<Message> messages = await mailClient.getMessages(login: login, domain: domain);
print('Messages: $messages');
```

### Fetching Single Message

```dart
if (messages.isNotEmpty) {
  // Read a message
  int messageId = messages.first.id;
  MessageDetails messageDetails = await mailClient.readMessage(
    login: login,
    domain: domain,
    id: messageId,
  );
  print('Message Details: $messageDetails');
}
```

### Downloading Attachments

```dart
if (messageDetails.attachments.isNotEmpty) {
  Attachment attachment = messageDetails.attachments.first;
  await mailClient.downloadAttachment(
    login: login,
    domain: domain,
    id: messageId,
    filename: attachment.filename,
    savePath: '/path/to/save', 
  );
  print('Attachment downloaded: ${attachment.filename}');
}
```

## API Reference

### OneSecMail Class

#### Methods

- `generateRandomEmails({int count = 1})`

  Generates random email addresses.

  Parameters:
  - `count`: Number of email addresses to generate (default is 1).
  
  Returns: `Future<List<String>>`

- `getDomainList()`

  Retrieves a list of active domains.

  Returns: `Future<List<String>>`

- `getMessages({required String login, required String domain})`

  Retrieves messages from the specified mailbox.

  Parameters:
  - `login`: The username part of the email address.
  - `domain`: The domain part of the email address.
  
  Returns: `Future<List<Message>>`

- `readMessage({required String login, required String domain, required int id})`

  Fetches details of a single message.

  Parameters:
  - `login`: The username part of the email address.
  - `domain`: The domain part of the email address.
  - `id`: The message ID.
  
  Returns: `Future<MessageDetails>`

- `downloadAttachment({required String login, required String domain, required int id, required String filename, required String savePath})`

  Downloads an attachment from a message.

  Parameters:
  - `login`: The username part of the email address.
  - `domain`: The domain part of the email address.
  - `id`: The message ID.
  - `filename`: The name of the attachment file.
  - `savePath`: The local directory path where the file will be saved.
  
  Returns: `Future<void>`

## Models

### Message Class

Represents a message in the mailbox.

Fields:

- `id` (int): Message ID.
- `from` (String): Sender's email address.
- `subject` (String): Subject of the email.
- `date` (String): Receive date of the email.

### MessageDetails Class

Represents detailed information about a message.

Fields:

- `id` (int): Message ID.
- `from` (String): Sender's email address.
- `subject` (String): Subject of the email.
- `date` (String): Receive date of the email.
- `attachments` (List<Attachment>): List of attachments.
- `body` (String): Message body (HTML if exists, text otherwise).
- `textBody` (String): Message body in plain text.
- `htmlBody` (String): Message body in HTML.

### Attachment Class

Represents an attachment in a message.

Fields:

- `filename` (String): Name of the attachment file.
- `contentType` (String): MIME type of the attachment.
- `size` (int): Size of the attachment in bytes.

## Best Practices

1. **Null Safety**: The package is written with null safety in mind. Ensure your project is using a Dart SDK version that supports null safety.
2. **Exception Handling**: Wrap API calls in try-catch blocks to gracefully handle exceptions and API errors.
3. **Async/Await**: Use async/await syntax to handle asynchronous operations cleanly.
4. **Resource Management**: Clean up any temporary files or data after usage, especially when downloading attachments.
5. **Permissions**: Ensure your application has the necessary permissions to write to the specified directories when downloading attachments.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on the GitHub repository to contribute to this project.

## License

This project is licensed under the MIT License. See the LICENSE() file for details.

Disclaimer: Use this package responsibly and adhere to the terms and conditions of 1secmail.com. Temporary email services should not be used for malicious activities.
