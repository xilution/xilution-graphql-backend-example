FROM mhart/alpine-node:10.16.3 as build

WORKDIR /build

COPY package.json package-lock.json /build/

RUN npm install

COPY src /build/src
COPY tsconfig.json /build
COPY tslint.json /build
COPY scripts /build/scripts
COPY webpack.config.js /build

RUN npm run verify
RUN npm run build

FROM mhart/alpine-node:10.16.3

COPY --from=build /build/dist/server.js /app/server.js

WORKDIR /app

EXPOSE 3123

ENTRYPOINT ["node", "server.js"]
