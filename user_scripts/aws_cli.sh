################################################################################
# Verify if AWS Cli is already installed by checking for the version command first 
# and the default location for the archive second
################################################################################
aws_url="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"


if ! command -v "aws" &> /dev/null
then
	echo "aws cli not installed, downloading and installing"
	echo "downloading from $aws_url"
	if [ -z ~/aws ]
	then
		mkdir ~/aws
	fi
	cd ~/aws
	curl $aws_url -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
else
	echo "aws cli already installed according to command 'aws'"
	echo "Version output: $( aws --version )"
	exit 0
fi
