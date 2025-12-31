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
chmod 644 "$CERT_DIR/$CERT_NAME.key"

# Add certificate to macOS Keychain (macOS only)
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Adding certificate to macOS Keychain..."
  sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "$CERT_DIR/$CERT_NAME.crt"
  
  # Add domains to /etc/hosts
  echo "Adding domains to /etc/hosts..."
  HOSTS_ENTRY="127.0.0.1 $CERT_NAME squidex.$CERT_NAME"
  if ! grep -q "$CERT_NAME" /etc/hosts; then
    echo "$HOSTS_ENTRY" | sudo tee -a /etc/hosts > /dev/null
    echo "Added: $HOSTS_ENTRY"
  else
    echo "$CERT_NAME already in /etc/hosts"
  fi
fi

echo "✅ Certificate created!"
echo "Certificate: $CERT_DIR/$CERT_NAME.crt"
echo "Key: $CERT_DIR/$CERT_NAME.key"