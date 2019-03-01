FROM node:10-alpine

LABEL maintainer="Ryan Nestor <ryan@monadnock.org>" \
      org.label-schema.vendor="Monadnock" \
      org.label-schema.name="Strapi CLI Docker image" \
      org.label-schema.description="Container to wrap the strapi command" \
      org.label-schema.url="https://strapi.io" \
      org.label-schema.vcs-url="https://github.com/strapi" \
      org.label-schema.version=latest \
      org.label-schema.schema-version="0.0"

WORKDIR /usr/src/api

RUN echo "unsafe-perm = true" >> ~/.npmrc

RUN npm install -g strapi@3.0.0-alpha.17

EXPOSE 1337

ENTRYPOINT ["strapi"]
CMD [""]
