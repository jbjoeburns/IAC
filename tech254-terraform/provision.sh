#!/bin/bash
# Export command, to find db
export DB_HOST=mongodb://${aws_instance.tech254-joe-iac-db-test.private_ip}:27017/posts

# install node (may not need this if using instance with it already installed)
sudo npm install

# move to app directory
cd /home/ubuntu/app/app
sudo systemctl restart nginx

# seed db
node seeds/seed.js

# install pm2 (may not need this if using instance with it already installed)
sudo npm install pm2 -g

# kill, in case anything else is running
pm2 kill

# start app
pm2 start app.js