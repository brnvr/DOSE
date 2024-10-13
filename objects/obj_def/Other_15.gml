/// @description Sets default dialogues

var hints = [];

hints[hint_types.go_to_room] = [
	"Go to room {door_number}."
]

hints[hint_types.go_back_one_room] = [
	"You're cold. Go back one room.",
	"Wrong direction. Go back the way you came."
]

hints[hint_types.go_to_another_floor] = [
	"Go {direction}stairs.",
	"Go {direction} one floor."
]

hints[hint_types.talk_to_someone] = [
	 "Talk to {name}. {s_pronoun}'s got a hint for you.",
	 "I've heard {name} knows something. Why don't you talk to {o_pronoun}?"
]

hints[hint_types.find_item] = [
	"Find {article} {name}."
]

global.default_dialogues = {
	"miscelaneous": [
		"Time's dance echoes forgotten dreams in the cosmic corridors.",
		"Surreal clock hands mock linearity in a timeless waltz.",
		"Moonlit shadows whisper secrets in the enigmatic theater of night.",
		"Emotions paint consciousness in a blurred kaleidoscope of self.",
		"Thoughts float weightlessly, colliding in a gravity-defying void.",
		"Laughter echoes through parallel universes, joy and sorrow united.",
		"Mirrors reflect fractured alternate selves with untold stories.",
		"Dreams flutter like ephemeral butterflies, leaving desires' residue.",
		"Time unravels destiny's threads in a tapestry of possibilities.",
		"Raindrops carry memories, falling like liquid whispers.",
		"Surreal carnival tents unfold in the theater of the mind.",
		"Celestial books written in stardust fill the cosmos' library.",
		"Quantum thoughts blur chaos and order in a cosmic ballet.",
		"The soul navigates an introspective labyrinth with reflective mirrors.",
		"Whispers linger in heartbeat gaps, a cosmic symphony playing.",
		"Celestial dialects converse, stars sharing universe secrets.",
		"Solitude's symphony echoes through introspective rooms.",
		"Reality wears a paradox mask, concealing life's enigmatic dance.",
		"Silver tears weep from the moon, telling tales of lost wishes.",
		"Shadows, transient companions, whisper truths in the cosmic dance."
	],
	
	"hints": hints
}