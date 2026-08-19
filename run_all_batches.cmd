@echo off
cd /d "%~dp0"
start "Test batch 1" cmd /k run_batch_1.cmd
start "Test batch 2" cmd /k run_batch_2.cmd
start "Test batch 3" cmd /k run_batch_3.cmd
