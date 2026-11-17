#!/bin/bash


sudo apt install nginx
sudo systemctl start nginx
sudo systemctl enable nginx


echo <h1> this is a new file </h1>  | sudo tee /var/www/html/index.html