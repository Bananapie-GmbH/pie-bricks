# Common build stage
FROM node:16-alpine as common-build-stage

# bind your app to the gateway IP
ENV HOST=0.0.0.0

COPY . ./app

WORKDIR /app

RUN npm install

EXPOSE 4000

# Development build stage
FROM common-build-stage as development-build-stage

ENV NODE_ENV development

CMD ["npm", "run", "dev"]

# Production build stage
FROM common-build-stage as production-build-stage

ENV NODE_ENV production

RUN npm run build

CMD ["npm", "run", "start"]
