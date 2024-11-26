*** Settings ***
Resource    ./../../Keywords/common.resource
Resource    ./../../Variables/config.resource
Library    ./../../Libraries/time_1.py
Resource   ./../../Keywords/bus.resource
*** Test Cases ***
verify the filter for pick up time 
  filter for pick up time  filtertype=Pick up time - Thiruvananthapuram  timeofpickup=11 AM to 6 PM  starttime=11:00 AM  endtime=6:00 PM