FROM centos

RUN sbt test
RUN sbt "runMain example.Hello"
RUN sbt stage
RUN /home/ec2-user/automated-fargate-poc/target/universal/stage/bin
