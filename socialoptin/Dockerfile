
FROM nginx

LABEL version="1.0" name="social optin static html"

RUN rm /usr/share/nginx/html/*
COPY socialoptin/html/ /usr/share/nginx/html/

RUN chown www-data:www-data -R /usr/share/nginx/html

EXPOSE 80