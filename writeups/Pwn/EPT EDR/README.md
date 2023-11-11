# EPT EDR
Author: nordbo

Flag: `EPT{0ur_3dr_1s_b3st_3dr}`
## Description
```
We are sick of wack EDR solutions, so we have created our very own EPT EDR for linux. The EDR will make sure that the target process only executes allowed syscalls. If it tries anything else, it will be killed.

There is also a DLP solution included that will stop any attemps of sensitive data exfil. 

For a proper test of the EDR, we are running the process_monitor from the procmon challenge. But this time its protected by our very own EPT EDR. Can you still get the flag?
```

## Provided challenge files
* [edr.tar.gz](edr.tar.gz)
