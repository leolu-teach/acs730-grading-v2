# Test Results: submissions/test-student-partial

_Generated 2026-09-05T09:56:54Z by run-tests.sh. This is a mechanical PASS/FAIL report, not a grade._

## lab1
- ✅ **PASS** -- bash -n syntax check (lab1/scripts/create-security-group.sh)
- ✅ **PASS** -- bash -n syntax check (lab1/scripts/create-instance.sh)

## lab2
- ✅ **PASS** -- bash -n syntax check (lab2/scripts/deploy-web.sh)

## lab3
- ❌ **FAIL** -- terraform validate (lab3)
  <details><summary>output</summary>

  ```
  [0m[1mInitializing provider plugins...[0m
  - Finding hashicorp/aws versions matching "~> 5.0"...
  - Installing hashicorp/aws v5.100.0...
  - Installed hashicorp/aws v5.100.0 (signed by HashiCorp)
  Terraform has created a lock file [1m.terraform.lock.hcl[0m to record the provider
  selections it made above. Include this file in your version control repository
  so that Terraform can guarantee to make the same selections by default when
  you run "terraform init" in the future.[0m
  
  [0m[1m[32mTerraform has been successfully initialized![0m[32m[0m
  [0m[32m
  You may now begin working with Terraform. Try running "terraform plan" to see
  any changes that are required for your infrastructure. All Terraform commands
  should now work.
  
  If you ever set or change modules or backend configuration for Terraform,
  rerun this command to reinitialize your working directory. If you forget, other
  commands will detect it and remind you to do so if necessary.[0m
  [31m╷[0m[0m
  [31m│[0m [0m[1m[31mError: [0m[0m[1mReference to undeclared input variable[0m
  [31m│[0m [0m
  [31m│[0m [0m[0m  on main.tf line 32, in resource "aws_instance" "demo":
  [31m│[0m [0m  32:   instance_type = [4mvar.instance_type[0m[0m
  [31m│[0m [0m
  [31m│[0m [0mAn input variable with the name "instance_type" has not been declared. This
  [31m│[0m [0mvariable can be declared with a variable "instance_type" {} block.
  [31m╵[0m[0m
  ::error::Terraform exited with code 1.
  ```
  </details>
