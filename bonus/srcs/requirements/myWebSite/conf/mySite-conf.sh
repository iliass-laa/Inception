#!/bin/bash


curl -fsSL https://deb.nodesource.com/setup_20.x -o setup.sh
bash setup.sh

apt install -y nodejs

npm install -g yarn


git clone https://github.com/iliass-laa/Escooters.git


cd Escooters
echo "exec pwd:"
pwd

echo "exec yarn install:"
yarn install

echo "exec yarn start:"
yarn start -y

# tail -f /dev/null

