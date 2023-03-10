#resource "aws_cloudfront_distribution" "ctfssi_2021_cf" {
#  origin {
#    domain_name = aws_instance.ctfssi_2021_a.public_dns
#    origin_id   = "ctfssi_2021"
#    custom_origin_config {
#      http_port   = 80
#      https_port  = 443
#      origin_ssl_protocols = [ "TLSv1.2" ]
#      origin_protocol_policy = "http-only"
#    }
#  }
#
#  enabled             = true
#  is_ipv6_enabled     = true
#
#  aliases = [
#    "ctfssi-2021.intheshell.page"
#  ]
#
#  default_cache_behavior {
#    allowed_methods  = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
#    cached_methods   = ["GET", "HEAD"]
#    target_origin_id = "ctfssi_2021"
#
#    forwarded_values {
#      query_string = false
#
#      cookies {
#        forward = "none"
#      }
#    }
#
#    viewer_protocol_policy = "redirect-to-https"
#    min_ttl                = 0
#    default_ttl            = 3600
#    max_ttl                = 86400
#  }
#
#  restrictions {
#    geo_restriction {
#      restriction_type = "none"
#    }
#  }
#
#  viewer_certificate {
#    acm_certificate_arn = data.aws_acm_certificate.intheshell_crt.arn
#    ssl_support_method   = "sni-only"
#    minimum_protocol_version = "TLSv1.2_2021"
#  }
#}
#
#resource "aws_cloudfront_distribution" "ctfssi_2022_cf" {
#  origin {
#    domain_name = aws_instance.ctfssi_2022_a.public_dns
#    origin_id   = "ctfssi_2022"
#    custom_origin_config {
#      http_port   = 80
#      https_port  = 443
#      origin_ssl_protocols = [ "TLSv1.2" ]
#      origin_protocol_policy = "http-only"
#    }
#  }
#
#  enabled             = true
#  is_ipv6_enabled     = true
#
#  aliases = [
#    "ctfssi-2022.intheshell.page"
#  ]
#
#  default_cache_behavior {
#    allowed_methods  = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
#    cached_methods   = ["GET", "HEAD"]
#    target_origin_id = "ctfssi_2022"
#
#    forwarded_values {
#      query_string = false
#
#      cookies {
#        forward = "none"
#      }
#    }
#
#    viewer_protocol_policy = "redirect-to-https"
#    min_ttl                = 0
#    default_ttl            = 3600
#    max_ttl                = 86400
#  }
#
#  restrictions {
#    geo_restriction {
#      restriction_type = "none"
#    }
#  }
#
#  viewer_certificate {
#    acm_certificate_arn = data.aws_acm_certificate.intheshell_crt.arn
#    ssl_support_method   = "sni-only"
#    minimum_protocol_version = "TLSv1.2_2021"
#  }
#}
#
#resource "aws_cloudfront_distribution" "ctfssi_2023_cf" {
#  origin {
#    domain_name = aws_instance.ctfssi_2023_a.public_dns
#    origin_id   = "ctfssi_2023"
#    custom_origin_config {
#      http_port   = 80
#      https_port  = 443
#      origin_ssl_protocols = [ "TLSv1.2" ]
#      origin_protocol_policy = "http-only"
#    }
#  }
#
#  enabled             = true
#  is_ipv6_enabled     = true
#
#  aliases = [
#    "ctfssi-2023.intheshell.page"
#  ]
#
#  default_cache_behavior {
#    allowed_methods  = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
#    cached_methods   = ["GET", "HEAD"]
#    target_origin_id = "ctfssi_2023"
#
#    forwarded_values {
#      query_string = false
#
#      cookies {
#        forward = "none"
#      }
#    }
#
#    viewer_protocol_policy = "redirect-to-https"
#    min_ttl                = 0
#    default_ttl            = 3600
#    max_ttl                = 86400
#  }
#
#  restrictions {
#    geo_restriction {
#      restriction_type = "none"
#    }
#  }
#
#  viewer_certificate {
#    acm_certificate_arn = data.aws_acm_certificate.intheshell_crt.arn
#    ssl_support_method   = "sni-only"
#    minimum_protocol_version = "TLSv1.2_2021"
#  }
#}
#
#resource "aws_route53_record" "ctfssi_2021" {
#  zone_id = data.aws_route53_zone.intheshell.zone_id
#  name    = "ctfssi-2021.intheshell.page"
#  type    = "A"
#
#  alias {
#    name                   = aws_cloudfront_distribution.ctfssi_2021_cf.domain_name
#    zone_id                = aws_cloudfront_distribution.ctfssi_2021_cf.hosted_zone_id
#    evaluate_target_health = true
#  }
#}
#
#resource "aws_route53_record" "ctfssi_2022" {
#  zone_id = data.aws_route53_zone.intheshell.zone_id
#  name    = "ctfssi-2022.intheshell.page"
#  type    = "A"
#
#  alias {
#    name                   = aws_cloudfront_distribution.ctfssi_2022_cf.domain_name
#    zone_id                = aws_cloudfront_distribution.ctfssi_2022_cf.hosted_zone_id
#    evaluate_target_health = true
#  }
#}
#
#resource "aws_route53_record" "ctfssi_2023" {
#  zone_id = data.aws_route53_zone.intheshell.zone_id
#  name    = "ctfssi-2023.intheshell.page"
#  type    = "A"
#
#  alias {
#    name                   = aws_cloudfront_distribution.ctfssi_2023_cf.domain_name
#    zone_id                = aws_cloudfront_distribution.ctfssi_2023_cf.hosted_zone_id
#    evaluate_target_health = true
#  }
#}