# This project is a simple java web application. Tools used include; Terraform, Packer, Maven, Tomcat Server, Datadog, Github action and AWS cloud provider.

# Packer Folder contains 'custom_image.json, variable.json and tomcat_install.sh', this will build a custom baked imaged that will be preconfigured with all applications except the source code. By running 'Packer build custom_image.json', the custom image will be generated and serves as imput to the Terraform template. The output AMI will be used by Terraform to launch EC2 servers on AWS. 
   - custom_image.json contains code that will build a custom image with som pre-configured application by Ansible playbook and Shell script.
   - Variable.json contains variables to be used by packer.
   - Tomcat_install.sh contains scripts to pre-install Tomcat server in the image that will host the web application. This script will be invoked by Packer.

# The Terraform file contains codes that will build the infracture on AWS:  EC2 servers (with simple scaling policy), ELB, Autoscaling Group. The image that will be used to launch this servers will be obtained from Packer built output. Note that input AMI from Packer will be used dynamically to deploy this infracture. Run 'terraform apply' to deploy the infrastructure.
# The Ansible file (Playbook) will be used by PACKER to deploy monitoring agents (Datadog), Tomcat Server and other packages.
# .github contains the CI/CD code the will trigger a build and deployment whenever there is any code change in the source code. Github action is used for CI/CD pipeline. 
