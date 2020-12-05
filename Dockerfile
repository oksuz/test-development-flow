FROM node:10.0.0-alpine AS builder

WORKDIR /opt/app

COPY ./frontend/package.json .
RUN npm install
VOLUME [ "/opt/app/node_modules" ]
COPY ./frontend .
RUN npm run build


FROM nginx:stable-alpine
WORKDIR /usr/share/nginx/html
COPY --from=builder /opt/app/dist .
EXPOSE 80
