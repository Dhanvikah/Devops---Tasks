resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "EC2-CPU-Usage-High"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "This alarm triggers if CPU usage > 70%"
  alarm_actions       = [aws_sns_topic.cpu_alarm_topic.arn]
  dimensions = {
    InstanceId = aws_instance.ec2_instance.id
  }
}
