FROM nginx

COPY website/provisioning/nginx/nginx.conf /etc/nginx/nginx.conf
COPY website/provisioning/nginx/redirects.map /etc/nginx/redirects.map

RUN nginx -t

EXPOSE 80
