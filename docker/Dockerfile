FROM mhart/alpine-node:10.16.3 as build

WORKDIR /build

COPY package.json yarn.lock /build/

RUN yarn install --frozen-lockfile && yarn cache clean

COPY src /build/src
COPY tsconfig.json /build
COPY tslint.json /build
COPY scripts /build/scripts
COPY webpack.config.js /build

RUN yarn verify
RUN yarn build

FROM mhart/alpine-node:10.16.3

COPY --from=build /build/dist/server.js /app/server.js

WORKDIR /app

EXPOSE 3123

ENTRYPOINT ["node", "server.js"]
