FROM alpine/git as clone
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
RUN git clone https://github.com/yildiz-online/authentication.git

FROM moussavdb/build-java-dependencies as build
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
COPY --from=clone /app/authentication /app
RUN mvn install -s ../build-resources/settings.xml -DskipTests -Pbuild-assembly

FROM moussavdb/runtime-java
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
EXPOSE 10301
COPY --from=build /app/target/authentication-server-assembly.jar /app
CMD ["java -jar authentication-server-assembly.jar"]
