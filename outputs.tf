output "eip_allocation" {
  value = "${aws_eip.bastion.public_ip}"
}
