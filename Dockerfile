FROM node:12.18-alpine

WORKDIR /app

RUN npm install -g pm2

COPY ["package.json", "package-lock.json*", "./"]

RUN npm install --production --silent

COPY . .

# ----- If UID:GID is 1000:1000
# RUN chown -R node:node /app
# USER node

# ----- Else
# First find your host UID:GID using "whoami", Eg: your host user is "1111:2222"
# RUN cat /etc/group
# RUN addgroup -g 20 appgroup
# RUN adduser -D -u 501 appuser -G appgroup
# RUN chown -R appuser:appgroup /app


RUN adduser -D -u 501 appuser -G dialout
RUN chown -R appuser:dialout /app
USER appuser
# ---------------------------------------

CMD ["pm2-runtime", "ecosystem.config.js", "--env", "production"]