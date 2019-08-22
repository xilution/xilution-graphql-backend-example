FROM mhart/alpine-node:8.10.0 as build

WORKDIR /build

COPY yarn.lock /build
COPY package.json yarn.lock /build/
RUN yarn

COPY __tests__ /build/__tests__
COPY src /build/src
COPY jest.config.js /build
COPY tsconfig.json /build
COPY tslint.json /build
COPY webpack.config.js /build
RUN yarn test
RUN yarn build

FROM mhart/alpine-node:8.10.0

COPY --from=build /build/dist/server.js /app/server.js

WORKDIR /app

EXPOSE 3000

ENTRYPOINT ["node", "server.js"]
