FROM gradle:7.5-jdk17-alpine AS build

# Copy everything inside this container
COPY --chown=gradle:gradle . /home/gradle/src

WORKDIR /home/gradle/src

RUN gradle build --no-daemon

FROM openjdk:17-jdk-alpine

# Exposed out port
EXPOSE 8080

# Create folder for .jar
RUN mkdir /app

# Add .jar to app
COPY --from=build /home/gradle/src/build/libs/*.jar /app/producer-0.0.1-SNAPSHOT.jar

# Add user
RUN adduser --system --no-create-home user

# Set user
USER user

# Entrypoint for running .jar file which is actually our web application
ENTRYPOINT ["java", "-jar", "/app/producer-0.0.1-SNAPSHOT.jar"]