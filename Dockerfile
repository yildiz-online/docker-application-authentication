FROM alpine/git as clone
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
RUN git clone https://github.com/yildiz-online/authentication.git

FROM moussavdb/build-java as build
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
COPY --from=clone /app/authentication /app
RUN mvn install -s settings.xml

FROM moussavdb/runtime-java
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
EXPOSE 10301
COPY --from=build /app/target/authentication-assembly.jar /app
CMD ["java -jar authentication-assembly.jar"]
