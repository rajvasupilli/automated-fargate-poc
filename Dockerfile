FROM centos
RUN yum install -y java-1.8.0-openjdk.x86_64
RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo
RUN yum -y install sbt
ARG SBT_VERSION=1.3.13
ADD target target
# RUN sbt test
# RUN sbt "runMain example.Hello"
# RUN sbt stage
RUN target/universal/stage/bin/automated-fargate-poc

