output "socat-ips" {
  description = "IP Addresses of SOCAT redirectors"
  value       =join(",", aws_instance.MH-SOCAT-RDR[*].public_ip)
}

output "c2-ip" {
  description = "IP Addresses of Command & Control Server"
  value       = aws_instance.MH-C2-SERVER.public_ip
}
