::Swifter <- {
	ID = "mod_swifter",
	Name = "Swifter",
	Version = "1.2.0",
	EnableSpeed = true,
	Delays = {
		NewTurnDelayWithFasterMovement = ::Const.AI.Agent.NewTurnDelayWithFasterMovement,
		NewTurnDelay = ::Const.AI.Agent.NewTurnDelay,
		NewEvaluationDelay = ::Const.AI.Agent.NewEvaluationDelay,
		CameraAdditionalDelay = ::Const.AI.Agent.CameraAdditionalDelay
	},
	QueueBucket = {
		Late = []
	}
}
::Swifter.HookMod <- ::Hooks.register(::Swifter.ID, ::Swifter.Version, ::Swifter.Name);
::Swifter.HookMod.require("mod_msu >= 1.2.0-rc.1");
::Swifter.HookMod.conflictWith("mod_legends < 16.0.0-alpha", "mod_autopilot [Use Hackflow's 'Autopilot New' instead]", "quicker", "mod_faster", "mod_fastest");

::Swifter.HookMod.queue(">mod_msu", "<mod_legends", function(){
	::Swifter.Mod <- ::MSU.Class.Mod(::Swifter.ID, ::Swifter.Version, ::Swifter.Name);
	::Swifter.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/Enduriel/Battle-Brothers-Swifter");
	::Swifter.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);
	::Swifter.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.NexusMods, "https://www.nexusmods.com/battlebrothers/mods/542");

	::Const.World.SpeedSettings.VeryfastMult <- 4.0;
	::Const.World.SpeedSettings.SuperfastMult <- 8.0;

	::Const.World.SpeedSettings.EscortMult = ::Const.World.SpeedSettings.VeryfastMult;
	::Const.World.SpeedSettings.CampMult = ::Const.World.SpeedSettings.FastMult;

	local setSpeedMult = ::World.setSpeedMult;
	::World.setSpeedMult = function( _mult )
	{
		if (::Swifter.EnableSpeed || _mult == 0.0)
		{
			setSpeedMult(_mult);
		}
		else
		{
			::Swifter.EnableSpeed = true
		}
	}

	::include("swifter/msu");
	foreach (file in ::IO.enumerateFiles("swifter/hooks"))
	{
		::include(file);
	}

	::include("swifter/msu");
	foreach (file in ::IO.enumerateFiles("swifter/hooks"))
	{
		::include(file);
	}
	::Hooks.registerJS("ui/mods/swifter/swifter.js");
	::Hooks.registerJS("ui/mods/swifter/turnsequencebar_module.js");
	::Hooks.registerJS("ui/mods/swifter/world_screen_topbar_daytime_module.js");
	::Hooks.registerLateJS("ui/mods/swifter/store_turnsequencebar_values.js");
	::Hooks.registerCSS("ui/mods/swifter/css/world_screen_topbar_daytime_module.css");
});

::Swifter.HookMod.queue(function(){
	foreach (func in ::Swifter.QueueBucket.Late)
	{
		func();
	}
}, ::Hooks.QueueBucket.Late);
