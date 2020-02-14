FROM timbru31/node-chrome:12

ENV SCAN_URL=https://www.mattorb.com

RUN apt-get update 
RUN apt-get install -y xvfb libgbm-dev

COPY package-lock.json .
COPY package.json .

RUN npm ci

RUN npm install -g chromium @jakepartusch/lumberjack

CMD [ "/bin/sh", "-c", "xvfb-run --auto-servernum lumberjack --url $SCAN_URL" ]