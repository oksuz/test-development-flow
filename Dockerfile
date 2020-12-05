FROM node:10.0.0-alpine as builder

WORKDIR /opt/app

COPY ./package.json .
RUN npm install
VOLUME [ "/opt/app/node_modules" ]
COPY . .
RUN npm run build


FROM nginx:stable-alpine
EXPOSE 80
WORKDIR /usr/share/nginx/html
COPY --from=builder /opt/app/dist .

