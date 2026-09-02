# Test Results: submissions/test-student-partial

_Generated 2026-09-02T02:32:44Z by run-tests.sh. This is a mechanical PASS/FAIL report, not a grade._

## lab1
- ✅ **PASS** -- bash -n syntax check (lab1/scripts/create-instance.sh)
- ✅ **PASS** -- bash -n syntax check (lab1/scripts/create-security-group.sh)

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
  [0m[0m  [2mdisk i/o            [0m 17.837µs
  [0m[0m  [2mparsing             [0m 211.649µs
  [0m[0m  [2madaptation          [0m 98.167µs
  [0m[0m  [2mchecks              [0m 2.55433ms
  [0m[0m  [2mtotal               [0m 2.881983ms
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
- ⚪ **EMPTY** -- no submitted files found

## lab5
- ⚪ **EMPTY** -- no submitted files found

## lab6
- ⚪ **EMPTY** -- no submitted files found

## lab7
- ⚪ **EMPTY** -- no submitted files found

## lab8
- ⚪ **EMPTY** -- no submitted files found

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
  [0m[0m  [3mmain.tf[2m[3m:19-24
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
  [0m[0m  [2mdisk i/o            [0m 17.025µs
  [0m[0m  [2mparsing             [0m 166.901µs
  [0m[0m  [2madaptation          [0m 95.273µs
  [0m[0m  [2mchecks              [0m 2.652577ms
  [0m[0m  [2mtotal               [0m 2.931776ms
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
- ⚪ **EMPTY** -- no submitted files found

## midterm-practice
- ⚪ **EMPTY** -- no submitted files found

## final-practice
- ⚪ **EMPTY** -- no submitted files found

## final-project
- ⚪ **EMPTY** -- no submitted files found

## Repository-wide hygiene
- ✅ **PASS** -- no `.tfstate`/`.pem`/`credentials` files found anywhere in git history
