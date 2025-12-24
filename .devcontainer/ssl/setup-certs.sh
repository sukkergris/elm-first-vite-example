#!/bin/bash

# Example
# bash> setup-certs.sh happy.dev 365

# Default values
CERT_NAME="${1:-localhost}"
DAYS="${2:-365}"
CERT_DIR="${3:-.}"

# Generate private key
openssl genrsa -out "$CERT_DIR/$CERT_NAME.key" 2048

# Generate self-signed certificate
openssl req -x509 -new -key "$CERT_DIR/$CERT_NAME.key" -sha256 -days $DAYS \
  -out "$CERT_DIR/$CERT_NAME.crt" -config req.cnf -extensions v3_req

# Set proper permissions
chmod 644 "$CERT_DIR/$CERT_NAME.crt"
chmod 600 "$CERT_DIR/$CERT_NAME.key"

# Add certificate to macOS Keychain (macOS only)
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Adding certificate to macOS Keychain..."
  sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "$CERT_DIR/$CERT_NAME.crt"
fi

echo "✅ Certificate created!"
echo "Certificate: $CERT_DIR/$CERT_NAME.crt"
echo "Key: $CERT_DIR/$CERT_NAME.key"