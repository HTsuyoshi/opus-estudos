# Route 53: Create endpoints

data "aws_route53_zone" "intheshell" {
  name         = "intheshell.page."
  private_zone = false
}

resource "aws_route53_record" "ctfssi_2021" {
  zone_id = data.aws_route53_zone.intheshell.zone_id
  name    = "ctfssi-2021.intheshell.page"
  type    = "A"
  ttl     = "300"
  records = [
    "${var.ctfssi_2021_a_public_ip}",
  ]
}

resource "aws_route53_record" "ctfssi_2022" {
  zone_id = data.aws_route53_zone.intheshell.zone_id
  name    = "ctfssi-2022.intheshell.page"
  type    = "A"
  ttl     = "300"
  records = [
    "${var.ctfssi_2022_a_public_ip}",
  ]
}

resource "aws_route53_record" "ctfssi_2023" {
  zone_id = data.aws_route53_zone.intheshell.zone_id
  name    = "ctfssi-2023.intheshell.page"
  type    = "A"
  ttl     = "300"
  records = [
    "${var.ctfssi_2023_a_public_ip}",
  ]
}

resource "aws_route53_record" "challs_2021" {
  zone_id = data.aws_route53_zone.intheshell.zone_id
  name    = "uccdi.challs-2021.intheshell.page"
  type    = "A"
  ttl     = "300"
  records = [
    "${var.challs_2021_a_public_ip}",
  ]
}

resource "aws_route53_record" "challs_2022" {
  zone_id = data.aws_route53_zone.intheshell.zone_id
  name    = "uccdi.challs-2022.intheshell.page"
  type    = "A"
  ttl     = "300"
  records = [
    "${var.challs_2022_a_public_ip}",
  ]
}

# Chall 2023 Load balancer record

resource "aws_route53_record" "challs_2023" {
  zone_id = data.aws_route53_zone.intheshell.zone_id
  name    = "uccdi.challs-2023.intheshell.page"
  type    = "CNAME"
  ttl     = "60"
  records = [var.challs_2023_dns_name]

  #alias {
  #  name                   = var.challs_2023_dns_name
  #  zone_id                = var.challs_2023_zone_id
  #  evaluate_target_health = true
  #}
}
