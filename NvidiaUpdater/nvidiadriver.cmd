rem Download file using bitsadmin
bitsadmin /transfer downloadJob /download /priority high https://us.download.nvidia.com/nvapp/client/11.0.4.526/NVIDIA_app_v11.0.4.526.exe C:\NvidiaDriver.exe

rem Run file
C:\NvidiaDriver.exe -s