- ℹ️ **FINDINGS** (tfsec scan (lab3), exit 1 -- review, does not auto-fail)
  <details><summary>output</summary>

  ```
  [0m[0m
    [2mMore Information[0m[0m[0m
    [2m-[0m [34mhttps://aquasecurity.github.io/tfsec/v1.28.14/checks/aws/ec2/enable-at-rest-encryption/[0m[0m
    [2m-[0m [34mhttps://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#ebs-ephemeral-and-root-block-devices[0m[0m
  [90m────────────────────────────────────────────────────────────────────────────────[39m
  
  
  [0m[0m[3mResult #4[0m [0m[97mLOW[39m[0m [1mSecurity group rule does not have a description.[0m [2m[0m
  [0m[0m[90m────────────────────────────────────────────────────────────────────────────────
  [0m[0m  [3mmain.tf[2m[3m:19-24
  [0m[0m[90m────────────────────────────────────────────────────────────────────────────────[39m
  [0m[0m[90m   15  [0m[0m  [38;5;33mresource[0m [38;5;37m"aws_security_group"[0m [38;5;37m"lab3_demo"[0m {[0m
  [0m[90m   16  [0m[0m    [38;5;245mname[0m        = [38;5;37m"acs730-lab3-demo"[0m
  [0m[90m   17  [0m[0m  [0m  [38;5;245mdescription[0m = [38;5;37m"Created by Terraform in Lab 3"[0m
  [0m[90m   18  [0m[0m  [0m[0m
  [0m[31m   19  [0m[0m[31m┌[39m[0m[0m   ingress {[0m
  [0m[31m   20  [0m[0m[31m│[39m[0m[0m     [38;5;245mfrom_port[0m   = [38;5;37m22[0m
  [0m[31m   21  [0m[0m[31m│[39m[0m[0m [0m    [38;5;245mto_port[0m     = [38;5;37m22[0m
  [0m[31m   22  [0m[0m[31m│[39m[0m[0m [0m    [38;5;245mprotocol[0m    = [38;5;37m"tcp"[0m
  [0m[31m   23  [0m[0m[31m└[39m[0m[0m [0m    [38;5;245mcidr_blocks[0m = [[38;5;37m"0.0.0.0/0"[0m][0m
  [0m[90m   ..  [0m
  [0m[90m────────────────────────────────────────────────────────────────────────────────[39m
  [0m[0m  [2m        ID[0m[3m aws-ec2-add-description-to-security-group-rule
  [0m[0m  [2m    Impact[0m Descriptions provide context for the firewall rule reasons
  [0m[0m  [2mResolution[0m Add descriptions for all security groups rules
  [0m[0m
    [2mMore Information[0m[0m[0m
    [2m-[0m [34mhttps://aquasecurity.github.io/tfsec/v1.28.14/checks/aws/ec2/add-description-to-security-group-rule/[0m[0m
    [2m-[0m [34mhttps://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group[0m[0m
    [2m-[0m [34mhttps://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule[0m[0m
  [90m────────────────────────────────────────────────────────────────────────────────[39m
  
  
  [0m[0m  [1mtimings[0m
    ──────────────────────────────────────────
  [0m[0m  [2mdisk i/o            [0m 15.299µs
  [0m[0m  [2mparsing             [0m 208.079µs
  [0m[0m  [2madaptation          [0m 89.717µs
  [0m[0m  [2mchecks              [0m 3.165781ms
  [0m[0m  [2mtotal               [0m 3.478876ms
  [0m
  [0m  [1mcounts[0m
    ──────────────────────────────────────────
  [0m[0m  [2mmodules downloaded  [0m 0
  [0m[0m  [2mmodules processed   [0m 1
  [0m[0m  [2mblocks processed    [0m 4
  [0m[0m  [2mfiles read          [0m 1
  [0m
  [0m  [1mresults[0m
    ──────────────────────────────────────────
  [0m[0m  [2mpassed              [0m 2
  [0m[0m  [2mignored             [0m 0
  [0m[0m  [2mcritical            [0m 1
  [0m[0m  [2mhigh                [0m 2
  [0m[0m  [2mmedium              [0m 0
  [0m[0m  [2mlow                 [0m 1
  [0m
  [0m  [31m[1m2 passed, 4 potential problem(s) detected.
  
  [0m  ```
  </details>

## lab4
- ✅ **PASS** -- docker build (lab4/Dockerfile)

## lab5
- ⚪ **EMPTY** -- no submitted files found

## lab6
- ✅ **PASS** -- ansible-playbook --syntax-check (lab6/ansible/playbook.yml)
- ❌ **FAIL** -- packer validate (lab6/packer/web.pkr.hcl)
  <details><summary>output</summary>

  ```
  Error: Unsupported attribute
  
    on lab6/packer/web.pkr.hcl line 12:
    (source code not available)
  
  This object does not have an attribute named "instance_type".
  
  
  ```
  </details>

