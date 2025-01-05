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


# FROM node:16-alpine

# ENV PORT=3000

# WORKDIR /bookapp-react-js
# COPY . /bookapp-react-js
# RUN npm run build
# EXPOSE ${PORT}
# CMD ["npm", "start"]


# FROM nginx:1.22.1-alpine as prod-stage
# COPY --from=build-stage /app/build /usr/share/nginx/html
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]
