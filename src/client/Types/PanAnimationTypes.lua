local Types = {}

export type ScalingAnimationType = {
	InitialScale: number,
	TargetScale: number,
	Duration: number,
	EasingStyle: Enum.EasingStyle,
	EasingDirection: Enum.EasingDirection,
	ScaleValue: NumberValue,
	Tween: Tween?,
	Init: (self: ScalingAnimationType) -> (),
}

export type FlippingAnimationType = {
    Tween: Tween?
}

export type AnimationType = {
	Components: {
		ScalingAnimation: ScalingAnimationType,
		FlippingAnimation: FlippingAnimationType -- You can define this when you're ready
	},
	Init: (self: AnimationType) -> (),
	Play: (self: AnimationType) -> (),
	Cleanup: (self: AnimationType) -> (),
}

return Types