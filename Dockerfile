FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Step 2: Production Stage (Nginx)
FROM nginx:alpine

# Default nginx static files remove karo
RUN rm -rf /usr/share/nginx/html/*

# Build output copy karo
COPY --from=build /app/build /usr/share/nginx/html

# Port expose
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]