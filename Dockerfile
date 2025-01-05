# Stage 1: Build Stage
FROM node:16-alpine as build-stage
ENV PORT=3000
WORKDIR /bookapp-react-js
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
# Stage 2: Production Stage
FROM nginx:1.22.1-alpine as prod-stage
COPY --from=build-stage /bookapp-react-js/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
