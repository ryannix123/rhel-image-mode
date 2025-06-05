# RHEL Image Mode Demo - "Repave Not Patch"

## Why Repave Instead of Patch?

Your infrastructure is probably stuck in the old way of doing things: logging into individual systems, running `yum update`, hoping nothing breaks, and dealing with configuration drift across your fleet. There's a better way.

### The Problem with Traditional Patching

**❌ Configuration Drift**: Every system becomes a unique snowflake over time  
**❌ Unpredictable Updates**: Patches can break applications unexpectedly  
**❌ Time Consuming**: Patching 1,000+ systems takes forever  
**❌ Security Gaps**: Systems get out of sync, some miss critical patches  
**❌ Rollback Complexity**: "Undo" is nearly impossible  

### The Power of "Repave Not Patch"

**✅ Immutable Infrastructure**: OS files can't be modified - period  
**✅ Atomic Updates**: Entire system replacement in one operation  
**✅ Instant Rollbacks**: Bad update? Rollback in minutes  
**✅ Zero Drift**: Every system runs identical, known-good images  
**✅ Massive Scale**: Update thousands of systems simultaneously  
**✅ Predictable Outcomes**: Test once, deploy everywhere with confidence  

### Real-World Impact

- **Netflix**: Uses immutable infrastructure to deploy 1000s of instances daily
- **Google**: ChromeOS updates entire OS atomically  
- **Your Competition**: Already moving to container-based OS management

## What This Demo Shows

- Creates 2 VMs in Azure (builder + demo)
- Converts traditional RHEL to immutable Image Mode
- Demonstrates atomic OS updates and rollbacks
- Shows enterprise-scale "repave not patch" strategy

## Prerequisites

- **Azure CLI** logged in (`az login`)
- **Ansible** with azure collection (`pip install ansible[azure]`)
- **Quay.io account** (free at https://quay.io)
- **15 minutes** for the full demo

## Quick Start

```bash
# 1. Run the demo
ansible-playbook demo.yml

# 2. Follow the manual steps shown in output

# 3. Verify it worked
chmod +x verify.sh
./verify.sh

# 4. Clean up
ansible-playbook cleanup.yml
```

## Key Demo Points for Your Customer

### 1. **Immutability in Action**
```bash
sudo touch /opt/test.txt
# Result: "Read-only file system" - OS can't be tampered with
```

### 2. **Atomic Updates**
```bash
sudo bootc upgrade    # Download new OS image
sudo reboot           # Switch to new image atomically
```

### 3. **Instant Rollbacks**
```bash
sudo bootc rollback   # Back to previous image in seconds
```

### 4. **Scale Demonstration**
- Same image deploys to 1 VM or 10,000 VMs
- Consistent behavior across entire fleet
- No more "works on my machine" problems

## Business Value Proposition

### **For Operations Teams:**
- **75% less time** spent on system maintenance
- **Zero configuration drift** across fleet
- **Instant recovery** from failed updates
- **Predictable compliance** with known-good images

### **For Security Teams:**
- **Immutable OS** prevents runtime tampering
- **Cryptographically signed** images
- **Rapid security patching** across entire fleet
- **Audit trail** of all system changes

### **For Business Leaders:**
- **Reduced downtime** from failed patches
- **Faster time to market** with reliable infrastructure
- **Lower operational costs** with automated updates
- **Improved compliance** with consistent configurations

## Troubleshooting

**VM won't start**: Check Azure quotas in region  
**SSH fails**: Wait 2-3 minutes after VM creation  
**Quay.io push fails**: Verify repository exists and is public  
**bootc fails**: Check container image name is correct  

## What Happens Next?

After this demo, your customer will want to:

1. **Pilot Program**: Start with non-critical workloads
2. **Image Pipeline**: Set up CI/CD for OS image builds  
3. **Fleet Management**: Use Red Hat Satellite for large-scale deployments
4. **Compliance Integration**: Embed security scanning in image builds

**Red Hat can help with all of these next steps.**

## Files

- `demo.yml` - Creates infrastructure, shows commands
- `cleanup.yml` - Deletes everything  
- `verify.sh` - Tests that Image Mode is working
- `README.md` - This file