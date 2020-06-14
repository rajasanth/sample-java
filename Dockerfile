FROM openjdk:8-jre

WORKDIR /app

COPY target/demo-0.0.1-SNAPSHOT.jar /app

CMD [ "java", "-jar", "demo-0.0.1-SNAPSHOT.jar" ]
