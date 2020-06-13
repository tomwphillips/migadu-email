output "nameservers" {
  description = "Cloudflare nameservers"
  value       = cloudflare_zone.zone.name_servers
}
