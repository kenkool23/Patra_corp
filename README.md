# Patra_corp
# The Terraform file contains codes that will build the infracture: 2 EC2 servers, ELB, Autoscaling Group. The AMI will be obtained from Packer build.

# Packer File contains 'custom_image.json, variable.json and tomcat_install.sh'. By running 'Packer build custom_image.json' the out AMI will be used by Terraform to launch EC2 servers on AWS.
   - custom_image.json contains code that will build a custom image with som pre-configured application by Ansible playbook and Shell script.
   - Variable.json contains variables to be used by packer.
   - Tomcat_install.sh contains scripts to pre-install Tomcat server in the image that will host the web application. This script will be invoked by Packer.
# The Ansible file (Playbook) will be used by PACKER to deploy monitoring agents (Datadog) and other packages.
# Jenkinsfile contains the CI/CD code the will trigger a build and deployment whenever there is any code change in the source code.
