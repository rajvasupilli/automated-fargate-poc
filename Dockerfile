FROM centos

sbt test
sbt "runMain example.Hello"
sbt stage
/home/ec2-user/automated-fargate-poc/target/universal/stage/bin
