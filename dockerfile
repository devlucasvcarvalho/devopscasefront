#Setar a imagem base
FROM node:18-alpine AS build

#Setar o diretório de trabalho da aplicação
WORKDIR /app

#Copiar o package.json e o package-lock.json para o diretório de trabalho
COPY . .

#Instalar as dependências
RUN npm install && npm run build

#Setando proxy reverso
FROM nginx AS deploy
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]