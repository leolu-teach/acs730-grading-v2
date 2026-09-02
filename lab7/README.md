# Lab 7 - Security and Policy-as-Code

Step 1 done: reproduced an insecure S3 bucket (no encryption, public access block disabled) so the
required `tfsec` check has a real HIGH/CRITICAL finding to catch. Confirmed the pipeline blocks this.

TODO (not done yet): fix the bucket (enable encryption, re-enable the public access block) and
replace `PowerUserAccess` on the deploy role with a scoped-down policy.
