#variables for config in terraform must be added to gitignore file. 
variable "AWS_ACCESS_KEY"{}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "us-east-1"
}
variable "AMIS" {
  type ="map"
  default = {
      us-east-1 = ""
      us-east-2 = ""
      us-west-1 = ""
  }
}