# 🔥 Misery 🔥
Author: LOLASL/zledge

Flag: `EPT{gCm_with0ut_t4g_1s_ju5t_CtR_c0unt1ng_from_2}`
## Description
```
Disaster! Our most important files have been stolen and are locked with what appears to be military grade encryption. We paid the ransom, but it turns out the criminal punks got the wrong type of crypto-bro for their scheme so they are unable to restore anything. Our IR-team managed to collect some artifacts with KAPE, but have no idea what to do next. Gather your most elite squad of forensicators and cryptographers to get our data back.
```

## Provided challenge files
* [misery.zip](misery.zip)


## Writeup
While having a peek at the provided 2023-09-06T082701_asl.vhdx, we found an unintended solution.
Basically, we're able to extract the unencrypted flag.txt with bulk_extractor;

```bash
bulk_extractor -o DUMP 2023-09-06T082701_asl.vhdx; grep -R "EPT{"
```

Which gives us EPT{gCm_with0ut_t4g_1s_ju5t_CtR_c0unt1ng_from_2}

