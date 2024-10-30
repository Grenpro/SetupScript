rem Download file using bitsadmin
bitsadmin /transfer downloadJob /download /priority high https://us.download.nvidia.com/nvapp/client/10.0.3.163/NVIDIA_app_beta_v10.0.3.163.exe C:\NvidiaDriver.exe

rem Run file
C:\NvidiaDriver.exe -s
