FROM mhart/alpine-node:10.16.3 as build

WORKDIR /build

COPY yarn.lock /build
COPY package.json yarn.lock /build/
RUN yarn

COPY src /build/src
COPY tsconfig.json /build
COPY tslint.json /build
COPY webpack.config.js /build
RUN yarn verify
RUN yarn build

FROM mhart/alpine-node:10.16.3

COPY --from=build /build/dist/server.js /app/server.js

WORKDIR /app

EXPOSE 3000

ENTRYPOINT ["node", "server.js"]
