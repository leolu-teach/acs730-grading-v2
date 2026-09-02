#!/usr/bin/env bash
set -euo pipefail
sudo dnf install -y httpd
echo "<h1>ACS730 - deployed by acs730 user</h1>" | sudo tee /var/www/html/index.html
sudo systemctl start httpd
curl -s localhost | head -3
