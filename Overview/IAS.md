# What is Infrastructure as Code

Process of managing and provisioning infrastructure using code rather than doing it manually.

This covers processes such as file management, installations, creating instances and more.

Managing infrastructure manually is like manually packaging boxes, IaS is like doing this using a machine that automatically packages things.


# What is configuration management

This process can be part of an automation pipeline and speeds up deployment. Can even use programs such as Ansible to update instances or do other processes within them like changing config files or opening ports, provided the IPs and SSH credentials. This is called **configuration management**.

# What is orchestration

Orchestration is an aspect of IaS that focusses on managing and coordinating deployment automatically in multiple different systems at once. 

Essentially congifuration management but can be done on many instances over an entire ASG for example.