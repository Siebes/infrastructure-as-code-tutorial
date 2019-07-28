#!/bin/bash
set -e

git clone https://github.com/Artemmkin/raddit.git
cd ./raddit
sudo bundle install
sudo systemctl start raddit
sudo systemctl enable raddit