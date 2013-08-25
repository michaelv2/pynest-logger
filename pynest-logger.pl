#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

# FIELD DESCRIPTIONS:
#	name			thermostat description
# 	current_temperature	actual temperature
# 	target_temperature	thermostat setting
#	current_humidity	actual humidity
#	auto_away		is auto-away currently on
#	fan_control_state	is fan currently on/off
#	fan_cooling_state	is cooling currently on/off
#	hvac_heater_state	is heat currently on/off
#	fan_mode		on/auto/duty-cycle
#	hvac_fan_state		does HVAC unit have fan?
#	can_cool		does HVAC unit support cooling
#	can_heat		does HVAC unit support heating
#	temperature_scale	C/F
#	leaf			leaf setting

# user configuration 
my $outfile = '/Path/to/logfile';		# logfile location
my @thermostats = (0,1);			# thermostat index numbers (use 0 for a single thermostat)
my $user = 'your_nest_username';
my $pass = 'your_nest_password';
my $pynest = '/Path/to/nest.py';

# variables to log
my @logged = ( qw(
	name current_temperature target_temperature current_humidity auto_away fan_control_state fan_cooling_state 
	hvac_heater_state fan_mode hvac_fan_state can_cool can_heat temperature_scale leaf
) );

# query API
foreach ( @thermostats ) {
	my %data;
	my $query = `$pynest --user $user --password $pass --index $_ show`;
	my @rows = split( /\n/, $query );
	foreach ( @rows ) {
		my @values = split( /\.+: /, $_ );
	 	$data{$values[0]} = $values[1];
	}

	# write log
	my $fh;
	unless (-e $outfile) {
		open( $fh, '>>', $outfile ) or die "Couldn't open log file: $!";
	 	say $fh join( "\t", "Time", @logged );
	}
	open( $fh, '>>', $outfile ) or die "Couldn't open log file: $!";
	say $fh join( "\t", time, @data{@logged} );
	close( $fh );
}
