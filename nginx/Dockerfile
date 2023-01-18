FROM nginx:1.20.1

RUN rm -f /etc/nginx/conf.d/*
COPY /nginx/default.conf /etc/nginx/conf.d/shikaku.conf
CMD ["/usr/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]