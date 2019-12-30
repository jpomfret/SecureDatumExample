
$datum = New-DatumStructure -DefinitionFile .\DSC_ConfigData\Datum.yml

## save the sa password as a credential
$cred = get-credential

#Protect-Datum -InputObject $cred -Password (ConvertTo-SecureString -AsPlainText -force  'Password1234')
Protect-Datum -InputObject $cred.Password -Password (ConvertTo-SecureString -AsPlainText -force  'Password1234')

# pasted this output into the TEST01.yml
#'[ENC=PE9ianMgVmVyc2lvbj0iMS4xLjAuMSIgeG1sbnM9Imh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vcG93ZXJzaGVsbC8yMDA0LzA0Ij4NCiAgPE9iaiBSZWZJZD0iMCI+DQogICAgPFROIFJlZklkPSIwIj4NCiAgICAgIDxUPlN5c3RlbS5NYW5hZ2VtZW50LkF1dG9tYXRpb24uUFNDdXN0b21PYmplY3Q8L1Q+DQogICAgICA8VD5TeXN0ZW0uT2JqZWN0PC9UPg0KICAgIDwvVE4+DQogICAgPE1TPg0KICAgICAgPE9iaiBOPSJLZXlEYXRhIiBSZWZJZD0iMSI+DQogICAgICAgIDxUTiBSZWZJZD0iMSI+DQogICAgICAgICAgPFQ+U3lzdGVtLk9iamVjdFtdPC9UPg0KICAgICAgICAgIDxUPlN5c3RlbS5BcnJheTwvVD4NCiAgICAgICAgICA8VD5TeXN0ZW0uT2JqZWN0PC9UPg0KICAgICAgICA8L1ROPg0KICAgICAgICA8TFNUPg0KICAgICAgICAgIDxPYmogUmVmSWQ9IjIiPg0KICAgICAgICAgICAgPFROUmVmIFJlZklkPSIwIiAvPg0KICAgICAgICAgICAgPE1TPg0KICAgICAgICAgICAgICA8UyBOPSJIYXNoIj5EOUZFNEJENkJDQ0JENjY3MUFGOTlGREZDQTBBRUUxRjMxOTIwRUZEQjYzNjUxOUZGNTVDM0UyNzg2RUU2QkQzPC9TPg0KICAgICAgICAgICAgICA8STMyIE49Ikl0ZXJhdGlvbkNvdW50Ij41MDAwMDwvSTMyPg0KICAgICAgICAgICAgICA8QkEgTj0iS2V5Ij5hOCtmN1ZtblFwYWVGRGRpVlpmSms4VFFNQU02S1NpQWtYMlIwZ1BldFRmSDd4MFU0aEErL205S1ZDSWt0U04wPC9CQT4NCiAgICAgICAgICAgICAgPEJBIE49Ikhhc2hTYWx0Ij53cGtlV0JjcnNUNTJFcU5qQW1KczhXL2JTZW9WZ050YWhKMkQzY0hpQXJRPTwvQkE+DQogICAgICAgICAgICAgIDxCQSBOPSJTYWx0Ij5VU2tobnUybElsNHF5enl2OVNESnVxQzc1MnQ4RGFRRlBpeWN5dHpqSEdRPTwvQkE+DQogICAgICAgICAgICAgIDxCQSBOPSJJViI+R204eUpQT2MzdWhyMFgyNEp4bkswcDF2K2pMZ2ZyVGgycm5xWWU3VVl0WT08L0JBPg0KICAgICAgICAgICAgPC9NUz4NCiAgICAgICAgICA8L09iaj4NCiAgICAgICAgPC9MU1Q+DQogICAgICA8L09iaj4NCiAgICAgIDxCQSBOPSJDaXBoZXJUZXh0Ij5CSTA4ckxENlR6N0x4dWVvK091T1lLbzY5ZDQ4V0MzRUZKSVRlT0J2QUNvPTwvQkE+DQogICAgICA8QkEgTj0iSE1BQyI+TXdudldwRUJDd0ZMaDgyV0EyU2NjdEpMQ2wyOEZKdHd0V1hYM3dXN0JIWT08L0JBPg0KICAgICAgPFMgTj0iVHlwZSI+U3lzdGVtLlNlY3VyaXR5LlNlY3VyZVN0cmluZzwvUz4NCiAgICA8L01TPg0KICA8L09iaj4NCjwvT2Jqcz4=]'

$node = $datum.AllNodes.Test.TEST01
Lookup -PropertyPath SqlServer\InstallFeatures -DatumTree $datum -verbose # works
Lookup -PropertyPath SqlServer\SaPassword -DatumTree $datum -verbose  # works

$SecurePassword = Lookup -PropertyPath SqlServer\SaPassword -DatumTree $datum -verbose  # works

# check the value
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

# trying at the top level
$val = Lookup -PropertyPath SqlServer -DatumTree $datum -Node $node
$val.SaPassword

tree /f .
<#
C:\USERS\jess\DOCUMENTS\SECUREDATUM
└───DSC_ConfigData
    │   Datum.yml
    │
    ├───AllNodes
    │   ├───Dev
    │   │       DEV01.yml
    │   │
    │   ├───Prod
    │   └───Test
    │           TEST01.yml
    │
    ├───Environment
    │       Dev.yml
    │       Prod.yml
    │       Test.yml
    │
    └───Roles
            DscBaseline.yml
            ServerBaseline.yml
            SqlServer.yml
#>