::Swifter.QueueBucket.Late.push(function() {
	// Speed up based on VirtualSpeed.
	local teleport_6 = ::TacticalNavigator["__sqrat_ol_ teleport_6"];
	::TacticalNavigator["__sqrat_ol_ teleport_6"] <- { function teleport( _user, _targetTile, _func, _data, _bool, _speedMult )
	{
		teleport_6(_user, _targetTile, _func, _data, _bool, _speedMult * ::Time.getVirtualSpeed());
	}}.teleport;
});
