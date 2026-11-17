variable "ec2_instance_type" {
  default = "t2.micro"
  type    = string
}

variable "ec2_default_root_block_device" {
  default = 20
  type    = number

}

variable "ec2_ami" {
  default = "ami-0cb91c7de36eed2cb"
  type    = string

}


variable "env" {
  default = "prod"
  type    = string

}