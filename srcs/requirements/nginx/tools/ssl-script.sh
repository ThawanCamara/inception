DOMAIN=${DOMAIN_NAME}
TIME="\e[38;5;8m($(shell date +%H:%M:%S))\e[0m"

if [ -f "/etc/nginx/key/private.key" ] && [ -f "/etc/nginx/key/certify.crt" ]; then
	echo "${TIME} Certification files already exists"
else
	mkdir /etc/nginx/key
	openssl genrsa -out /etc/nginx/key/private.key 2048
	openssl req -new -x509 -key /etc/nginx/key/private.key -out /etc/nginx/key/certify.crt -days 365 -subj "/CN=${DOMAIN}"
fi