## lab7
- ✅ **PASS** -- terraform validate (lab7)
- ❌ **FAIL** -- tfsec scan (lab7), no HIGH/CRITICAL findings (required for this lab)
  <details><summary>output</summary>

  ```
  [0m[31m   27  [0m[0m[31m[[39m[0m[0m [0m  [38;5;245mrestrict_public_buckets[0m = [38;5;166mfalse[0m[0m [3m[2m[3m(false)[0m
  [0m[90m   28  [0m[0m  [0m}[0m
  [0m[90m────────────────────────────────────────────────────────────────────────────────[39m
  [0m[0m  [2m        ID[0m[3m aws-s3-no-public-buckets
  [0m[0m  [2m    Impact[0m Public buckets can be accessed by anyone
  [0m[0m  [2mResolution[0m Limit the access to public buckets to only the owner or AWS Services (eg; CloudFront)
  [0m[0m
    [2mMore Information[0m[0m[0m
    [2m-[0m [34mhttps://aquasecurity.github.io/tfsec/v1.28.14/checks/aws/s3/no-public-buckets/[0m[0m
    [2m-[0m [34mhttps://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block#restrict_public_buckets¡[0m[0m
  [90m────────────────────────────────────────────────────────────────────────────────[39m
  
  
  [0m[0m  [1mtimings[0m
    ──────────────────────────────────────────
  [0m[0m  [2mdisk i/o            [0m 17.272µs
  [0m[0m  [2mparsing             [0m 226.161µs
  [0m[0m  [2madaptation          [0m 99.285µs
  [0m[0m  [2mchecks              [0m 3.045524ms
  [0m[0m  [2mtotal               [0m 3.388242ms
  [0m
  [0m  [1mcounts[0m
    ──────────────────────────────────────────
  [0m[0m  [2mmodules downloaded  [0m 0
  [0m[0m  [2mmodules processed   [0m 1
  [0m[0m  [2mblocks processed    [0m 4
  [0m[0m  [2mfiles read          [0m 1
  [0m
  [0m  [1mresults[0m
    ──────────────────────────────────────────
  [0m[0m  [2mpassed              [0m 1
  [0m[0m  [2mignored             [0m 3
  [0m[0m  [2mcritical            [0m 0
  [0m[0m  [2mhigh                [0m 6
  [0m[0m  [2mmedium              [0m 0
  [0m[0m  [2mlow                 [0m 0
  [0m
  [0m  [31m[1m1 passed, 3 ignored, 6 potential problem(s) detected.
  
  [0m  ```
  </details>

## lab8
- ✅ **PASS** -- kubeconform schema validation (lab8/k8s/deployment.yaml)
- ✅ **PASS** -- kubeconform schema validation (lab8/k8s/service.yaml)
- ❌ **FAIL** -- kubeconform schema validation (lab8/k8s/hpa.yaml)
  <details><summary>output</summary>

  ```
  lab8/k8s/hpa.yaml - HorizontalPodAutoscaler acs730-web failed validation: could not find schema for HorizontalPodAutoscaler
  Summary: 1 resource found in 1 file - Valid: 0, Invalid: 0, Errors: 1, Skipped: 0
  ```
  </details>

