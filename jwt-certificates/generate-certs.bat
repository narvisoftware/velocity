openssl genrsa -out private.pem 2048

rem openssl pkcs8 -topk8 -inform PEM -outform PEM -nocrypt -in private.pem -out private_unencrypted.pem
rem openssl rsa -in private.pem -outform PEM -pubout -out public.pem

rem it was uncommented, but private.pem and the out from below command: private_unencrypted.pem is the same
rem openssl pkcs8 -topk8 -inform PEM -outform PEM -in private.pem -out private_unencrypted.pem -nocrypt

openssl rsa -in private.pem -pubout -outform PEM -out public.pem