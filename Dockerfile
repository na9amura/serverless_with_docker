FROM node:6.12.2-slim

ENV APP_ROOT /var/tasks

WORKDIR $APP_ROOT

RUN apt-get update -y && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get install -y apt-transport-https

RUN apt-get update -y && \
  apt-get install -y \
  python3 \
  python3-pip \
  default-jre \
  yarn

RUN python3 -m pip install --upgrade awscli

RUN yarn init -y && \
  yarn global add serverless && \
  yarn add aws-sdk && \
  yarn add --dev \
    serverless-offline \
    serverless-dynamodb-local

CMD 'serverless' 'offline' 'start'
