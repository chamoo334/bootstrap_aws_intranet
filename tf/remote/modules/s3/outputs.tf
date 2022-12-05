output "s3_info" {
    value = {
        name = aws_s3_bucket.project_backend.id
        arn = aws_s3_bucket.project_backend.arn
        region = aws_s3_bucket.project_backend.region
    }
}