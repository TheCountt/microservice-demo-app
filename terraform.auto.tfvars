region                  = "us-west-1"
cluster_name            = "app-eks"
iac_environment_tag     = "development"
name_prefix             = "isaac-eks"
main_network_block      = "10.0.0.0/16"
subnet_prefix_extension = 4
zone_offset             = 8 

# Ensure that these users already exist in AWS IAM. Another approach is that you can introduce an iam.tf file to manage users separately, get the data source and interpolate their ARN.
admin_users = ["susan", "ashnelson"] 
developer_users                = ["pat", "ren"]
asg_instance_types             = [{ instance_type = "t3.micro" }, { instance_type = "t3.medium" } ]
autoscaling_minimum_size_by_az = 3
autoscaling_maximum_size_by_az = 5