ARG PLACEHOLDER=434a6d8a-6b52-4a2d-a423-8a40259b4839

FROM node:alpine as builder

ARG PLACEHOLDER

RUN apk add jq

WORKDIR /app

COPY package.json .
COPY package-lock.json .

RUN npm install

COPY . .

# Patch the package.json file
RUN cat package.json | jq ". += {\"homepage\": \"${PLACEHOLDER}\"}" | tee package.json

# Patch the browserRouter. In this example i used `createBrowserRouter` and it's located in src/pages/main.jsx.
# Note: It is important that the `basename` tag to exists.
RUN sed -i -E "s/(basename:\s?\").*\"/\1\/${PLACEHOLDER}\"/g" src/pages/main.jsx

RUN npm run build

FROM nginx

ARG PLACEHOLDER
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build .

RUN echo "#!/usr/bin/env bash" > entrypoint.sh
RUN echo "sed -i \"s|/${PLACEHOLDER}|\${REACT_HOMEPAGE}|g\" \$(grep -r \"${PLACEHOLDER}\" ./* 2>/dev/null | awk -F':' '{print \$1}' | sort -u | grep -v entrypoint) 2>/dev/null" >> entrypoint.sh
RUN echo 'nginx -g "daemon off;"' >> entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/bin/bash", "-c", "/usr/share/nginx/html/entrypoint.sh"]
