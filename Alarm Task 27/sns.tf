resource "aws_sns_topic" "cpu_alarm_topic" {
  name = "ec2-cpu-alert-topic"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.cpu_alarm_topic.arn
  protocol  = "email"
  endpoint  = "komallkim09@gmail.com"  
}
