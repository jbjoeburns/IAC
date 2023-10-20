# Why orchestration
Orchestration is essentially the practice of coordinating many processes in development at the same time.

Coordinating multiple processes at once automatically helps complete a range of tasks all at the same time, saving time.

# Why terraform
Terraform allows you to make many changes to configuration/deployment across a range of different cloud providers all at the same time, esentially completing a task that would take days or weeks, all at once.

Terraform specifically lets you plan your changes to infrastructure then review these before deploying them.

Additionally, you only need to define how you want your infrastructure to look in the end using your config files, so dont need to define a laborious step by step process.

# How to do orchestration with terraform

![Alt text](image.png)

Orcehstration with Terraform is a 3 step process. 

This first involves defining your infrastructure such as contents of configuration files. 

Then reviewing the changes to make sure the actions performed are to your specifications.

And finally, applying these changes across a range of different instances and cloud providers.

# How to use terraform

Terraform uses files marked with the .tf file format to execute it's commands.

1. To begin we open GitBash (as admin) and create `main.tf` with nano.

2. In this file we add the following to download the resources to use terraform with our given provider:

```
# Name of our provider (eg. "aws")
provider "<name>" {
    # Region we want our instances located in within our provider
    region = "<region>"
}
```
- The syntax for Terraform is extremely simple and primarily consists of variable names, and their associated information in quotation marks. These are all contained within curly brackets denoting what exactly we're creating.

3. We then save this, and run it using `terraform init`, which will download all the resources we need.

4. We can then add more to `main.tf` based on the provider we gave. In the case of an AWS EC2 instance, this would look like this.

```
# Give the name here and say that we want an instance (vs say, a VPC for example)
resource "aws_instance" "<name>" {
    # Define the AMI here
    ami = "<ami ID>"

    # The type of the instance, (eg. t2.micro, etc...)
    instance_type = "<type here>"

    # Any tags we want to help with searching for our instance 
    tags = {
        # For example, the name
        Name = "<name>"
    }
}
```

5. With this we can run `terraform plan` which will list the changes that will be made, it's worth reading these before going to the next step so we know exactly what we'll be doing.

6. Then we can run `terraform apply` to make those changes.

7. Finally, once we're done with our instance, `terraform destroy` will terminate it.

The advantage of this is that the entire process of creating and terminating instances can be fully automated, saving time and therefore money.