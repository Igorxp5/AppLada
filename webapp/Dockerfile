FROM node:slim

# Creating API workspace
RUN mkdir webapp
COPY . /webapp
WORKDIR /webapp

# Installing system dependecies
RUN npm install

EXPOSE 3000

RUN npm run build && npm install -g serve

CMD serve build