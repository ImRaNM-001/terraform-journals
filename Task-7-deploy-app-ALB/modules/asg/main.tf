# ASG Launch Template
resource "aws_launch_template" "template_name" {
  name          = "${var.project_name}-templates"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = filebase64("${path.module}/config.sh")  # Use path.module instead of ./ coz it looked in root directory where terraform was run

  vpc_security_group_ids = [var.client_sg_id]

  tags = {
    Name = "${var.project_name}-templates"
  }
}

# ASG
resource "aws_autoscaling_group" "asg_name" {
  name                      = "${var.project_name}-asg"
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_desired_cap
  health_check_grace_period = 300
  health_check_type         = var.asg_health_check_type                         # "ELB" or default EC2
  vpc_zone_identifier = [var.priv_sub_3a_id, var.priv_sub_4b_id]
  target_group_arns   = [var.target_grp_arn]                    

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  launch_template {
    id      = aws_launch_template.template_name.id
    version = aws_launch_template.template_name.latest_version 
  }
}

# Scale Up policy
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${var.project_name}-asg-scale-up"
  autoscaling_group_name = aws_autoscaling_group.asg_name.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"                                                  # increasing instance by 1 
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

# Scale Up alarm - will trigger the ASG policy (Scale Ddown) based on the metric (CPUUtilization), comparison_operator, threshold
resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name          = "${var.project_name}-asg-scale-up-alarm"
  alarm_description   = "asg-scale-up-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"                                    # New instance will be created once CPU utilization is higher than 30 %
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.asg_name.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_up.arn]
}

# Scale Down policy
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.project_name}-asg-scale-down"
  autoscaling_group_name = aws_autoscaling_group.asg_name.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"                                                 # decreasing instance by 1 
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

# Scale Down alarm
resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name          = "${var.project_name}-asg-scale-down-alarm"
  alarm_description   = "asg-scale-down-cpu-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"                                     # Instance will scale down when CPU utilization is lower than 5 %
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.asg_name.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_down.arn]
}
