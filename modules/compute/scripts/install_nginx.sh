#!/bin/bash
set -e

dnf install -y nginx
systemctl enable nginx
systemctl start nginx

cat > /usr/share/nginx/html/index.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Terraform AWS Infrastructure</title>
</head>
<body>
    <h1>Terraform AWS Infrastructure</h1>
    <p>Nginx installed successfully using EC2 automation.</p>
</body>
</html>
EOF