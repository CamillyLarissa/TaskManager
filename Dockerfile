FROM eclipse-temurin:25 AS build
WORKDIR /app
COPY . /app
RUN apt-get update && apt-get install -y maven
RUN mvn clean install -DskipTests

FROM openjdk:25-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