## assignment1
- ✅ **PASS** -- terraform validate (assignment1/terraform/dev)
- ℹ️ **FINDINGS** (tfsec scan (assignment1/terraform/dev), exit 1 -- review, does not auto-fail)
  <details><summary>output</summary>

  ```
  [0m[0m
    [2mMore Information[0m[0m[0m
    [2m-[0m [34mhttps://aquasecurity.github.io/tfsec/v1.28.14/checks/aws/ec2/no-public-ingress-sgr/[0m[0m
    [2m-[0m [34mhttps://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule#cidr_blocks[0m[0m
  [90m────────────────────────────────────────────────────────────────────────────────[39m
  
  
  [0m[0m[3mResult #2[0m [0m[97mLOW[39m[0m [1mSecurity group rule does not have a description.[0m [2m[0m
  [0m[0m[90m────────────────────────────────────────────────────────────────────────────────
  [0m[0m  [3mmain.tf[3m[2m:19-24
  [0m[0m[90m────────────────────────────────────────────────────────────────────────────────[39m
  [0m[0m[90m   15  [0m[0m  [38;5;33mresource[0m [38;5;37m"aws_security_group"[0m [38;5;37m"dev_web"[0m {[0m
  [0m[90m   16  [0m[0m    [38;5;245mname[0m        = [38;5;37m"acs730-assignment1-dev-web"[0m
  [0m[90m   17  [0m[0m  [0m  [38;5;245mdescription[0m = [38;5;37m"Dev web security group (assignment 1, not yet modularized)"[0m
  [0m[90m   18  [0m[0m  [0m[0m
  [0m[31m   19  [0m[0m[31m┌[39m[0m[0m   ingress {[0m
  [0m[31m   20  [0m[0m[31m│[39m[0m[0m     [38;5;245mfrom_port[0m   = [38;5;37m80[0m
  [0m[31m   21  [0m[0m[31m│[39m[0m[0m [0m    [38;5;245mto_port[0m     = [38;5;37m80[0m
  [0m[31m   22  [0m[0m[31m│[39m[0m[0m [0m    [38;5;245mprotocol[0m    = [38;5;37m"tcp"[0m
  [0m[31m   23  [0m[0m[31m└[39m[0m[0m [0m    [38;5;245mcidr_blocks[0m = [[38;5;37m"0.0.0.0/0"[0m][0m
  [0m[90m   ..  [0m
  [0m[90m────────────────────────────────────────────────────────────────────────────────[39m
  [0m[0m  [2m        ID[0m[3m aws-ec2-add-description-to-security-group-rule
  [0m[0m  [2m    Impact[0m Descriptions provide context for the firewall rule reasons
  [0m[0m  [2mResolution[0m Add descriptions for all security groups rules
  [0m[0m
    [2mMore Information[0m[0m[0m
    [2m-[0m [34mhttps://aquasecurity.github.io/tfsec/v1.28.14/checks/aws/ec2/add-description-to-security-group-rule/[0m[0m
    [2m-[0m [34mhttps://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group[0m[0m
    [2m-[0m [34mhttps://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule[0m[0m
  [90m────────────────────────────────────────────────────────────────────────────────[39m
  
  
  [0m[0m  [1mtimings[0m
    ──────────────────────────────────────────
  [0m[0m  [2mdisk i/o            [0m 13.285µs
  [0m[0m  [2mparsing             [0m 335.024µs
  [0m[0m  [2madaptation          [0m 158.135µs
  [0m[0m  [2mchecks              [0m 8.153388ms
  [0m[0m  [2mtotal               [0m 8.659832ms
  [0m
  [0m  [1mcounts[0m
    ──────────────────────────────────────────
  [0m[0m  [2mmodules downloaded  [0m 0
  [0m[0m  [2mmodules processed   [0m 1
  [0m[0m  [2mblocks processed    [0m 3
  [0m[0m  [2mfiles read          [0m 1
  [0m
  [0m  [1mresults[0m
    ──────────────────────────────────────────
  [0m[0m  [2mpassed              [0m 1
  [0m[0m  [2mignored             [0m 0
  [0m[0m  [2mcritical            [0m 1
  [0m[0m  [2mhigh                [0m 0
  [0m[0m  [2mmedium              [0m 0
  [0m[0m  [2mlow                 [0m 1
  [0m
  [0m  [31m[1m1 passed, 2 potential problem(s) detected.
  
  [0m  ```
  </details>

## assignment2
- ✅ **PASS** -- ansible-playbook --syntax-check (assignment2/ansible/playbook.yml)
- ✅ **PASS** -- YAML syntax check (inventory: assignment2/ansible/inventory/aws_ec2.yml)

## midterm-practice
- ⚪ **EMPTY** -- no submitted files found

## final-practice
- ⚪ **EMPTY** -- no submitted files found

