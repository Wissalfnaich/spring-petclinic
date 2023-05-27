FROM openjdk:8-jre-alpine

# Définir la variable d'environnement pour le port d'application
ENV PORT=8081

# Copier le fichier JAR dans le conteneur
COPY ./target/spring-petclinic-3.0.0-SNAPSHOT.jar /usr/app/

# Définir le répertoire de travail
WORKDIR /usr/app

# Exposer le port défini
EXPOSE $PORT

# Lancer l'application Spring Boot
CMD java -Dserver.port=$PORT -jar spring-petclinic-3.0.0-SNAPSHOT.jar
