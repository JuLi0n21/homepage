FROM nginx:stable-alpine

RUN rm -rf /usr/share/nginx/html/*

COPY ./dist /usr/share/nginx/html

# If you have a custom nginx config for Astro (SPAs/Routing), uncomment this:
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 

CMD ["nginx", "-g", "daemon off;"]
