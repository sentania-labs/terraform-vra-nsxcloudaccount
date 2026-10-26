mock_provider "vra" {}

variables {
  name     = "nsx-manager-01"
  hostname = "nsxmgr01.example.com"
  username = "svc-nsx"
  password = "mock-password-value"
}

run "tls_verification_enforced_by_default" {
  command = plan

  assert {
    condition     = vra_cloud_account_nsxt.this.accept_self_signed_cert == false
    error_message = "accept_self_signed_cert must default to false."
  }
}

run "tls_self_signed_accepted_when_opted_in" {
  command = plan

  variables {
    accept_self_signed_cert = true
  }

  assert {
    condition     = vra_cloud_account_nsxt.this.accept_self_signed_cert == true
    error_message = "accept_self_signed_cert = true must reach the resource."
  }
}

run "capability_tags_are_applied" {
  command = plan

  variables {
    capability_tags = [
      { key = "cloud", value = "nsx" },
      { key = "region", value = "us" },
      { key = "region", value = "eu" },
    ]
  }

  assert {
    condition     = length(vra_cloud_account_nsxt.this.tags) == 3
    error_message = "All capability tags, including same-key pairs, must be applied."
  }
}

run "empty_tag_key_rejected" {
  command = plan

  variables {
    capability_tags = [{ key = "", value = "nsx" }]
  }

  expect_failures = [var.capability_tags]
}

run "hostname_with_scheme_rejected" {
  command = plan

  variables {
    hostname = "https://nsxmgr01.example.com"
  }

  expect_failures = [var.hostname]
}

run "hostname_with_port_rejected" {
  command = plan

  variables {
    hostname = "nsxmgr01.example.com:443"
  }

  expect_failures = [var.hostname]
}

run "hostname_ipv4_accepted" {
  command = plan

  variables {
    hostname = "192.0.2.10"
  }

  assert {
    condition     = vra_cloud_account_nsxt.this.hostname == "192.0.2.10"
    error_message = "An IPv4 address must be accepted as hostname."
  }
}

run "hostname_bare_ipv6_accepted" {
  command = plan

  variables {
    hostname = "2001:db8::10"
  }

  assert {
    condition     = vra_cloud_account_nsxt.this.hostname == "2001:db8::10"
    error_message = "A bare IPv6 literal must be accepted as hostname."
  }
}

run "hostname_bracketed_ipv6_accepted" {
  command = plan

  variables {
    hostname = "[2001:db8::10]"
  }

  assert {
    condition     = vra_cloud_account_nsxt.this.hostname == "[2001:db8::10]"
    error_message = "A bracketed IPv6 literal must be accepted as hostname."
  }
}

run "hostname_malformed_ipv6_rejected" {
  command = plan

  variables {
    hostname = "[2001:db8::10"
  }

  expect_failures = [var.hostname]
}

run "hostname_trailing_dot_fqdn_accepted" {
  command = plan

  variables {
    hostname = "nsxmgr01.example.com."
  }

  assert {
    condition     = vra_cloud_account_nsxt.this.hostname == "nsxmgr01.example.com."
    error_message = "A trailing-dot FQDN must be accepted as hostname."
  }
}

run "empty_credentials_rejected" {
  command = plan

  variables {
    username = ""
    password = ""
  }

  expect_failures = [var.username, var.password]
}

run "password_not_in_outputs" {
  command = apply

  assert {
    condition     = !strcontains(jsonencode(output.cloud_account), var.password)
    error_message = "The cloud_account output must not contain the password."
  }
}
