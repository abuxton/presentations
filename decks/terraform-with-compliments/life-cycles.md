.left-column-50[

# Terraform concepts

* Lifecycle managment
* State management
  * `state rm`
  * `terraform --target`
* Sentinel `on_change` policies

]
.right-column-50[

```hcl
resource "aws_instance" "example" {
  # ...

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}
```

]
.footer[
> Which ever tool as responsibility, you need to know how to remove that responsibility from the others NOT just Terraform
]

???

* Puppet, Ansible, Chef (dry-run enforcement)
* platform specific tools
