module "s3" {
  source                 = "./modules/s3"
  bucket_name            = "${var.project_prefix}-bucket"
}