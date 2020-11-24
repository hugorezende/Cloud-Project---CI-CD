FROM node:14-alpine as react-app

# Set vars
ARG ENV=""

# Create an app directory
RUN mkdir -p /app
WORKDIR /app

# Copy important parts of the app
COPY . /app
RUN rm -rf ./node_modules
RUN rm -rf ./dist

# Install the application using the install script
RUN sh ./install.sh

# Nginx configs
FROM nginx:alpine

# Create an app directory
RUN mkdir -p /app
WORKDIR /app

COPY --from=react-app /app/build/ .

COPY deployment/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
