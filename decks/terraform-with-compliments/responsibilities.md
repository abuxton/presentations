.left-column-50[

# Responsibilities

* Build or source?
* Deploy or configure?
* Redeploy or reconfigure?
* Change management?
* Drift detection or monitoring?

]
.right-column-50[
```hcl
resource "aws_instance" "my-instance" {
...
user_data = << EOF
	#! /bin/bash
	sudo apt-get update
	sudo apt-get install -y apache2
	sudo systemctl start apache2
	sudo systemctl enable apache2
	echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
EOF
tags = {
	Owner = "Terraform"
}
}
```

]
.footer[

]

???

-
