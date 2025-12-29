# Run on the host - not form the container

chmod +x setup-certs.sh
Run it: bash ./setup-certs.sh happy.dev 365 .devcontainer/ssl

## Validate the cert was added to the keychain

```bash
security find-certificate -c happy.dev /Library/Keychains/System.keychain
```

## Check the certificate's Subject Alternative Names

```bash
openssl x509 -in happy.dev.crt -text -noout | grep -A 1 "Subject Alternative Name"
```

## Test the certs from the host

```bash
# Test both domains (will show cert details)
curl -v https://happy.dev 2>&1 | grep -i subject
curl -v https://squidex.happy.dev 2>&1 | grep -i subject
```
