resource "cloudflare_zone" "zone" {
  zone       = var.domain_name
  jump_start = true
}

resource "cloudflare_record" "verification" {
  zone_id = cloudflare_zone.zone.id
  type    = "TXT"
  name    = var.domain_name
  value   = var.migadu_verification_value
}

resource "cloudflare_record" "mx1" {
  zone_id  = cloudflare_zone.zone.id
  type     = "MX"
  name     = var.domain_name
  value    = "aspmx1.migadu.com"
  priority = 10
}

resource "cloudflare_record" "mx2" {
  zone_id  = cloudflare_zone.zone.id
  type     = "MX"
  name     = var.domain_name
  value    = "aspmx2.migadu.com"
  priority = 20
}

resource "cloudflare_record" "dkim_arc1" {
  zone_id = cloudflare_zone.zone.id
  type    = "CNAME"
  name    = "key1._domainkey.${var.domain_name}"
  value   = "key1.${var.domain_name}._domainkey.migadu.com"
}

resource "cloudflare_record" "dkim_arc2" {
  zone_id = cloudflare_zone.zone.id
  type    = "CNAME"
  name    = "key2._domainkey.${var.domain_name}"
  value   = "key2.${var.domain_name}._domainkey.migadu.com"
}

resource "cloudflare_record" "dkim_arc3" {
  zone_id = cloudflare_zone.zone.id
  type    = "CNAME"
  name    = "key3._domainkey.${var.domain_name}"
  value   = "key3.${var.domain_name}._domainkey.migadu.com"
}

resource "cloudflare_record" "dmarc" {
  zone_id = cloudflare_zone.zone.id
  type    = "TXT"
  name    = "_dmarc.${var.domain_name}"
  value   = "v=DMARC1; p=reject;"
}

resource "cloudflare_record" "spf" {
  zone_id = cloudflare_zone.zone.id
  type    = "TXT"
  name    = var.domain_name
  value   = "v=spf1 include:spf.migadu.com -all"
}

resource "cloudflare_record" "cname_autoconfig" {
  # Thunderbird autoconfig mechanism
  zone_id = cloudflare_zone.zone.id
  type    = "CNAME"
  name    = "autoconfig.${var.domain_name}"
  value   = "autoconfig.migadu.com"
}

resource "cloudflare_record" "cname_autodiscover" {
  # Outlook autodiscover mechanism
  zone_id = cloudflare_zone.zone.id
  type    = "CNAME"
  name    = "autodiscover.${var.domain_name}"
  value   = "autodiscover.migadu.com"
}

# SRV records for generic service discovery

resource "cloudflare_record" "srv_submissions" {
  zone_id = cloudflare_zone.zone.id
  type    = "SRV"
  name    = "_submissions._tcp.${var.domain_name}"
  data = {
    service  = "_submissions"
    proto    = "_tcp"
    name     = var.domain_name
    port     = 465
    priority = 0
    weight   = 1
    target   = "smtp.migadu.com"
  }
}

resource "cloudflare_record" "srv_imaps" {
  zone_id = cloudflare_zone.zone.id
  type    = "SRV"
  name    = "_imaps._tcp.${var.domain_name}"
  data = {
    service  = "_imaps"
    proto    = "_tcp"
    name     = var.domain_name
    port     = 993
    priority = 0
    weight   = 1
    target   = "imap.migadu.com"
  }
}

resource "cloudflare_record" "srv_pop3s" {
  zone_id = cloudflare_zone.zone.id
  type    = "SRV"
  name    = "_pop3s._tcp.${var.domain_name}"
  data = {
    service  = "_pop3s"
    proto    = "_tcp"
    name     = var.domain_name
    port     = 995
    priority = 0
    weight   = 1
    target   = "pop.migadu.com"
  }
}
