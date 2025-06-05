# RHEL Image Mode Demo - Simple Version

## What This Does
- Creates 2 VMs in Azure (builder + demo)
- Shows you the exact commands to run
- Converts one VM to RHEL Image Mode
- Demonstrates "repave not patch" approach

## Prerequisites
- Azure CLI logged in (`az login`)
- Ansible with azure collection (`pip install ansible[azure]`)
- Quay.io account (free at https://quay.io)

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

## What You'll Demonstrate

### Before Image Mode (Traditional)
- Package-based updates
- Configuration drift possible
- Individual system patching

### After Image Mode (Modern)
- Immutable operating system
- Consistent deployments
- "Repave not patch" strategy

## Key Demo Points

1. **Immutability**: Try `sudo touch /opt/test.txt` - it fails!
2. **Updates**: Change image, run `sudo bootc upgrade`, reboot
3. **Rollbacks**: Quick rollback to previous image if needed
4. **Scale**: Same image across thousands of systems

## Troubleshooting

**VM won't start**: Check Azure quotas in region
**SSH fails**: Wait 2-3 minutes after VM creation
**Quay.io push fails**: Verify repository exists and is public
**bootc fails**: Check container image name is correct

## Benefits for Customer

- **Security**: Read-only OS prevents tampering
- **Reliability**: Identical systems, no drift
- **Efficiency**: Update thousands of VMs simultaneously
- **Compliance**: Known-good configurations

## Files

- `demo.yml` - Creates infrastructure, shows commands
- `cleanup.yml` - Deletes everything
- `verify.sh` - Tests that Image Mode is working
- `README.md` - This file