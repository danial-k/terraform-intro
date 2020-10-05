Terraform intro
===
Terraform is a command-line tool to automate the deployment of many kinds of infrastructure.
This may range from managing a single docker host to complex multi-cloud deployments with many resources.
A Terraform project consists of one or more ```.tf``` files that are read by terraform and executed to create the desired infrastructure.

# Outline
In this tutorial, we will use Terraform to manage docker on the local machine.
It is assumed that Docker is already installed and docker commands are available to run without root privileges.
The sections of the tutorial are:
1. Install terraform (recommended to use tfenv)
2. Prepare Docker images
3. Run terraform to deploy the infrastructure
4. Discuss features of terraform and compare with other approaches.

# Installing Terraform
As with most programming languages, there are multiple versions of terraform with significant changes between different versions.
To ease switching between versions of a language or tools, environment managers are available for most languages.
For example, to work with multiple versions of python, the [pyenv](https://github.com/pyenv/pyenv) tool may be used to run different versions of python without uninstalling/reinstalling each time.
For Terraform, a community project [tfenv](https://github.com/tfutils/tfenv) exists to help manage the specific version of terraform needed for a project.
Note that for the purposes of this tutorial, tfenv installation is not required, if you prefer a simpler installation to get started, follow the [official instructions](https://learn.hashicorp.com/tutorials/terraform/install-cli).

## Mac/Linux
Download the community project including its binaries to a local directory, for example ```software``` in your home directory:
```shell
mkdir ~/software
git clone https://github.com/tfutils/tfenv.git ~/software/tfenv
```
Make the binaries available to your shell:
Note that ```${HOME}``` or ```$HOME``` is an alias for home directory ```~``` which points to ```/Users/yourusername``` (MacOS) or ```/home/yourusername``` (Linux).
Follow the instructions below depending on the shell you are using.
### zsh
Edit ```.zshrc``` in your home directory with an editor (e.g. ```nano``` or ```vi```) and add the following.
If ```~/.zshrc``` does not exist, create it and add the following:
```shell
path+=("${HOME}/software/tfenv/bin")
```
Reload terminal or run ```source ~/.zshrc``` for the new binaries to be available.
### bash
Edit ```.bashrc``` or ```.bash_profile``` in your home directory with an editor (e.g. ```nano``` or ```vi```) and add the following.
```bash
export PATH="$HOME/software/tfenv/bin:$PATH"
```
Reload terminal or run ```source ~/.bashrc``` ```source ~/.bash_profile``` for the new binaries to be available.

# Prepare docker images
In this tutorial, we will set up an nginx load balancer to direct traffic to three different backend servers.
nginx is a high-performance web server that functions particularly well as a reverse-proxy that receives requests and proxies those request to a number of backends.
Build a local docker image with a customised nginx configuration (see [nginx/Dockerfile] and [nginx/default.conf])
```shell
cd nginx
docker build -t terraform-demo/nginx:1.0.0 .
```
Here we are creating a new docker image locally and tagging (```-t```) with the name ```terraform-demo/nginx``` and version ```1.0.0```. The `.` at the end instructs the Docker engine to use the current directory (`.`) as the build context.  The build context consists of all the files and sub-directories available during build.

# Prepare Terraform with tfenv
Notice the ```.terraform-version``` file in the project root.
This file will instruct tfenv to fetch a specific version of terraform and use it for this project.
Assuming you do not have any terraform versions installed already:
```
tfenv install
```
To verify the version of your installation:
```shell
terraform --version
```

# Run Terraform
Examine the contents of [main.tf].
Run the following command to initialise Terraform into your local directory:
```shell
terraform init
```
To view the changes that Terraform will suggest to your local infrastructure:
```
terraform plan
```
To apply the changes:
```
terraform apply
```
Confirm by entering `yes`.