## final-project
- ✅ **PASS** -- terraform validate (final-project/terraform/dev)
- ℹ️ **FINDINGS** (tfsec scan (final-project/terraform/dev), exit 1 -- review, does not auto-fail)
  <details><summary>output</summary>

  ```
  [0m[0m
    [2mMore Information[0m[0m[0m
    [2m-[0m [34mhttps://aquasecurity.github.io/tfsec/v1.28.14/checks/aws/ec2/no-public-ingress-sgr/[0m[0m
    [2m-[0m [34mhttps://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule#cidr_blocks[0m[0m
  [90m────────────────────────────────────────────────────────────────────────────────[39m
  
  
  [0m[0m[3mResult #2[0m [0m[97mLOW[39m[0m [1mSecurity group rule does not have a description.[0m [2m[0m
  [0m[0m[90m────────────────────────────────────────────────────────────────────────────────
  [0m[0m  [3mmain.tf[2m[3m:19-24
  [0m[0m[90m────────────────────────────────────────────────────────────────────────────────[39m
  [0m[0m[90m   15  [0m[0m  [38;5;33mresource[0m [38;5;37m"aws_security_group"[0m [38;5;37m"final_project_dev"[0m {[0m
  [0m[90m   16  [0m[0m    [38;5;245mname[0m        = [38;5;37m"acs730-final-project-dev"[0m
  [0m[90m   17  [0m[0m  [0m  [38;5;245mdescription[0m = [38;5;37m"Dev security group for the final project API service"[0m
  [0m[90m   18  [0m[0m  [0m[0m
  [0m[31m   19  [0m[0m[31m┌[39m[0m[0m   ingress {[0m
  [0m[31m   20  [0m[0m[31m│[39m[0m[0m     [38;5;245mfrom_port[0m   = [38;5;37m80[0m
  [0m[31m   21  [0m[0m[31m│[39m[0m[0m [0m    [38;5;245mto_port[0m     = [38;5;37m80[0m
  [0m[31m   22  [0m[0m[31m│[39m[0m[0m [0m    [38;5;245mprotocol[0m    = [38;5;37m"tcp"[0m
  [0m[31m   23  [0m[0m[31m└[39m[0m[0m [0m    [38;5;245mcidr_blocks[0m = [[38;5;37m"0.0.0.0/0"[0m][0m
  [0m[90m   ..  [0m
  [0m[90m────────────────────────────────────────────────────────────────────────────────[39m
  [0m[0m  [2m        ID[0m[3m aws-ec2-add-description-to-security-group-rule
  [0m[0m  [2m    Impact[0m Descriptions provide context for the firewall rule reasons
  [0m[0m  [2mResolution[0m Add descriptions for all security groups rules
  [0m[0m
    [2mMore Information[0m[0m[0m
    [2m-[0m [34mhttps://aquasecurity.github.io/tfsec/v1.28.14/checks/aws/ec2/add-description-to-security-group-rule/[0m[0m
    [2m-[0m [34mhttps://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group[0m[0m
    [2m-[0m [34mhttps://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule[0m[0m
  [90m────────────────────────────────────────────────────────────────────────────────[39m
  
  
  [0m[0m  [1mtimings[0m
    ──────────────────────────────────────────
  [0m[0m  [2mdisk i/o            [0m 13.806µs
  [0m[0m  [2mparsing             [0m 156.702µs
  [0m[0m  [2madaptation          [0m 95.799µs
  [0m[0m  [2mchecks              [0m 3.051847ms
  [0m[0m  [2mtotal               [0m 3.318154ms
  [0m
  [0m  [1mcounts[0m
    ──────────────────────────────────────────
  [0m[0m  [2mmodules downloaded  [0m 0
  [0m[0m  [2mmodules processed   [0m 1
  [0m[0m  [2mblocks processed    [0m 3
  [0m[0m  [2mfiles read          [0m 1
  [0m
  [0m  [1mresults[0m
    ──────────────────────────────────────────
  [0m[0m  [2mpassed              [0m 1
  [0m[0m  [2mignored             [0m 0
  [0m[0m  [2mcritical            [0m 1
  [0m[0m  [2mhigh                [0m 0
  [0m[0m  [2mmedium              [0m 0
  [0m[0m  [2mlow                 [0m 1
  [0m
  [0m  [31m[1m1 passed, 2 potential problem(s) detected.
  
  [0m  ```
  </details>
- ✅ **PASS** -- ansible-playbook --syntax-check (final-project/ansible/playbook.yml)
- ✅ **PASS** -- kubeconform schema validation (final-project/k8s/deployment.yaml)
- ✅ **PASS** -- kubeconform schema validation (final-project/k8s/service.yaml)

## Repository-wide hygiene
- ✅ **PASS** -- no `.tfstate`/`.pem`/`credentials` files found anywhere in git history
