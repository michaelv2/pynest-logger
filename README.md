pynest-logger
=============

Script to log Nest thermostat details, using the output from the excellent [pynest](https://github.com/smbaker/pynest) script.

To use this logger, first download pynest, then edit lines 24-28 specifying your Nest login credentials and where to save the output:

```perl
my $outfile = '/Path/to/logfile';   # logfile location
my @thermostats = (0,1);			# thermostat index numbers (use 0 for a single thermostat)
my $user = 'your_nest_username';
my $pass = 'your_nest_password';
my $pynest = '/Path/to/nest.py';
```

Then add a cron job for the desired frequency:

    $ crontab -e

To run every minute of every day, for example, enter:

    * * * * * /path/to/your/repo/pynest-logger.pl

What's Logged?
--------------

The data file contains the following values, tab separated:

1. Timestamp, epoch format
2. Thermostat name
3. Current temperature
4. Target temperature
5. Current humidity
6. Auto-away status
7. Current fan control status
8. Current cooling status
9. Current heating status
10. Fan mode (on/auto/duty-cycle)
11. Fan on/off
12. HVAC cooling support
13. HVAC heating support
14. Nest temperature scale setting
15. Nest leaf status

The log file has the following format:
--------------------------
```
       Time      name current_temperature target_temperature current_humidity auto_away fan_control_state hvac_ac_state hvac_heater_state
 1377291009  Upstairs               25.31      25.3390000000               59         0             False         False             False
 1377291010   Kitchen               25.85      25.5555555556               60         0             False         False             False
    fan_mode hvac_fan_state can_cool can_heat temperature_scale   leaf
  duty-cycle          False     True    False                 F  False
  duty-cycle          False     True    False                 F  False
```

How much space does the log take?
---------------------------------
A single entry in the sample above is around 100 bytes. 

Logging one thermostat every minute for a year should use around 50 MB.

Using the Data
--------------
More scripts to make fancy charts and graphs from the data are on the way!
