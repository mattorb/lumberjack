FROM ubuntu:18.04


RUN apt-get update
RUN apt-get install -y libgbm-dev xvfb apt-transport-https curl xvfb
RUN curl --silent --location https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs build-essential

# ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
# ENV PATH=$PATH:/home/node/.npm-global/bin

ENV SCAN_URL=https://www.mattorb.com

RUN apt-get install -y xvfb libgbm-dev
COPY package-lock.json .
COPY package.json .

RUN npm ci
RUN npm install chromium
RUN npm install -g @jakepartusch/lumberjack --unsafe-perm=true
# re:unsafe-perm, see https://github.com/puppeteer/puppeteer/issues/367#issuecomment-499315095

CMD [ "/bin/sh", "-c", "xvfb-run --auto-servernum lumberjack --url $SCAN_URL" ]