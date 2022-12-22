# AMI Details:
# version: 2.8.5
# arch: 64-bit (x86)
resource "aws_instance" "openvpn" {
  ami           = "ami-0764964fdfe99bc31"
  instance_type = "t2.micro"

  subnet_id = var.subnet_id

  vpc_security_group_ids = [aws_security_group.main.id]
  key_name               = var.key_name

  tags = {
    Name   = "OpenVPN"
    module = "openvpn"
  }
}

resource "aws_eip" "eip" {
  vpc      = true
  instance = aws_instance.openvpn.id

  tags = {
    Name = "OpenVPN"
  }
}

resource "aws_route53_record" "record" {
  zone_id = var.route53_zone_id

  name = var.route53_record_name
  type = "A"
  ttl  = 3600

  records = [aws_eip.eip.public_ip]
}
