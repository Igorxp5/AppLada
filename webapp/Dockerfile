FROM node:slim

ENV PORT 3000

# Creating API workspace
RUN mkdir webapp
COPY . /webapp
WORKDIR /webapp

# Installing system dependecies
RUN npm install

EXPOSE $PORT

RUN npm run build && npm install -g serve

CMD serve build -l $PORT