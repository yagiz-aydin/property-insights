# https://github.com/nodejs/docker-node/blob/893511202f3e478d6b23e76b5658b93be6e906b7/20/bookworm/Dockerfile
FROM node:20.20.0-alpine as builder
WORKDIR /app
COPY package.json .
COPY .env.prod .env.prod
RUN yarn install
COPY . .
RUN yarn run build

FROM nginx:mainline-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]