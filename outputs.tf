output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "jenkins_instance_id" {
  value = aws_instance.jenkins_instance.id
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins_instance.public_ip
}

output "jenkins_url" {
  value = "http://${aws_instance.jenkins_instance.public_ip}:8080"
}
