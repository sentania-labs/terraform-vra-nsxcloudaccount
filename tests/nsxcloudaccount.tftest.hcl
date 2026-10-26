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
      { key = "env" },
    ]
  }

  assert {
    condition     = length(vra_cloud_account_nsxt.this.tags) == 2
    error_message = "Both capability tags must be applied."
  }
}

run "empty_tag_key_rejected" {
  command = plan

  variables {
    capability_tags = [{ key = "", value = "nsx" }]
  }

  expect_failures = [var.capability_tags]
}

run "duplicate_tag_keys_rejected" {
  command = plan

  variables {
    capability_tags = [{ key = "a", value = "1" }, { key = "a", value = "2" }]
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
