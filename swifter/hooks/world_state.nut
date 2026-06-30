::Swifter.HookMod.hook("scripts/states/world_state", function (q)
{
	q.onInitUI = @(__original) function()
	{
		__original();
		local dayTimeModule = this.m.WorldScreen.getTopbarDayTimeModule();
		dayTimeModule.setOnTimeVeryfastPressedListener(this.setVeryfastTime.bindenv(this));
		dayTimeModule.setOnTimeSuperfastPressedListener(this.setSuperfastTime.bindenv(this));
	}

	q.swifter_updateSpeeds <- function()
	{
		if (this.World.getSpeedMult() == ::Const.World.SpeedSettings.VeryfastMult)
		{
			this.World.TopbarDayTimeModule.updateTimeButtons(3);
		}
		else if (this.World.getSpeedMult() == ::Const.World.SpeedSettings.SuperfastMult)
		{
			this.World.TopbarDayTimeModule.updateTimeButtons(4);
		}
	}

	q.onUpdate = @(__original) function()
	{
		if (::World.Assets.isCamping() || (this.m.EscortedEntity != null && !this.m.EscortedEntity.isNull() && this.m.EscortedEntity.isAlive()))
		{
			::Swifter.EnableSpeed = false;
		}
		__original();
		::Swifter.EnableSpeed = true;
	}

	q.setPause = @(__original) function( _f )
	{
		__original(_f);
		if (("TopbarDayTimeModule" in this.World) && this.World.TopbarDayTimeModule != null)
		{
			if (this.m.IsGamePaused) return;
			this.swifter_updateSpeeds();
		}
	}

	q.setEscortedEntity = @(__original) function( _e, _fastEscort = false )
	{
		__original(_e, _fastEscort);
		if (this.m.EscortedEntity != null && !this.m.EscortedEntity.isNull() && this.m.EscortedEntity.isAlive())
		{
			this.swifter_updateSpeeds();
		}
	}

	q.onCamp = @(__original) function()
	{
		__original();
		if (this.World.Assets.isCamping())
		{
			this.swifter_updateSpeeds();
		}
	}

	q.swifter_setSpeedMults <- function()
	{
		if (!this.m.MenuStack.hasBacksteps())
		{
			if (this.World.Assets.isCamping()) this.m.LastWorldSpeedMult = ::Const.World.SpeedSettings.CampMult;
			if (this.m.EscortedEntity != null) this.m.LastWorldSpeedMult = ::Const.World.SpeedSettings.EscortMult;
		}
	}

	q.setNormalTime = @(__original) function()
	{
		this.swifter_setSpeedMults();
		if (!this.m.MenuStack.hasBacksteps())
		{
			this.m.LastWorldSpeedMult = 1.0;
		}
		__original();
	}

	q.setFastTime = @(__original) function()
	{
		this.swifter_setSpeedMults();
		if (!this.m.MenuStack.hasBacksteps())
		{
			this.m.LastWorldSpeedMult = ::Const.World.SpeedSettings.FastMult;
		}
		__original();
	}

	q.setVeryfastTime <- function()
	{
		this.swifter_setSpeedMults();
		if (!this.m.MenuStack.hasBacksteps())
		{
			this.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.VeryfastMult;
			this.setPause(false);
		}
	}

	q.setSuperfastTime <- function()
	{
		this.swifter_setSpeedMults();
		if (!this.m.MenuStack.hasBacksteps())
		{
			this.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.SuperfastMult;
			this.setPause(false);
		}
	}
});
