FROM centos
RUN yum install -y java-1.8.0-openjdk.x86_64
RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo
RUN yum -y install sbt
<<<<<<< HEAD
ADD . /
RUN sbt test
RUN sbt "runMain example.Hello"
RUN sbt stage
RUN pwd
RUN ls 
RUN target/universal/stage/bin/automated-fargate-poc
=======
ARG SBT_VERSION=1.3.13
RUN sbt test
RUN sbt "runMain example.Hello"
RUN sbt stage
RUN ls -lthr bin
#RUN target/universal/stage/bin/automated-fargate-poc
>>>>>>> 6bc1f408c4d79788eae9e2dc852f408f7900c781
