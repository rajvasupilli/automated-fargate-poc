FROM centos
RUN sudo yum install -y java-1.8.0-openjdk.x86_64
RUN sudo curl https://bintray.com/sbt/rpm/rpm | sudo tee /etc/yum.repos.d/bintray-sbt-rpm.repo
RUN sudo yum -y install sbt
RUN sbt test
RUN sbt "runMain example.Hello"
RUN sbt stage
RUN /home/ec2-user/automated-fargate-poc/target/universal/stage/bin
