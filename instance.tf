#instance configure file 
resource "aws_instance" "vault" {
    ami = "$lookup{var.AWS_REGION}"
    instance_type = "t2.micro" #check this for size of vault requirements 
    # root storage block 
    root_block_device {
      volume_size = 8
      volume_type = "gp2"
      delete_on_termination =true # whether to delete the root block device when the instance gets terminated or not 
    }
# the VPC subnet
subnet_id = "${aws_subnet.main-public-1.id}"

# the securityy group 
vpc_security_group_ids = [ "${aws_security_group.allow-ssh.id}" ]

# the public SSH key
key_name = "${aws_key_pair.mykeypair.key_name}" #refactor before launch 
}

# ebs volume config
resource "aws_ebs_volume" "ebs-volume-1" {
    availability_zone = "us-east-1a"
    size = 20 # numeric in GB 
    type = "gp2" #general Purpose Storage, can also be standard or io1 or st1 
    tags {
        Name = " extra voluma data"
        Meta = "$lookup{var.tag_template}" 
    }
}
  
resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name ="/mnt/extra20" # named filesystem 
  volume_id = "${aws_ebs_volume.ebs-volume-1.id}"
  instance_id = "${aws_instance.vault.id}"
  delete_on_termination = false # whether to delete the extra block storage  when the instance gets terminated or not 
}

#userdata is only run at launch, it does not work on reboot /restart 
#user_data can be any script from host os aka #!/bin/bash (linux) 
#user_data = "${variable}" < can be much more descriptive requires .tf template pointing to script file 