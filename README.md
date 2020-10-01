# Patra_corp
# The Terraform file contains codes that will build the infracture: 2 EC2 servers, ELB, Autoscaling Group.
# Packer file will build a custom image which will be preinstalled with Monitoring agent (DataDog) and Tomcat Server(To host the Web appliction). The configuration will be pulled from Ansible folder. Note that this custom image will be used to launch the infracture by Terraform.

