resource "aws_security_group" "security_group" {
  name = "${var.environment}-${var.role}-SecurityGroup"

  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
  }

  vpc_id = "${var.vpc_id}"
  description = "${var.description}"

  tags {
    Name = "${var.environment}-${var.role}-SecurityGroup"
    Role = "${var.role}"
    Environment = "${var.environment}"
  }
}
