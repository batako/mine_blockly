FROM nginx:1.16.0

ENV NGINX_CONF_SHA256 a9628ee9da915c8b5b96f2d294e06f164fc7c120e8975bcc255d56536ce58b06

COPY nginx.conf /etc/nginx/conf.d/defaults.conf

RUN mv /etc/nginx/conf.d/defaults.conf /tmp/defaults.conf \
    && rm -f /etc/nginx/conf.d/* \
    && mv /tmp/defaults.conf /etc/nginx/conf.d/defaults.conf \
    && echo "${NGINX_CONF_SHA256} /etc/nginx/conf.d/defaults.conf" | sha256sum -c - \
    && touch /var/run/nginx.pid \
    && chown -R nginx:nginx /var/run/nginx.pid \
    && chown -R nginx:nginx /var/cache/nginx

USER nginx
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf

EXPOSE 8080