#!/bin/bash

echo "======================================="
echo "RHEL Image Mode Demo Verification"
echo "======================================="

# Get demo VM IP
DEMO_IP=$(az vm list-ip-addresses -g imagemode-demo -n demo --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" -o tsv)

if [ -z "$DEMO_IP" ]; then
    echo "❌ Could not find demo VM IP"
    exit 1
fi

echo "Demo VM IP: $DEMO_IP"
echo ""

echo "Testing Image Mode features..."
echo ""

# Test 1: Immutable filesystem
echo "1. Testing filesystem immutability:"
ssh -i ~/.ssh/demo-key -o StrictHostKeyChecking=no core@$DEMO_IP 'sudo touch /opt/test.txt 2>&1' | grep -q "Read-only file system"
if [ $? -eq 0 ]; then
    echo "   ✅ PASS - Filesystem is immutable"
else
    echo "   ❌ FAIL - Filesystem is writable"
fi

# Test 2: bootc status
echo ""
echo "2. Checking bootc status:"
ssh -i ~/.ssh/demo-key -o StrictHostKeyChecking=no core@$DEMO_IP 'sudo bootc status' > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "   ✅ PASS - bootc is working"
else
    echo "   ❌ FAIL - bootc not responding"
fi

# Test 3: MSSQL service
echo ""
echo "3. Checking MSSQL Server:"
ssh -i ~/.ssh/demo-key -o StrictHostKeyChecking=no core@$DEMO_IP 'sudo systemctl is-active mssql-server' | grep -q "active"
if [ $? -eq 0 ]; then
    echo "   ✅ PASS - MSSQL Server is running"
else
    echo "   ❌ FAIL - MSSQL Server not running"
fi

echo ""
echo "======================================="
echo "Demo verification complete!"
echo "======================================="
echo ""
echo "To connect to demo VM:"
echo "ssh -i ~/.ssh/demo-key core@$DEMO_IP"