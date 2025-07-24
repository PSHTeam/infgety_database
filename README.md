
# Infgety Database

A Dart library providing utilities for encryption, HTTP operations, and contact management for Infgety database feature. This library helps you implement database configurations that Infgety users can add to their applications.

## Features

- **AES Encryption/Decryption**: Secure data encryption and decryption using AES CBC mode
- **HTTP Utilities**: Simplified HTTP GET and POST operations
- **Contact Management**: Data structures for handling contact information and queries
- **Utility Functions**: Helper functions for data validation and conversion
- **Custom Exceptions**: Specialized exception handling for Infgety operations

## Getting Started

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  infgety_database:
    git:
      url: https://github.com/PSHTeam/infgety_database.git
```

Then run:

```bash
dart pub get
```

Import the package in your Dart code:

```dart
import 'package:infgety_database/infgety_database.dart';
```

## Core Classes and Functions

### AES Class

The `AES` class provides AES encryption and decryption capabilities using CBC mode.

#### Constructor

```dart
AES({
  required String keyHex,    // Hexadecimal key string
  required String ivHex,     // Hexadecimal initialization vector
  String? encoding,          // Optional encoding: 'base64', 'base16', or 'utf8'
})
```

#### Methods

- `String encrypt(String plainText)` - Encrypts plain text and returns encrypted string
- `String decrypt(String cipherText)` - Decrypts cipher text and returns plain text

#### Example

```dart
final aes = AES(
  keyHex: 'your_32_character_hex_key_here',
  ivHex: 'your_32_character_hex_iv_here',
  encoding: 'base64',
);

String encrypted = aes.encrypt('Hello, World!');
String decrypted = aes.decrypt(encrypted);
print(decrypted); // Output: Hello, World!
```

### ContactName Class

A data model representing a contact with name and quantity information.

```dart
ContactName({
  required String name,      // Contact name
  required int quantity,     // Associated quantity
})
```

#### Example

```dart
final contact = ContactName(
  name: 'John Doe',
  quantity: 5,
);
```

### FetchContactsQuery Class

A query model for fetching contact information based on phone number details.

#### Constructor

```dart
FetchContactsQuery({
  required String nationalNumber,  // National phone number
  required String countryCode,     // Country code
  required String regionCode,      // Region code
})
```

#### Factory Constructor

```dart
FetchContactsQuery.fromArgs(List<String> args)
```

Creates a `FetchContactsQuery` from a list of string arguments. Requires at least 3 arguments.

#### Example

```dart
final query = FetchContactsQuery(
  nationalNumber: '1234567890',
  countryCode: 'US',
  regionCode: 'CA',
);

// Or from arguments
final queryFromArgs = FetchContactsQuery.fromArgs([
  '1234567890',
  'US', 
  'CA'
]);
```

### InfgetyException Class

A custom exception class for handling Infgety-specific errors.

```dart
InfgetyException(String message)
```

#### Example

```dart
try {
  // Some operation that might fail
  throw InfgetyException('Operation failed');
} catch (e) {
  if (e is InfgetyException) {
    print('Infgety error: ${e.message}');
  }
}
```

## Utility Functions

### HTTP Functions

- `Future<Response> post(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding})`
- `Future<Response> get(Uri url, {Map<String, String>? headers})`

#### Example

```dart
final response = await post(
  Uri.parse('https://api.example.com/data'),
  headers: {'Content-Type': 'application/json'},
  body: '{"key": "value"}',
);
```

### Utility Functions

- `bool isNull(Object? object)` - Checks if an object is null
- `String uint8ListToHex(Uint8List input)` - Converts Uint8List to hexadecimal string

#### Example

```dart
bool nullCheck = isNull(someVariable);

Uint8List data = Uint8List.fromList([255, 16, 32]);
String hexString = uint8ListToHex(data); // Returns: "ff1020"
```

## Complete Usage Example

```dart
import 'package:infgety_database/infgety_database.dart';

void main() async {
  // AES Encryption
  final aes = AES(
    keyHex: '0123456789abcdef0123456789abcdef',
    ivHex: 'fedcba9876543210fedcba9876543210',
    encoding: 'base64',
  );
  
  String encrypted = aes.encrypt('Sensitive data');
  print('Encrypted: $encrypted');
  
  String decrypted = aes.decrypt(encrypted);
  print('Decrypted: $decrypted');
  
  // Contact handling
  final contact = ContactName(name: 'Alice Smith', quantity: 10);
  
  // Query creation
  final query = FetchContactsQuery(
    nationalNumber: '5551234567',
    countryCode: 'US',
    regionCode: 'NY',
  );
  
  // HTTP request
  try {
    final response = await get(Uri.parse('https://api.example.com/contacts'));
    print('Response status: ${response.statusCode}');
  } catch (e) {
    print('HTTP error: $e');
  }
  
  // Utility functions
  print('Is null: ${isNull(null)}'); // true
  print('Is null: ${isNull('data')}'); // false
}
```