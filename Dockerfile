FROM node:16-alpine3.15 as builder

WORKDIR /app

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static /tini
RUN chmod +x /tini

COPY package.json yarn.lock ./
RUN yarn install --prod --frozen-lockfile

FROM gcr.io/distroless/nodejs:16
ENV NODE_ENV production

WORKDIR /app

COPY --from=builder --chown=nonroot:nonroot /tini /tini
COPY --from=builder --chown=nonroot:nonroot /app/node_modules ./node_modules
COPY --chown=nonroot:nonroot . .

USER nonroot
EXPOSE 3000

ENTRYPOINT [ "/tini", "--", "/nodejs/bin/node" ]
CMD ["/app/index.js"]
