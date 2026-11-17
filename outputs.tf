#output for count

output "ec2_publi_ip" {
  value = aws_instance.my_instace[*].public_ip
}

output "ec2_publi_dns" {
  value = aws_instance.my_instace[*].public_dns
}

output "ec2_private_ip" {
  value = aws_instance.my_instace[*].private_ip
}

#output for For_each

# output "ec2_publi_ip" {
#     value = [
#         for  key in aws_instance.my_instace : key.public_ip
#     ]

# }

# output "ec2_publi_dns" {
#     value = [
#         for  key in aws_instance.my_instace : key.public_dns
#     ]

# }

# output "ec2_private_ip" {
#     value = [
#         for  key in aws_instance.my_instace : key.private_ip
#     ]

# }