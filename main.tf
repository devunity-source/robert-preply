########################################
# main.tf — EC2 instance with HTTP access
########################################

provider "aws" {
  region = var.region
}

# Security Group for HTTP
resource "aws_security_group" "http_sg" {
  name        = "${var.name}-sg"
  description = "Allow inbound HTTP traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-sg"
  }
}

# EC2 Instance
resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.http_sg.id]
  key_name               = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              # Update system packages
              yum update -y
              
              # Install Apache web server
              yum install -y httpd
              
              # Create a simple HTML page
              cat > /var/www/html/index.html <<'HTML'
              <!DOCTYPE html>
              <html>
              <head>
                  <title>Hello World</title>
                  <style>
                      body {
                          font-family: Arial, sans-serif;
                          display: flex;
                          justify-content: center;
                          align-items: center;
                          height: 100vh;
                          margin: 0;
                          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                          color: white;
                      }
                      .container {
                          text-align: center;
                          padding: 50px;
                          background: rgba(255, 255, 255, 0.1);
                          border-radius: 20px;
                          box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
                      }
                      h1 {
                          font-size: 72px;
                          margin: 0;
                          text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
                      }
                  </style>
              </head>
              <body>
                  <div class="container">
                      <h1>Hello World</h1>
                  </div>
              </body>
              </html>
              HTML
              
              # Start Apache and enable it to start on boot
              systemctl start httpd
              systemctl enable httpd
              EOF

  tags = {
    Name = var.name
  }
}
